import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesProvider {
  static const _USER_ROLE = 'user-role';

  static SharedPreferences _prefs;

  static Future<SharedPreferencesProvider> getInstance() async {
    _prefs = await SharedPreferences.getInstance();
    return SharedPreferencesProvider._();
  }

  SharedPreferencesProvider._();

  Future<void> saveUserRole({int level = 0}) async {
    await _prefs.setInt(_USER_ROLE, level);
  }

  int get authLevel => _prefs.getInt(_USER_ROLE) ?? 0;
}

SharedPreferencesProvider sharedPreferences;
