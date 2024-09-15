import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier{
ThemeMode _themeMode = ThemeMode.light;
ThemeMode get themeMode => _themeMode;
 
ThemeProvider(){
  _loadThemeFromPrefs();
}

void toggleThemeMode(bool isDark){
_themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
_saveThemeToPrefs(isDark);
notifyListeners();
}
//
//!
void _saveThemeToPrefs(bool isDark)async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('isDarkTheme', isDark);
}
//
//!
void _loadThemeFromPrefs()async{
SharedPreferences prefs = await SharedPreferences.getInstance();
bool isDark = prefs.getBool('isDarkTheme') ?? false;
_themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
notifyListeners();
}

}
