import 'package:flutter/material.dart';

class UrlBar extends StatefulWidget {
  final Function(String) onUrlSubmitted;

  const UrlBar({super.key, required this.onUrlSubmitted});

  @override
  State<UrlBar> createState() => _UrlBarState();
}

class _UrlBarState extends State<UrlBar> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: _controller,
        decoration: InputDecoration(
          hintText: 'Enter URL or search',
          suffixIcon: IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              widget.onUrlSubmitted(_controller.text);
            },
          ),
        ),
        onSubmitted: widget.onUrlSubmitted,
      ),
    );
  }
}