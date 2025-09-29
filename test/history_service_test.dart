import 'package:flutter_test/flutter_test.dart';
import 'package:novabrowser/models/history_item.dart';
import 'package:novabrowser/services/history_service.dart';

void main() {
  group('HistoryService', () {
    late HistoryService historyService;

    setUp(() {
      historyService = HistoryService();
    });

    test('should add history item', () {
      final item = HistoryItem(id: '1', title: 'Test', url: 'https://test.com', timestamp: DateTime.now());
      historyService.addHistoryItem(item);
      expect(historyService.history.contains(item), true);
    });

    test('should clear history', () {
      final item = HistoryItem(id: '1', title: 'Test', url: 'https://test.com', timestamp: DateTime.now());
      historyService.addHistoryItem(item);
      historyService.clearHistory();
      expect(historyService.history.isEmpty, true);
    });
  });
}