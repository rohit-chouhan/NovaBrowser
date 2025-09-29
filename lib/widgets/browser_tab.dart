import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'custom_webview.dart';

class BrowserTab extends StatefulWidget {
  final String url;
  final Function(WebViewController)? onControllerCreated;

  const BrowserTab({super.key, required this.url, this.onControllerCreated});

  @override
  State<BrowserTab> createState() => _BrowserTabState();
}

class _BrowserTabState extends State<BrowserTab> {
  @override
  Widget build(BuildContext context) {
    return CustomWebView(
      url: widget.url,
      onControllerCreated: widget.onControllerCreated,
    );
  }
}