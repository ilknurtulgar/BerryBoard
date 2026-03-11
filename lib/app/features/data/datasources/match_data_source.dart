import 'package:berry_board/app/features/data/models/match_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../common/constants/app_strings.dart';

abstract class IMatchDataSource {
  Future<void> createMatch(MatchModel model);
  Future<MatchModel?> getMatchByCode(String code);
  Future<void> updateMatchStatus(String roomId, bool isActive);
  Future<void> setParticipant(String roomId, String guestId);
  Future<MatchModel?> getMatchById(String roomId);
}

class MatchDataSourceImpl implements IMatchDataSource {
  final FirebaseFirestore _firestore;
  MatchDataSourceImpl(this._firestore);

  @override
  Future<void> createMatch(MatchModel model) async {
    await _firestore
        .collection(AppStrings.matchesPath)
        .doc(model.roomId)
        .set(model.toMap());
  }

  @override
  Future<MatchModel?> getMatchByCode(String code) async {
    final query = await _firestore
        .collection(AppStrings.matchesPath)
        .where(AppStrings.matchCode, isEqualTo: code)
        .where(AppStrings.isActive, isEqualTo: true)
        .limit(1)
        .get();

    if (query.docs.isEmpty) return null;

    return MatchModel.fromMap(query.docs.first.data());
  }

  @override
  Future<void> setParticipant(String roomId, String guestId) async {
    await _firestore.collection(AppStrings.matchesPath).doc(roomId).update({
      'guestId': guestId,
    });
  }

  @override
  Future<void> updateMatchStatus(String roomId, bool isActive) async {
    await _firestore.collection(AppStrings.matchesPath).doc(roomId).update({
      'isActive': isActive,
    });
  }
  
  @override
  Future<MatchModel?> getMatchById(String roomId)async {
    final doc = await _firestore
    .collection(AppStrings.matchesPath)
    .doc(roomId)
    .get();
      if(doc.data() != null) {
        return MatchModel.fromMap(doc.data()!);
      }
      return null;
  }
}
