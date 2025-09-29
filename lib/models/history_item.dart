class HistoryItem {
  final String id;
  final String title;
  final String url;
  final DateTime timestamp;

  HistoryItem({required this.id, required this.title, required this.url, required this.timestamp});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'url': url,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory HistoryItem.fromJson(Map<String, dynamic> json) {
    return HistoryItem(
      id: json['id'],
      title: json['title'],
      url: json['url'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
}