import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static late SharedPreferences prefsData;

  static Future initMySharedPreferences() async {
    prefsData = await SharedPreferences.getInstance();
  }

  static Future<void> saveList(String key, List<String> value) async {
    print("SaveString  key: $key && value: $value");
    await prefsData.setStringList(key, value);
  }

  static Future<List<String>> getList(String key) async {
    print("GetString  key: $key");
    return prefsData.getStringList(key) ?? [];
  }

  static Future<void> clearDataBase() async {
    prefsData.clear();
  }
}
