import 'package:berry_board/app/features/domain/entities/user_entity.dart';

class UserModel {
  final String uid;
  final String? partnerId;
  final String? currentRoomId;

  UserModel({required this.uid, this.partnerId, this.currentRoomId});
  //domain -> data. veriyi yazarken
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      partnerId: map['partnerId'] as String?,
      currentRoomId: map['currentRoomId'] as String?,
    );
  }
  //domain -> data
  factory UserModel.fromEntity(UserEntity entity){
    return UserModel(uid: entity.uid,
    currentRoomId: entity.currentRoomId,
    partnerId: entity.partnerId,);
  }

  factory UserModel.empty(String uid) => UserModel(uid: uid,
  currentRoomId: null,
  partnerId: null);
  //model -> enitiy
  Map<String, dynamic> toMap() {
    return {'uid': uid, 'partnerId': partnerId, 'currentRoomId': currentRoomId};
  }

  //data -> domain. veriyi okurken
  UserEntity toEntity() {
    return UserEntity(
      uid: uid,
      partnerId: partnerId,
      currentRoomId: currentRoomId,
    );
  }
}
