import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _locale = const Locale('en');
  Map<String, String> _localizedStrings = {};

  Locale get locale => _locale;

  Future<void> loadLocale(Locale locale) async {
    _locale = locale;

    String jsonString =
        await rootBundle.loadString('assets/lang/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    _localizedStrings = jsonMap.map((key, value) => MapEntry(key, value.toString()));

    // Save selected language to SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('languageCode', locale.languageCode);

    notifyListeners();
  }

  Future<void> loadSavedLocale() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? langCode = prefs.getString('languageCode');
    Locale savedLocale = langCode != null ? Locale(langCode) : const Locale('en');
    await loadLocale(savedLocale);
  }

  String translate(String key,) {
    return _localizedStrings[key] ?? key;
  }

  void changeLocale(Locale locale) async {
    await loadLocale(locale);
  }
}
