import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/core.dart';

class ThemeNotifier with ChangeNotifier {
  static const String key = 'theme';
  // static const String sepiaKey = 'sepia';

  SharedPreferences prefs;
  bool _darkTheme;
  bool _sepiaTheme;
  ThemeData currentTheme = kTHEME;

  // ThemeMode _theme = ThemeMode.light;
  // ThemeMode get theme => _theme;

  bool get darkTheme => _darkTheme;
  bool get sepiaTheme => _sepiaTheme;

  ThemeNotifier() {
    _darkTheme = false;
    _sepiaTheme = false;
    // currentTheme = kTHEME;
    _loadFromPrefs();
  }

  void toggleTheme() {
    // _darkTheme = !_darkTheme;
    // _theme = _darkTheme ? ThemeMode.dark : ThemeMode.light;
    if (currentTheme == kDarkTHEME) {
      _sepiaTheme = false;
      _darkTheme = false;
      currentTheme = kTHEME;
    } else if (currentTheme == kSepiaTheme) {
      _darkTheme = true;
      _sepiaTheme = false;
      currentTheme = kDarkTHEME;
    } else {
      currentTheme = kSepiaTheme;
      _sepiaTheme = true;
      _darkTheme = false;
    }
    //
    _saveTPrefs();
    notifyListeners();
  }

  _loadFromPrefs() async {
    await initPrefs();

    String tempTheme = prefs.getString(key);
    debugPrint('\n\n\n\t\t\tTHEME----------------------------$tempTheme');

    if (tempTheme == 'dark') {
      currentTheme = kDarkTHEME;
      _darkTheme = true;
      _sepiaTheme = false;
    } else if (tempTheme == 'sepia') {
      currentTheme = kSepiaTheme;
      _sepiaTheme = true;
      _darkTheme = false;
    } else {
      _darkTheme = false;
      _sepiaTheme = false;
      currentTheme = kTHEME;
    }

    // currentTheme = prefs.getString(key) ?? kTHEME;

    // _theme = _darkTheme ? ThemeMode.dark : ThemeMode.light;

    notifyListeners();
  }

  _saveTPrefs() async {
    await initPrefs();
    if (_darkTheme) {
      await prefs.setString(key, 'dark');
    } else if (_sepiaTheme) {
      await prefs.setString(key, 'sepia');
    } else {
      await prefs.setString(key, 'light');
    }

    debugPrint('\n\n\n\t\t\tTHEME----------------------------${prefs.getString(key)}');
    // var tempdark = await prefs.setBool(key, _darkTheme);
    // var tempsepia = await prefs.setBool(sepiaKey, _sepiaTheme);
  }

  initPrefs() async {
    prefs ??= await SharedPreferences.getInstance();
  }
}

enum themes { white, sepia, dark }
