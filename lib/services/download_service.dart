import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class DownloadService extends ChangeNotifier {
  final List<String> _downloads = [];

  List<String> get downloads => _downloads;

  Future<void> downloadFile(String url, String filename) async {
    // For simplicity, use url_launcher to open the URL for download
    // In a real app, use http or dio for downloading
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
      _downloads.add(filename);
      notifyListeners();
    }
  }

  Future<String> getDownloadDirectory() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }
}