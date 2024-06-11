import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TruthOrDareState with ChangeNotifier {
  late List<Map<String, String>> _truthQuestions;
  late List<Map<String, String>> _dareChallenges;

  TruthOrDareState() {
    _truthQuestions = [];
    _dareChallenges = [];
    _loadState();
  }

  List<Map<String, String>> get truthQuestions => _truthQuestions;
  List<Map<String, String>> get dareChallenges => _dareChallenges;

  Future<void> _loadState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _truthQuestions = (prefs.getStringList('truthQuestions') ?? [])
        .map((q) => Map<String, String>.from(jsonDecode(q)))
        .toList();
    _dareChallenges = (prefs.getStringList('dareChallenges') ?? [])
        .map((d) => Map<String, String>.from(jsonDecode(d)))
        .toList();
    notifyListeners();
  }

  Future<void> addTruthQuestion(Map<String, String> question) async {
    _truthQuestions.add(question);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
        'truthQuestions', _truthQuestions.map((q) => jsonEncode(q)).toList());
    notifyListeners();
  }

  Future<void> addDareChallenge(Map<String, String> challenge) async {
    _dareChallenges.add(challenge);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
        'dareChallenges', _dareChallenges.map((d) => jsonEncode(d)).toList());
    notifyListeners();
  }

  Future<void> removeTruthQuestion(Map<String, String> question) async {
    _truthQuestions.remove(question);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
        'truthQuestions', _truthQuestions.map((q) => jsonEncode(q)).toList());
    notifyListeners();
  }

  Future<void> removeDareChallenge(Map<String, String> challenge) async {
    _dareChallenges.remove(challenge);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
        'dareChallenges', _dareChallenges.map((d) => jsonEncode(d)).toList());
    notifyListeners();
  }
}
/*初始化状态：在构造函数中，真心话和大冒险的列表被初始化为空列表，然后调用 _loadState 方法从 SharedPreferences 中加载保存的真心话和大冒险列表。

加载状态：_loadState 方法从 SharedPreferences 中获取保存的真心话和大冒险列表，并将它们解码为 Map<String, String> 类型的对象，然后通知侦听器更新状态。

添加真心话和大冒险：addTruthQuestion 和 addDareChallenge 方法用于向真心话和大冒险列表中添加新的条目。添加完成后，列表被更新，并将更新后的列表保存到 SharedPreferences 中。

删除真心话和大冒险：removeTruthQuestion 和 removeDareChallenge 方法用于从真心话和大冒险列表中删除指定的条目。删除完成后，列表被更新，并将更新后的列表保存到 SharedPreferences 中。*/