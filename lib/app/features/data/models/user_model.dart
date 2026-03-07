import 'package:berry_board/app/features/domain/entities/user_entity.dart';

class UserModel {
  final String uid;
  final String? partnerId;
  final String? currentRoomId;

  UserModel({required this.uid, this.partnerId, this.currentRoomId});

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      partnerId: map['partnerId'] as String?,
      currentRoomId: map['currentRoomId'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {'uid': uid, 'partnerId': partnerId, 'currentRoomId': currentRoomId};
  }

  UserEntity toEntity() {
    return UserEntity(
      uid: uid,
      partnerId: partnerId,
      currentRoomId: currentRoomId,
    );
  }
}
