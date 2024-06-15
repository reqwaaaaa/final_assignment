import 'package:flutter/material.dart';

class ThemeModel {
  String name;
  String description;
  List<String> options;

  ThemeModel(
      {required this.name, required this.description, required this.options});
}

class ThemeProvider with ChangeNotifier {
  List<ThemeModel> _themes = [];

  List<ThemeModel> get themes => _themes;

  void addTheme(ThemeModel theme) {
    _themes.add(theme);
    notifyListeners();
  }

  void updateTheme(int index, ThemeModel theme) {
    _themes[index] = theme;
    notifyListeners();
  }

  void deleteTheme(int index) {
    _themes.removeAt(index);
    notifyListeners();
  }
}
