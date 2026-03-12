import 'package:berry_board/app/features/domain/usecases/auth/get_initial_route_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/constants/app_strings.dart';
import 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final GetInitialRouteUseCase _getInitialRouteUseCase;

  SplashCubit(this._getInitialRouteUseCase) : super(const SplashState()) {
    checkStatus();
  }

  Future<void> checkStatus() async {
    emit(state.copyWith(status: SplashStatus.loading));

    await Future.delayed(const Duration(seconds: 2));

    final result = await _getInitialRouteUseCase.call();

    if (result.success) {
      final user = result.data;
      if (user == null) {
        emit(state.copyWith(status: SplashStatus.onboarding));
      } else {
        if (user.isMatched) {
          emit(
            state.copyWith(
              status: SplashStatus.drawing,
              roomId: user.currentRoomId!,
            ),
          );
        } else {
          emit(state.copyWith(status: SplashStatus.home));
        }
      }
    } else {
      emit(
        state.copyWith(
          status: SplashStatus.error,
          errorMessage: result.message ?? AppStrings.statusError,
        ),
      );
      debugPrint("splashcubit: ${result.message}");
    }
  }
}
