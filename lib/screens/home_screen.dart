import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/url_bar.dart';
import '../widgets/browser_tab.dart';
import '../utils/constants.dart';
import '../services/bookmark_service.dart';
import '../models/bookmark.dart';
import 'bookmarks_screen.dart';
import 'history_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _currentUrl = Constants.homeUrl;
  WebViewController? _controller;

  @override
  void initState() {
    super.initState();
    _checkFirstLaunch();
  }

  Future<void> _checkFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    final isFirstLaunch = prefs.getBool('first_launch') ?? true;
    if (isFirstLaunch) {
      await prefs.setBool('first_launch', false);
      _showWelcomeDialog();
    }
  }

  void _showWelcomeDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Welcome to Nova Browser'),
        content: const Text('This browser is developed in India by Rohit Chouhan.\n\nhttps://instagram.com/itsrohitchouhan'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _onUrlSubmitted(String url) {
    setState(() {
      _currentUrl = url.startsWith('http') ? url : '${Constants.defaultSearchEngine}$url';
    });
  }

  void _onControllerCreated(WebViewController controller) {
    _controller = controller;
  }

  void _goBack() {
    _controller?.goBack();
  }

  void _goForward() {
    _controller?.goForward();
  }

  void _refresh() {
    _controller?.reload();
  }

  void _navigateToBookmarks() async {
    final url = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const BookmarksScreen()),
    );
    if (url != null) {
      _onUrlSubmitted(url);
    }
  }

  void _navigateToHistory() async {
    final url = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HistoryScreen()),
    );
    if (url != null) {
      _onUrlSubmitted(url);
    }
  }

  void _navigateToSettings() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SettingsScreen()),
    );
  }

  void _addBookmark() {
    final bookmarkService = Provider.of<BookmarkService>(context, listen: false);
    // For simplicity, add current URL as bookmark
    final bookmark = Bookmark(id: DateTime.now().toString(), title: 'Bookmark', url: _currentUrl);
    bookmarkService.addBookmark(bookmark);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Bookmark added')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: _goBack,
        ),
        title: const Text('Nova Browser'),
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed: _goForward,
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refresh,
          ),
          IconButton(
            icon: const Icon(Icons.bookmark_add),
            onPressed: _addBookmark,
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'bookmarks':
                  _navigateToBookmarks();
                  break;
                case 'history':
                  _navigateToHistory();
                  break;
                case 'settings':
                  _navigateToSettings();
                  break;
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'bookmarks', child: Text('Bookmarks')),
              const PopupMenuItem(value: 'history', child: Text('History')),
              const PopupMenuItem(value: 'settings', child: Text('Settings')),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: Theme.of(context).appBarTheme.backgroundColor,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: UrlBar(onUrlSubmitted: _onUrlSubmitted),
          ),
          Expanded(
            child: BrowserTab(url: _currentUrl, onControllerCreated: _onControllerCreated),
          ),
        ],
      ),
    );
  }
}