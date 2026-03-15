import 'dart:async';

import 'package:berry_board/app/features/domain/usecases/match/create_match_and_get_code_usecase.dart';
import 'package:berry_board/app/features/domain/usecases/match/join_room_usecase.dart';
import 'package:berry_board/app/features/domain/usecases/match/watch_match_usecase.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final CreateMatchAndGetCodeUsecase _createMatchAndGetCodeUsecase;
  final JoinRoomUsecase _joinRoomUsecase;
  final WatchMatchUsecase _watchMatchUsecase;

  HomeCubit(this._watchMatchUsecase, this._joinRoomUsecase, this._createMatchAndGetCodeUsecase)
  : super(HomeState(textEditingController: TextEditingController()));

  StreamSubscription? _matchSubscription;
  
  void onChangedValue(String code){
    if(code.length == 6){
      joinRoom(code);
    }
  }
    TextEditingController get getTextEditingController => state.textEditingController;

  Future<void> joinRoom(String code) async{
    emit(state.copyWith(status: HomeStatus.loading));

    final result =  await _joinRoomUsecase.call(code);
    if(result.success){
      emit(state.copyWith(status: HomeStatus.success));
    }else {
      emit(state.copyWith(status: HomeStatus.error, errorMessage: result.message));
    }
  }

  Future<void> createRoom()async{
    emit(state.copyWith(status: HomeStatus.loading));
    final result = await _createMatchAndGetCodeUsecase.call();
    if(result.success){
      emit(state.copyWith(status: HomeStatus.initial, generatedCode: result.data));
     _startListeningForMatch(result.data!);
    }else {
      emit(state.copyWith(status: HomeStatus.error, errorMessage:  result.message));
    }
  }

  void _startListeningForMatch(String code){
    _matchSubscription?.cancel();
   _matchSubscription = _watchMatchUsecase.call(code).listen((result){
    if(result.success && result.data != null){
      if (result.data!.guestId != null && result.data!.guestId!.isNotEmpty) {
        emit(state.copyWith(status: HomeStatus.roomJoined));
      }
    }
   });
  }

  void clearController(){
    state.textEditingController.clear();
  }

  @override
  Future<void> close() {
    state.textEditingController.dispose();
    _matchSubscription?.cancel();
    return super.close();
  }
}