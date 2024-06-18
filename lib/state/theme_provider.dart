import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ThemeModel {
  String name;
  String description;
  List<String> options;

  ThemeModel(
      {required this.name, required this.description, required this.options});

  // 将模型转化为 JSON 格式
  Map<String, dynamic> toJson() => {
        'name': name,
        'description': description,
        'options': options,
      };

  // 从 JSON 格式转化为模型
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
    if (index >= 0 && index < _themes.length) {
      _themes[index] = theme;
      _saveThemes();
      notifyListeners();
    } else {
      debugPrint("Invalid index: $index");
    }
  }

  void deleteTheme(int index) {
    if (index >= 0 && index < _themes.length) {
      _themes.removeAt(index);
      _saveThemes();
      notifyListeners();
    } else {
      debugPrint("Invalid index: $index");
    }
  }

  Future<void> _saveThemes() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final themesJson =
          jsonEncode(_themes.map((theme) => theme.toJson()).toList());
      await prefs.setString('themes', themesJson);
    } catch (e) {
      debugPrint("Failed to save themes: $e");
    }
  }

  Future<void> _loadThemes() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final themesJson = prefs.getString('themes');
      if (themesJson != null) {
        final List<dynamic> themesList = jsonDecode(themesJson);
        _themes = themesList.map((json) => ThemeModel.fromJson(json)).toList();
      } else {
        _themes = [];
      }
    } catch (e) {
      debugPrint("Failed to load themes: $e");
      _themes = [];
    }
    notifyListeners();
  }
}
