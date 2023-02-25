import 'dart:js';

import 'package:flutter/material.dart';
import 'package:pmsna1/settings/styles_settings.dart';

class themeProvider with ChangeNotifier {
  ThemeData? _themeData;
  themeProvider(BuildContext context) {
    _themeData = StyleSettings.lightTheme(context);
  }

  getthemeData() => this._themeData;
  setthemeData(ThemeData theme) {
    this._themeData = theme;
    notifyListeners();
  }
}
