import '../../../../core/result/result.dart';
import '../entities/match_entity.dart';

abstract class IMatchRepository {
  Future<Result<String>> createMatchAndGetCode();
  Future<Result<MatchEntity>> joinRoom(String code);
  Future<Result<void>> leaveRoom(String roomId);
  Stream<Result<MatchEntity>> watchMatch(String matchCode);
}
