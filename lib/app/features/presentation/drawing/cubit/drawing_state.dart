import 'package:berry_board/app/features/domain/entities/drawing_stroke_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_drawing_board/flutter_drawing_board.dart';

enum DrawingStatus { initial, loading, success, error }

class DrawingState extends Equatable {
  final DrawingStatus status;
  final List<DrawingStrokeEntity> strokes;
  final String? errorMessage;
  final DrawingController drawingController;
  final String? roomId;

  const DrawingState({
    this.status = DrawingStatus.initial,
    this.strokes = const [],
    this.errorMessage,
    this.roomId,
    required this.drawingController
  });

  DrawingState copyWith({
    DrawingStatus? status,
    List<DrawingStrokeEntity>? strokes,
    String? errorMessage,
    DrawingController? drawingController,
    String? roomId,
  }) {
    return DrawingState(
      status: status ?? this.status,
      strokes: strokes ?? this.strokes,
      errorMessage: errorMessage ?? this.errorMessage,
      drawingController: drawingController ?? this.drawingController,
      roomId: roomId ?? this.roomId
    );
  }

  @override
  List<Object?> get props => [status, strokes, errorMessage, drawingController, roomId];
}
