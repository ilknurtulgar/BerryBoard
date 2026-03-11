import 'package:berry_board/app/features/domain/entities/match_entity.dart';

class MatchModel {
  final String roomId;
  final String hostId;
  final String? guestId;
  final String matchCode;
  final bool isActive;

  MatchModel({
    required this.roomId,
    required this.matchCode,
    required this.hostId,
    this.guestId,
    this.isActive = true,
  });

  factory MatchModel.fromEntity(MatchEntity entity) {
    return MatchModel(
      roomId: entity.roomId,
      hostId: entity.hostId,
      matchCode: entity.matchCode,
      guestId: entity.guestId,
      isActive: entity.isActive,
    );
  }

  factory MatchModel.fromMap(Map<String, dynamic> map) {
    return MatchModel(
      roomId: map['roomId'],
      matchCode: map['matchCode'],
      hostId: map['hostId'],
      guestId: map['guestId'],
      isActive: map['isActive'],
    );
  }

  MatchEntity toEntity() {
    return MatchEntity(
      roomId: roomId,
      matchCode: matchCode,
      hostId: hostId,
      guestId: guestId,
      isActive: isActive,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'roomId': roomId,
      'matchCode': matchCode,
      'hostId': hostId,
      'guestId': guestId,
      'isActive': isActive,
    };
  }

  String? getPartnerId(String currentUserId) {
    if (currentUserId == hostId) return guestId;
    if (currentUserId == guestId) return hostId;
    return null;
  }
}
