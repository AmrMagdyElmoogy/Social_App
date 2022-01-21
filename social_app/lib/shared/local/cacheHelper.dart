import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static String getData(String key) {
    return sharedPreferences.get(key);
  }

  static Future<bool> setData({String key, dynamic value}) async {
    return await sharedPreferences.setString(key, value);
  }

  static Future<bool> removeUID() async {
    return await sharedPreferences.remove('uid');
  }
}
