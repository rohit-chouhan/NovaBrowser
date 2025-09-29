import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/bookmark_service.dart';
import '../models/bookmark.dart';

class BookmarksScreen extends StatefulWidget {
  const BookmarksScreen({super.key});

  @override
  State<BookmarksScreen> createState() => _BookmarksScreenState();
}

class _BookmarksScreenState extends State<BookmarksScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _urlController = TextEditingController();

  void _addBookmark() {
    final title = _titleController.text;
    final url = _urlController.text;
    if (title.isNotEmpty && url.isNotEmpty) {
      final bookmark = Bookmark(id: DateTime.now().toString(), title: title, url: url);
      Provider.of<BookmarkService>(context, listen: false).addBookmark(bookmark);
      _titleController.clear();
      _urlController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmarks'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(labelText: 'Title'),
                ),
                TextField(
                  controller: _urlController,
                  decoration: const InputDecoration(labelText: 'URL'),
                ),
                ElevatedButton(
                  onPressed: _addBookmark,
                  child: const Text('Add Bookmark'),
                ),
              ],
            ),
          ),
          Expanded(
            child: Consumer<BookmarkService>(
              builder: (context, bookmarkService, child) {
                return ListView.builder(
                  itemCount: bookmarkService.bookmarks.length,
                  itemBuilder: (context, index) {
                    final bookmark = bookmarkService.bookmarks[index];
                    return ListTile(
                      title: Text(bookmark.title),
                      subtitle: Text(bookmark.url),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          bookmarkService.removeBookmark(bookmark.id);
                        },
                      ),
                      onTap: () {
                        // Navigate back to home with the URL
                        Navigator.pop(context, bookmark.url);
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}