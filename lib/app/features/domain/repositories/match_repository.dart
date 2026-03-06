import 'package:berry_board/app/features/domain/entities/match_entity.dart';
import 'package:berry_board/core/result/result.dart';

abstract class IMatchRepository {
  Future<Result<String>> generateMatchCode();
  Future<Result<MatchEntity>> joinRoom(String code);
  //burada belki sonradan partnerId de alır partnerId nullarım
  Future<Result<void>> leaveRoom(String roomId);
}
