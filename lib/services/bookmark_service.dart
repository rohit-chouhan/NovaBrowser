import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/bookmark.dart';

class BookmarkService extends ChangeNotifier {
  List<Bookmark> _bookmarks = [];

  List<Bookmark> get bookmarks => _bookmarks;

  BookmarkService() {
    _loadBookmarks();
  }

  Future<void> _loadBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    final bookmarksJson = prefs.getStringList('bookmarks') ?? [];
    _bookmarks = bookmarksJson.map((json) => Bookmark.fromJson(jsonDecode(json))).toList();
    notifyListeners();
  }

  Future<void> _saveBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    final bookmarksJson = _bookmarks.map((bookmark) => jsonEncode(bookmark.toJson())).toList();
    await prefs.setStringList('bookmarks', bookmarksJson);
  }

  Future<void> addBookmark(Bookmark bookmark) async {
    _bookmarks.add(bookmark);
    await _saveBookmarks();
    notifyListeners();
  }

  Future<void> removeBookmark(String id) async {
    _bookmarks.removeWhere((bookmark) => bookmark.id == id);
    await _saveBookmarks();
    notifyListeners();
  }

  bool isBookmarked(String url) {
    return _bookmarks.any((bookmark) => bookmark.url == url);
  }
}