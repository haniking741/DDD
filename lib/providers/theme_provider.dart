import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  static const THEME_STATUS = "THEME_STATUS";

  bool _darkTheme = false;

  bool get getIsDarkTheme => _darkTheme;
ThemeProvider();
  setDarkTheme(bool value, {required bool themeValue}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(THEME_STATUS, value);
    _darkTheme = value;
    notifyListeners();
  }

  // Future<bool> getTheme() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   _darkTheme = prefs.getBool(THEME_STATUS) ?? false;
  //   notifyListeners();
  //   return _darkTheme;
  // }
}
