import 'package:shared_preferences/shared_preferences.dart';

class MySharedPrefferences {
  static SharedPreferences? _preferences;
  static const String key ='userType';
  static init() async {
    _preferences = await SharedPreferences.getInstance();
    return _preferences;
  }

  static Future saveUsertype (String type)async{
    return await _preferences!.setString(key, type);
  }
  static Future<String>? getUserType ()async=>await _preferences!.getString(key) ??"";
}