import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class LanguageProvider extends ChangeNotifier {
  Locale _appLocale = Locale((Platform.localeName.substring(0, 2)));

  Locale get appLocal {
    return _appLocale;
  }

  Future fetchLocale() async {
    print((Platform.localeName.substring(0, 2)));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('language_code') == null) {
      _appLocale = Locale((Platform.localeName.substring(0, 2)));
      return Null;
    }
    _appLocale = Locale(prefs.getString('language_code'));
    notifyListeners();
  }

  void changeLanguage(Locale type) async {
    var prefs = await SharedPreferences.getInstance();
    if (_appLocale == type) {
      return;
    }
    if (type == Locale("pt")) {
      print('object');
      _appLocale = Locale("pt");
      await prefs.setString('language_code', 'pt');
    }
    if (type == Locale("en")) {
      _appLocale = Locale("en");
      await prefs.setString('language_code', 'en');
    }
    if (type == Locale("es")) {
      _appLocale = Locale("es");
      await prefs.setString('language_code', 'es');
    }
    if (type == Locale("de")) {
      _appLocale = Locale("de");
      await prefs.setString('language_code', 'de');
    }
    if (type == Locale("fr")) {
      _appLocale = Locale("fr");
      await prefs.setString('language_code', 'fr');
    }
    notifyListeners();
  }
}
