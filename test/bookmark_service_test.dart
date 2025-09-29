import 'package:flutter_test/flutter_test.dart';
import 'package:novabrowser/models/bookmark.dart';
import 'package:novabrowser/services/bookmark_service.dart';

void main() {
  group('BookmarkService', () {
    late BookmarkService bookmarkService;

    setUp(() {
      bookmarkService = BookmarkService();
    });

    test('should add bookmark', () {
      final bookmark = Bookmark(id: '1', title: 'Test', url: 'https://test.com');
      bookmarkService.addBookmark(bookmark);
      expect(bookmarkService.bookmarks.contains(bookmark), true);
    });

    test('should remove bookmark', () {
      final bookmark = Bookmark(id: '1', title: 'Test', url: 'https://test.com');
      bookmarkService.addBookmark(bookmark);
      bookmarkService.removeBookmark('1');
      expect(bookmarkService.bookmarks.contains(bookmark), false);
    });

    test('should check if bookmarked', () {
      final bookmark = Bookmark(id: '1', title: 'Test', url: 'https://test.com');
      bookmarkService.addBookmark(bookmark);
      expect(bookmarkService.isBookmarked('https://test.com'), true);
      expect(bookmarkService.isBookmarked('https://not.com'), false);
    });
  });
}