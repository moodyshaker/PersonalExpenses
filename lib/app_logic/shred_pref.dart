import 'package:personal_expenses/app_logic/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedAppPref {
  static final SharedAppPref instance = SharedAppPref._instance();
  SharedPreferences _preferences;
  static const String _id = "ID";
  static const String _displayName = "USER_NAME";
  static const String _photoURL = "IMAGE_URL";
  static const String _email = "EMAIL";
  static const String _type = "TYPE";

  SharedAppPref._instance();

  Future<SharedPreferences> get sharedPreference async {
    if (_preferences == null) {
      _preferences = await _initAppPreference();
    }
    return _preferences;
  }

  Future<SharedPreferences> _initAppPreference() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences;
  }

  Future<bool> setId(String value) async {
    bool isSet = await _preferences.setString(_id, value);
    return isSet;
  }

  Future<bool> setName(String value) async {
    bool isSet = await _preferences.setString(_displayName, value);
    return isSet;
  }

  Future<bool> setPhotoUrl(String value) async {
    bool isSet = await _preferences.setString(_photoURL, value);
    return isSet;
  }

  Future<bool> setType(String value) async {
    bool isSet = await _preferences.setString(_type, value);
    return isSet;
  }

  Future<bool> setEmail(String value) async {
    bool isSet = await _preferences.setString(_email, value);
    return isSet;
  }

  String getId() => _preferences.getString(_id);

  String getType() => _preferences.getString(_type);

  String getUsername() => _preferences.getString(_displayName);

  String getEmail() => _preferences.getString(_email);

  String getImageUrl() => _preferences.getString(_photoURL);

  bool isFirstTime() => getId() == null;

  Future<String> clearAll() async {
    try {
      await _preferences.clear();
      return Auth.SUCCESS_MSG;
    } catch (e) {
      return e;
    }
  }
}
