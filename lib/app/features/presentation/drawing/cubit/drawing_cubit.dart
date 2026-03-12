import 'dart:async';

import 'package:berry_board/app/common/constants/app_colors.dart';
import 'package:berry_board/app/features/domain/entities/drawing_stroke_entity.dart';
import 'package:berry_board/app/features/domain/usecases/drawing/send_stroke_usecase.dart';
import 'package:berry_board/app/features/domain/usecases/drawing/watch_canvas_usecase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_drawing_board/flutter_drawing_board.dart';
import 'package:flutter_drawing_board/paint_contents.dart';

import 'drawing_state.dart';

class DrawingCubit extends Cubit<DrawingState> {
  final String _currentUid;
  final WatchCanvasUsecase _watchCanvasUsecase;
  final SendStrokeUsecase _sendStrokeUsecase;
  String? _lastProcessedSignature;

  StreamSubscription? _canvasSubscription;

  DrawingCubit({
    required String currentUid,
    required WatchCanvasUsecase watchCanvasUsecase,
    required SendStrokeUsecase sendStrokeUsecase,
  }) : _currentUid = currentUid ,_watchCanvasUsecase = watchCanvasUsecase,
       _sendStrokeUsecase = sendStrokeUsecase,
       super(
         DrawingState(
           drawingController: DrawingController(
             config: DrawConfig(
               contentType: SimpleLine,
               color: AppColors.black,
               strokeWidth: 2,
             ),
           ),
         ),
       );

  void onDrawingFinished(PaintContent content) {
   final points = _extractPoints(content);
   if(points.isEmpty) {
     return;
   }

   _lastProcessedSignature = "${state.strokes.length + 1}_${points.last.x}_${points.last.y}";

    final stroke = DrawingStrokeEntity(
      points: points,
      colorValue: content.paint.color.toARGB32(),
      strokeWidth: content.paint.strokeWidth,
      authorId: _currentUid,
      timestamp: DateTime.now(),
    );
    sendStroke(stroke);
    debugPrint("upload is done");
  }

 List<StrokePoint> _extractPoints(PaintContent content) {
    if (content is SmoothLine) {
      return content.points.map((point) => StrokePoint(point.dx, point.dy)).toList();
    }

    if (content is SimpleLine) {
      final points = content.points ?? const [];
      return points.map((point) => StrokePoint(point.dx, point.dy)).toList();
    }

    return const [];
  }

void _updateControllerWithRemoteStrokes(List<DrawingStrokeEntity> strokes) {
  if (strokes.isEmpty) {
    state.drawingController.clear();
    _lastProcessedSignature = "empty";
    return;
  }

  final lastStroke = strokes.last;
  final lastPoint = lastStroke.points.last;
  
  final String currentSignature = "${strokes.length}_${lastPoint.x}_${lastPoint.y}";

  if (currentSignature == _lastProcessedSignature) {
    debugPrint("Kendi işlemim 🍓");
    return;
  }

  _lastProcessedSignature = currentSignature;
  state.drawingController.clear();

  final List<PaintContent> remoteContents = strokes.map((stroke) {
    final offsets = stroke.points.map((p) => Offset(p.x, p.y)).toList();

    return SmoothLine.data(
      points: offsets,
      strokeWidthList: List<double>.filled(offsets.length, stroke.strokeWidth),
      paint: Paint()
        ..color = Color(stroke.colorValue)
        ..strokeWidth = stroke.strokeWidth
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round,
    );
  }).toList();

  if (remoteContents.isNotEmpty) {
    state.drawingController.addContents(remoteContents);
  }
}

Future<void> initialize() async {
  emit(state.copyWith(status: DrawingStatus.loading));

  try {
    final userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(_currentUid)
        .get();

    final roomId = userDoc.data()?['currentRoomId'] as String?;

    if (roomId != null && roomId.isNotEmpty) {
      emit(state.copyWith(roomId: roomId, status: DrawingStatus.success));
      startWatchingCanvas(roomId); 
      
      debugPrint("🍓 Eşleşme doğrulandı! RoomId: $roomId");
    } else {
      debugPrint("🚨 Kullanıcının bir odası yok!");
      emit(state.copyWith(status: DrawingStatus.error, errorMessage: "Oda bulunamadı"));
    }
  } catch (e) {
    debugPrint("🚨 initialize hatası: $e");
    emit(state.copyWith(status: DrawingStatus.error, errorMessage: e.toString()));
  }
}

  void startWatchingCanvas(String roomId) {
    emit(state.copyWith(status: DrawingStatus.loading,roomId: roomId));

    _canvasSubscription?.cancel();

    _canvasSubscription = _watchCanvasUsecase(roomId).listen(
      (result) {
        if (result.success) {
          _updateControllerWithRemoteStrokes(result.data ?? []);
          emit(
            state.copyWith(status: DrawingStatus.success, strokes: result.data),
          );
        } else {
          emit(
            state.copyWith(
              status: DrawingStatus.error,
              errorMessage: result.message,
            ),
          );
        }
      },
      onError: (error, stackTrace) {
        emit(
          state.copyWith(
            status: DrawingStatus.error,
            errorMessage: error.toString(),
          ),
        );
      },
    );
  }

  Future<void> sendStroke(DrawingStrokeEntity stroke) async {
    final result = await _sendStrokeUsecase(stroke);

    if (!result.success) {
      emit(state.copyWith(errorMessage: result.message));
    }
  }

  @override
  Future<void> close() {
    _canvasSubscription?.cancel();
    return super.close();
  }
}
