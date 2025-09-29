import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  Future<void> _launchUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Developer'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            CircleAvatar(
              radius: 80,
              backgroundImage: const NetworkImage(
                'https://i.ibb.co/tMHkthKx/download-42-1.jpg',
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Rohit Chouhan',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Rohit Chouhan is a renowned figure in the business and digital marketing industry. He is a successful entrepreneur, digital marketing expert, and accomplished author.',
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            const Text(
              'Connect with Rohit',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            _buildContactButton(
              icon: Icons.language,
              label: 'Website',
              onPressed: () => _launchUrl('https://rohitchouhan.com'),
            ),
            const SizedBox(height: 12),
            _buildContactButton(
              icon: Icons.camera_alt,
              label: 'Instagram',
              onPressed: () => _launchUrl('https://instagram.com/itsrohitchouhan'),
            ),
            const SizedBox(height: 12),
            _buildContactButton(
              icon: Icons.email,
              label: 'Email',
              onPressed: () => _launchUrl('mailto:me@rohitchouhan'),
            ),
            const SizedBox(height: 40),
            const Text(
              'Made with ❤️ in India',
              style: TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
      ),
    );
  }
}