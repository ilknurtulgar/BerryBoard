import '../../../../core/result/result.dart';
import '../entities/match_entity.dart';

abstract class IMatchRepository {
  Future<Result<String>> generateMatchCode();
  Future<Result<MatchEntity>> joinRoom(String code);
  //burada belki sonradan partnerId de alır partnerId nullarım
  Future<Result<void>> leaveRoom(String roomId);
}
