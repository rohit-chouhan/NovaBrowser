import 'package:flutter_test/flutter_test.dart';
import 'package:novabrowser/services/download_service.dart';

void main() {
  group('DownloadService', () {
    late DownloadService downloadService;

    setUp(() {
      downloadService = DownloadService();
    });

    test('should add download', () {
      downloadService.downloadFile('https://test.com/file.pdf', 'file.pdf');
      expect(downloadService.downloads.contains('file.pdf'), true);
    });
  });
}