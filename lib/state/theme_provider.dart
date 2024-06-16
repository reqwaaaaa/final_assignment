import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ThemeModel {
  String name;
  String description;
  List<String> options;

  ThemeModel(
      {required this.name, required this.description, required this.options});

// 将对象转换为 JSON 格式
  Map<String, dynamic> toJson() => {
        'name': name,
        'description': description,
        'options': options,
      };
 // 从 JSON 格式创建对象
  factory ThemeModel.fromJson(Map<String, dynamic> json) {
    return ThemeModel(
      name: json['name'],
      description: json['description'],
      options: List<String>.from(json['options']),
    );
  }


}

class ThemeProvider with ChangeNotifier {
  List<ThemeModel> _themes = [];

  List<ThemeModel> get themes => _themes;

  ThemeProvider() {
    _loadThemes();
  }

  void addTheme(ThemeModel theme) {
    _themes.add(theme);
    _saveThemes();
    notifyListeners();
  }

  void updateTheme(int index, ThemeModel theme) {
    _themes[index] = theme;
    _saveThemes();
    notifyListeners();
  }

  void deleteTheme(int index) {
    _themes.removeAt(index);
    _saveThemes();
    notifyListeners();
  }

   Future<void> _saveThemes() async {
    final prefs = await SharedPreferences.getInstance();
    final themesJson = jsonEncode(_themes.map((theme) => theme.toJson()).toList());
    prefs.setString('themes', themesJson);
  }

  Future<void> _loadThemes() async {
    final prefs = await SharedPreferences.getInstance();
    final themesJson = prefs.getString('themes');
    if (themesJson != null) {
      final List<dynamic> themesList = jsonDecode(themesJson);
      _themes = themesList.map((json) => ThemeModel.fromJson(json)).toList();
      notifyListeners();
    }
  }
}
