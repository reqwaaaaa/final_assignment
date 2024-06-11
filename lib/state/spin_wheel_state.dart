import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SpinWheelState with ChangeNotifier {
  late List<String> _tasks;
  late List<String> _history;

  SpinWheelState() {
    _tasks = [];
    _history = [];
    _loadState();
  }

  List<String> get tasks => _tasks;
  List<String> get history => _history;

  Future<void> _loadState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _tasks = prefs.getStringList('tasks') ?? [];
    _history = prefs.getStringList('history') ?? [];
    notifyListeners();
  }

  Future<void> addTask(String task) async {
    _tasks.add(task);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('tasks', _tasks);
    notifyListeners();
  }

  Future<void> removeTask(String task) async {
    _tasks.remove(task);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('tasks', _tasks);
    notifyListeners();
  }

  Future<void> addToHistory(String task) async {
    _history.add(task);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('history', _history);
    notifyListeners();
  }

  Future<void> clearHistory() async {
    _history.clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('history', _history);
    notifyListeners();
  }
}
/*
_tasks 和 _history：这两个成员变量分别存储任务列表和历史记录列表。
SpinWheelState() 构造函数：在初始化时，会初始化 _tasks 和 _history 列表，并调用 _loadState() 方法加载先前保存的状态。
get tasks 和 get history：这两个 getter 方法用于获取 _tasks 和 _history 列表。
_loadState() 方法：用于从本地存储中加载先前保存的任务列表和历史记录列表，并通过调用 notifyListeners() 来通知任何侦听器进行更新。
addTask(String task) 方法：用于向任务列表中添加新的任务，并将更新后的任务列表保存到本地存储中，并通知侦听器进行更新。
removeTask(String task) 方法：用于从任务列表中删除指定的任务，并将更新后的任务列表保存到本地存储中，并通知侦听器进行更新。
addToHistory(String task) 方法：用于向历史记录列表中添加新的任务，并将更新后的历史记录列表保存到本地存储中，并通知侦听器进行更新。
clearHistory() 方法：用于清除历史记录列表，并将更新后的历史记录列表保存到本地存储中，并通知侦听器进行更新。
*/