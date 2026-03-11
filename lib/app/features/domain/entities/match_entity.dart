class MatchEntity {
  final String roomId;
  final String hostId;
  final String? guestId;
  final String matchCode;
  final bool isActive;

  MatchEntity({
    required this.roomId,
    required this.matchCode,
    required this.hostId,
    this.guestId,
    this.isActive = true,
  });
}
