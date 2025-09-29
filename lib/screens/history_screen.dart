import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/history_service.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              Provider.of<HistoryService>(context, listen: false).clearHistory();
            },
          ),
        ],
      ),
      body: Consumer<HistoryService>(
        builder: (context, historyService, child) {
          return ListView.builder(
            itemCount: historyService.history.length,
            itemBuilder: (context, index) {
              final item = historyService.history[index];
              return ListTile(
                title: Text(item.title),
                subtitle: Text(item.url),
                trailing: Text(item.timestamp.toString()),
                onTap: () {
                  Navigator.pop(context, item.url);
                },
              );
            },
          );
        },
      ),
    );
  }
}