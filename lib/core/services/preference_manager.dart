import 'package:shared_preferences/shared_preferences.dart';

class PreferenceManager {
  static PreferenceManager? _instance;
  static SharedPreferences? _prefs;

  // Private constructor
  PreferenceManager._internal();

  /// Singleton instance getter
  static PreferenceManager get instance {
    if (_instance == null) {
      throw Exception(
        "PreferenceManager not initialized! Call PreferenceManager.init() first.",
      );
    }
    return _instance!;
  }

  /// Initialize once in main()
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    _instance = PreferenceManager._internal();
  }

  // --------------------------
  // Example methods
  // --------------------------

  Future<void> saveAccessToken(String token) async {
    await _prefs?.setString("accessToken", token);
  }

  String? getAccessToken() {
    return _prefs?.getString("accessToken");
  }

  Future<void> clearAccessToken() async {
    await _prefs?.remove("accessToken");
  }
}
