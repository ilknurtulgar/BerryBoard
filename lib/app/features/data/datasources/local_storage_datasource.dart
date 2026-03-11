import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/constants/app_strings.dart';

abstract class ILocalStorageDataSource {
  bool isOnboardingSeen();
  Future<void> setOnboardingSeen();
}

class LocalStorageDatasourceImpl implements ILocalStorageDataSource {
  final SharedPreferences _preferences;
  LocalStorageDatasourceImpl(this._preferences);
  
  @override
  bool isOnboardingSeen() => _preferences.getBool(AppStrings.onBoardingKey) ?? false;


  @override
  Future<void> setOnboardingSeen() async => await _preferences.setBool(AppStrings.onBoardingKey, true); 
  
}