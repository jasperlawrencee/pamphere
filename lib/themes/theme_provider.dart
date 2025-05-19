import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  bool _isDarkMode = false;

  ThemeMode get themeMode => _themeMode;
  bool get isDarkMode => _isDarkMode;

  ThemeProvider() {
    loadThemePreference();
  }

  Future<void> loadThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    final savedThemeMode = prefs.getString('themeMode') ?? 'system';

    setThemeMode(savedThemeMode);
  }

  Future<void> _saveThemePreference(String themeMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('themeMode', themeMode);
  }

  void setThemeMode(String themeMode) {
    switch (themeMode) {
      case 'light':
        _themeMode = ThemeMode.light;
        _isDarkMode = false;
        break;
      case 'dark':
        _themeMode = ThemeMode.dark;
        _isDarkMode = true;
        break;
      default:
        _themeMode = ThemeMode.system;
        _isDarkMode = WidgetsBinding.instance.window.platformBrightness ==
            Brightness.dark;
        break;
    }
    _saveThemePreference(themeMode);
    notifyListeners();
  }

  void toggleTheme() {
    if (_themeMode == ThemeMode.light) {
      setThemeMode('light');
    } else if (_themeMode == ThemeMode.dark) {
      setThemeMode('dark');
    } else {
      setThemeMode(_isDarkMode ? 'light' : 'dark');
    }
  }
}
