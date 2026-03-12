import 'package:berry_board/app/features/data/datasources/auth_remote_data_source.dart';
import 'package:berry_board/app/features/data/datasources/match_data_source.dart';
import 'package:berry_board/app/features/data/datasources/user_remote_data_source.dart';
import 'package:berry_board/app/features/data/models/match_model.dart';
import 'package:berry_board/app/features/data/repositories/base_repository.dart';
import 'package:berry_board/app/features/domain/entities/match_entity.dart';
import 'package:berry_board/app/features/domain/repositories/match_repository.dart';
import 'package:berry_board/core/result/result.dart';
import 'package:flutter/widgets.dart';

import '../../../common/constants/app_strings.dart';

class MatchRepositoryImpl with BaseRepository implements IMatchRepository {
  final IAuthRemoteDataSource _authRemoteDataSource;
  final IMatchDataSource _matchDataSource;
  final IUserRemoteDataSource _userRemoteDataSource;

  MatchRepositoryImpl({
    required IMatchDataSource matchDataSource,
    required IAuthRemoteDataSource authDataSource,
    required IUserRemoteDataSource userRemoteDataSource,
  }) : _matchDataSource = matchDataSource,
       _authRemoteDataSource = authDataSource,
       _userRemoteDataSource = userRemoteDataSource;

  @override
  Future<Result<String>> createMatchAndGetCode() async {
    final userError = _checkUserStatus<String>();
    if (userError != null) return userError;
    final uid = _authRemoteDataSource.currentUid!;
    return await safeCall(() async {
      final String code = _generateRandomCode(6);
      final String roomId = "room_${DateTime.now().microsecondsSinceEpoch}";

      final newMatch = MatchModel(
        roomId: roomId,
        matchCode: code,
        hostId: uid,
        isActive: true,
      );

      await _matchDataSource.createMatch(newMatch);
      return code;
    });
  }

  @override
  Future<Result<MatchEntity>> joinRoom(String code) async {
    final uid = _authRemoteDataSource.currentUid;
    if (uid == null) {
      debugPrint("joinroom :${AppStrings.userNotFound}");
      return Result.error(message: AppStrings.userNotFound);
    }

    final model = await _matchDataSource.getMatchByCode(code);
    if (model == null) {
      debugPrint("joinRoom :${AppStrings.invalidCode}");
      return Result.error(message: AppStrings.invalidCode);
    }
    if (model.hostId == uid) {
      debugPrint(AppStrings.invalidJoin);
      return Result.error(message: AppStrings.invalidJoin);
    }
    return await safeCall(() async {
      await _matchDataSource.setParticipant(model.roomId,model.hostId, uid);
      return model.toEntity();
    });
  }

  @override
  Future<Result<void>> leaveRoom(String roomId) async {
    final userError = _checkUserStatus<void>();
    if (userError != null) return userError;
    final uid = _authRemoteDataSource.currentUid!;

    return await safeCall(() async {
      final match = await _matchDataSource.getMatchById(roomId);
      if (match != null) {
        final partnerId = match.hostId == uid ? match.guestId : match.hostId;
        await _matchDataSource.updateMatchStatus(roomId, false);
        await _userRemoteDataSource.clearUserSession(uid);
        if (partnerId != null && partnerId.isNotEmpty) {
          await _userRemoteDataSource.clearUserSession(partnerId);
        }
      }
    });
  }

  String _generateRandomCode(int length) {
    const chars = '123456789';
    return List.generate(
      length,
      (index) => chars[DateTime.now().microsecond % chars.length],
    ).join();
  }

  Result<T>? _checkUserStatus<T>() {
    final uid = _authRemoteDataSource.currentUid;
    if (uid == null) {
      debugPrint("checkUserStatus :${AppStrings.userNotFound}");
      return Result.error(message: AppStrings.userNotFound);
    }
    return null;
  }
  
  @override
  Stream<Result<MatchEntity>> watchMatch(String matchCode) {
    return safeStream((){
     return _matchDataSource.watchMatchByCode(matchCode)
     .where((model) => model != null)
     .map((model){
        return model!.toEntity();
      });
    });
  }
}
