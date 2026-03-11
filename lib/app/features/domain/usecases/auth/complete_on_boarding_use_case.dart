import 'package:berry_board/app/features/data/datasources/local_storage_datasource.dart';

class CompleteOnBoardingUseCase {
  final ILocalStorageDataSource _localStorageDataSource;

  CompleteOnBoardingUseCase(this._localStorageDataSource);

  Future<void> call() async {
    await _localStorageDataSource.setOnboardingSeen();
  }
}
