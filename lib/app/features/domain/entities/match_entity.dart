class MatchEntity {
  final String roomId;
  final String partnerId;
  final bool isActive;

  MatchEntity({
    required this.roomId,
    this.isActive = true,
    required this.partnerId,
  });
}
