class UserEntity {
  final String uid;
  final String? partnerId;
  final String? currentRoomId;

  UserEntity({required this.uid, this.partnerId, this.currentRoomId});

  bool get isMatched => partnerId != null && currentRoomId != null;
}
