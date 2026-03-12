import 'package:berry_board/app/features/data/models/match_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../../../common/constants/app_strings.dart';

abstract class IMatchDataSource {
  Future<void> createMatch(MatchModel model);
  Future<MatchModel?> getMatchByCode(String code);
  Future<void> updateMatchStatus(String roomId, bool isActive);
  Future<void> setParticipant(String roomId, String hostId ,String guestId);
  Future<MatchModel?> getMatchById(String roomId);
  Stream<MatchModel?> watchMatchByCode(String code);
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
  Future<void> setParticipant(String roomId, String hostId ,String guestId) async {
    final batch = _firestore.batch();

    batch.update(_firestore.collection(AppStrings.matchesPath).doc(roomId), {'guestId': guestId});

    batch.update(_firestore.collection(AppStrings.usersPath).doc(hostId), {
      'partnerId': guestId, 'currentRoomId': roomId});
    
    batch.update(_firestore.collection(AppStrings.usersPath).doc(guestId), {
      'partnerId': hostId, 'currentRoomId': roomId
    });
    await batch.commit();
  }

  @override
  Future<void> updateMatchStatus(String roomId, bool isActive) async {
    await _firestore.collection(AppStrings.matchesPath).doc(roomId).update({
      'isActive': isActive,
    });
  }

  @override
  Future<MatchModel?> getMatchById(String roomId) async {
    final doc = await _firestore
        .collection(AppStrings.matchesPath)
        .doc(roomId)
        .get();
    if (doc.data() != null) {
      return MatchModel.fromMap(doc.data()!);
    }
    return null;
  }

  @override
  Stream<MatchModel?> watchMatchByCode(String code) {
    debugPrint("[MatchDataSource] watchMatchByCode basladi. code=$code");
    return _firestore
        .collection(AppStrings.matchesPath)
        .where(AppStrings.matchCode, isEqualTo: code)
        .snapshots()
        .map((snapshot) {
          debugPrint(
            "[MatchDataSource] snapshot geldi. code=$code docCount=${snapshot.docs.length}",
          );
          if (snapshot.docs.isNotEmpty) {
            final data = snapshot.docs.first.data();
            debugPrint(
              "[MatchDataSource] ilk doc guestId=${data['guestId']} roomId=${data['roomId']} isActive=${data['isActive']}",
            );
            return MatchModel.fromMap(data);
          }
          debugPrint("[MatchDataSource] code=$code icin match bulunamadi.");
          return null;
        });
  }
}
