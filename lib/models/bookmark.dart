class Bookmark {
  final String id;
  final String title;
  final String url;

  Bookmark({required this.id, required this.title, required this.url});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'url': url,
    };
  }

  factory Bookmark.fromJson(Map<String, dynamic> json) {
    return Bookmark(
      id: json['id'],
      title: json['title'],
      url: json['url'],
    );
  }
}