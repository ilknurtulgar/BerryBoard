import 'package:berry_board/app/features/data/datasources/auth_remote_data_source.dart';
import 'package:berry_board/app/features/data/datasources/drawing_remote_data_source.dart';
import 'package:berry_board/app/features/data/datasources/user_remote_data_source.dart';
import 'package:berry_board/app/features/data/models/drawing_stroke_model.dart';
import 'package:berry_board/app/features/domain/entities/drawing_stroke_entity.dart';

import 'package:berry_board/core/result/result.dart';


import '../../../common/constants/app_strings.dart';
import '../../domain/repositories/drawing_stroke_repository.dart';
import 'base_repository.dart';

class DrawingStrokeRepositoryImpl with BaseRepository implements IDrawingStrokeRepository {
  final IDrawingRemoteDataSource _dataSource;
  final IUserRemoteDataSource _iUserRemoteDataSource;
  final IAuthRemoteDataSource _authRemoteDataSource;
  DrawingStrokeRepositoryImpl(this._dataSource,this._iUserRemoteDataSource,this._authRemoteDataSource);

  @override
  Future<Result<void>> clearCanvas(String roomId) {
    return safeCall(() => _dataSource.clearCanvas(roomId));
  }

  @override
  Future<Result<void>> sendStroke(DrawingStrokeEntity stroke) async {
    final uid = _authRemoteDataSource.currentUid;
    if (uid == null) {
      return Result.error(message: AppStrings.error);
    }

    final user = await _iUserRemoteDataSource.getUser(uid);
    if (user == null) {
      return Result.error(message: AppStrings.error);
    }

    final roomId = user.currentRoomId;
    if (roomId == null || roomId.isEmpty) {
      return Result.error(message: AppStrings.error);
    }

    final model = DrawingStrokeModel(
      points: stroke.points,
      colorValue: stroke.colorValue,
      strokeWidth: stroke.strokeWidth,
      authorId: stroke.authorId,
    );

    return safeCall(() async {
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