import 'package:shared_preferences/shared_preferences.dart';

class AppPreference {
  static SharedPreferences? prefs;

  //TODO: INIT METHOD FOR INIT PREFERENCE
  static init() async {
    prefs = await SharedPreferences.getInstance();
  }

  //TODO: PUT METHOD FOR STORE DATA
  static put(String key, dynamic value) {
    if (value is String) {
      prefs!.setString(key, value);
    } else if (value is int) {
      prefs!.setInt(key, value);
    } else if (value is bool) {
      prefs!.setBool(key, value);
    } else if (value is double) {
      prefs!.setDouble(key, value);
    } else if (value is List<String>) {
      prefs!.setStringList(key, value);
    }
  }

  //TODO: GET STRING
  static getString(String key) {
    String? value = prefs!.getKeys().contains(key) ? prefs!.getString(key) : "";
    return value;
  }

  //TODO: GET INT
  static getInt(String key) => prefs!.getInt(key);

  //TODO: GET DOUBLE
  static getDouble(String key) => prefs!.getDouble(key);

  //TODO: GET BOOL
  static getBool(String key) => prefs!.getBool(key);

  //TODO: GET STRING LIST
  static getStringList(String key) => prefs!.getStringList(key);

  //TODO: REMOVE A ELEMENT
  static remove(String key) async => prefs!.remove(key);

  //TODO: CLEAR WHOLE PREFERENCES
  static clear() async => prefs!.clear();
}

class AppPreferenceData {
  //TODO: THEME OF APPLICATION
  static String theme = "";

  static getTheme() async {
    theme = AppPreference.getString("Theme") ?? "";
  }
}