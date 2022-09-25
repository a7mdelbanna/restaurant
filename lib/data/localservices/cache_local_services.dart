import 'package:shared_preferences/shared_preferences.dart';

class SharedCache {
  static SharedPreferences? sharedPreferences;

  static cacheInit() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static setPhoneUID(phone, uid) {
    sharedPreferences!.setString(phone, uid);
  }

  static setLastNotCompletedRegister(phone) {
    sharedPreferences!.setString('notCompleted', phone);
  }

  static String? getUIDByPhone(phone) {
    return sharedPreferences!.getString(phone);
  }

  static String? getLastNotCompleted(key) {
    return sharedPreferences!.getString(key);
  }
  //
  // static setCompleted(key, value) {
  //   sharedPreferences!.setBool(key, value);
  // }

  static setRegisterCompleted(key, value) {
    sharedPreferences!.setInt(key, value);
  }

  static setKeepLogged(key, value) {
    sharedPreferences!.setBool(key, value);
  }

  static setLastLoggedIn(key, value) {
    sharedPreferences!.setString(key, value);
  }

  static bool? getKeepLogged(key) {
    return sharedPreferences!.getBool(key);
  }

  static String? getLastLoggedIn(key) {
    return sharedPreferences!.getString(key) ?? '';
  }
}
