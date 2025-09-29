import 'package:flutter/material.dart';
import 'about_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Theme'),
            subtitle: const Text('Light/Dark'),
            trailing: Switch(
              value: Theme.of(context).brightness == Brightness.dark,
              onChanged: (value) {
                // Toggle theme
              },
            ),
          ),
          ListTile(
            title: const Text('Default Search Engine'),
            subtitle: const Text('Google'),
          ),
          ListTile(
            title: const Text('Clear History'),
            onTap: () {
              // Clear history
            },
          ),
          ListTile(
            title: const Text('Clear Bookmarks'),
            onTap: () {
              // Clear bookmarks
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('About Developer'),
            subtitle: const Text('Learn more about the developer'),
            leading: const Icon(Icons.info),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}