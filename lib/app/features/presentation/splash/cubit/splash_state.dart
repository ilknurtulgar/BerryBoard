import 'package:equatable/equatable.dart';

enum SplashStatus {initial, onboarding, home, loading, error, drawing}

class SplashState extends Equatable {
  final SplashStatus status;
  final String? roomId;
  final String? errorMessage;

  const SplashState({
    this.status = SplashStatus.initial,
    this.roomId,
    this.errorMessage,
  });

  SplashState copyWith({
    SplashStatus? status,
    String? roomId,
    String? errorMessage,
  }) {
    return SplashState(
      status: status ?? this.status,
      roomId: roomId ?? this.roomId,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, roomId, errorMessage];
}
