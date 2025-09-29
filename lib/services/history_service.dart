import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/history_item.dart';

class HistoryService extends ChangeNotifier {
  List<HistoryItem> _history = [];

  List<HistoryItem> get history => _history;

  HistoryService() {
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final historyJson = prefs.getStringList('history') ?? [];
    _history = historyJson.map((json) => HistoryItem.fromJson(jsonDecode(json))).toList();
    notifyListeners();
  }

  Future<void> _saveHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final historyJson = _history.map((item) => jsonEncode(item.toJson())).toList();
    await prefs.setStringList('history', historyJson);
  }

  Future<void> addHistoryItem(HistoryItem item) async {
    _history.add(item);
    await _saveHistory();
    notifyListeners();
  }

  Future<void> clearHistory() async {
    _history.clear();
    await _saveHistory();
    notifyListeners();
  }
}