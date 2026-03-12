import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum HomeStatus { initial, loading, success, error, roomJoined}

class HomeState extends Equatable {
  final TextEditingController textEditingController;
  final String? errorMessage;
  final HomeStatus status;
  final String? generatedCode;

  const HomeState({
    required this.textEditingController,
    this.status = HomeStatus.initial,
    this.errorMessage,
    this.generatedCode,
  });

  HomeState copyWith({
    HomeStatus? status,
    String? errorMessage,
    TextEditingController? textEditingController,
    String? generatedCode,
  }) {
    return HomeState(
      textEditingController:
          textEditingController ?? this.textEditingController,
      errorMessage: errorMessage ?? this.errorMessage,
      status: status ?? this.status,
      generatedCode: generatedCode ?? this.generatedCode
    );
  }

  @override
  List<Object?> get props => [status, errorMessage, textEditingController, generatedCode];
}
