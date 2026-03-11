import 'package:flutter/material.dart';
import '../../../../core/result/result.dart';

mixin BaseRepository {
  Future<Result<T>> safeCall<T>(Future<T> Function() request) async {
    try {
      final response = await request();
      return Result.success(data: response);
    } catch (e, stackTrace) {
      debugPrint("error: $e\n$stackTrace");
      return Result.error(message: e.toString());
    }
  }

  Stream<Result<T>> safeStream<T>(Stream<T> Function() streamRequest) async* {
    try {
      await for (final data in streamRequest()) {
        yield Result.success(data: data);
      }
    } catch (e, stackTrace) {
      debugPrint("Stream error: $e\n$stackTrace");
      yield Result.error(message: e.toString());
    }
  }
}
