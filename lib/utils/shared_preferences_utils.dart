import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtils {
  static Future<void> setIsProfessor(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isProfessor', value);
  }

  static Future<bool> getIsProfessor() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isProfessor') ?? false;
  }
}
