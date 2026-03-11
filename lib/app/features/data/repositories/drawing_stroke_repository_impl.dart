import 'package:berry_board/app/features/data/datasources/drawing_remote_data_source.dart';
import 'package:berry_board/app/features/data/models/drawing_stroke_model.dart';
import 'package:berry_board/app/features/domain/entities/drawing_stroke_entity.dart';

import 'package:berry_board/core/result/result.dart';

import '../../domain/repositories/drawing_stroke_repository.dart';
import 'base_repository.dart';

class DrawingStrokeRepositoryImpl with BaseRepository implements IDrawingStrokeRepository {
  final IDrawingRemoteDataSource _dataSource;
  DrawingStrokeRepositoryImpl(this._dataSource);

  @override
  Future<Result<void>> clearCanvas(String roomId) {
    return safeCall(() => _dataSource.clearCanvas(roomId));
  }

  @override
  Future<Result<void>> sendStroke(String roomId, DrawingStrokeEntity stroke) {
    return safeCall(()async {
      final model = DrawingStrokeModel(points: stroke.points,
      colorValue: stroke.colorValue,
      strokeWidth: stroke.strokeWidth,
      authorId: stroke.authorId);
      await _dataSource.sendStroke(roomId, model);
    });
  }

  @override
  Stream<Result<List<DrawingStrokeEntity>>> watchCanvas(String roomId) {
    return safeStream((){
      return _dataSource.watchCanvas(roomId).map((models)=> 
      models.map((model) => model.toEntity()).toList());
    });
  }
  
}