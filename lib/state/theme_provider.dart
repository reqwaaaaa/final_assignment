import 'package:flutter/foundation.dart';

class Theme {
  String name;
  String description;
  List<String> options;

  Theme({required this.name, required this.description, required this.options});
}

class ThemeProvider extends ChangeNotifier {
  List<Theme> _themes = [];

  List<Theme> get themes => _themes;

  void addTheme(Theme theme) {
    _themes.add(theme);
    notifyListeners();
  }

  void removeTheme(int index) {
    _themes.removeAt(index);
    notifyListeners();
  }

  void updateTheme(int index, Theme theme) {
    _themes[index] = theme;
    notifyListeners();
  }
}
