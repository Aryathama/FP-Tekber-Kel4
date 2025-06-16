import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  final List<Map<String, String>> dummyHistory = const [
    {'food': 'Fried Rice', 'calories': '235 kcal', 'date': '30 May 2025'},
    {'food': 'Apple', 'calories': '95 kcal', 'date': '29 May 2025'},
    {'food': 'Chicken Breast', 'calories': '165 kcal', 'date': '28 May 2025'},
    {'food': 'Banana', 'calories': '105 kcal', 'date': '27 May 2025'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nutrition History'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: dummyHistory.length,
        itemBuilder: (context, index) {
          final item = dummyHistory[index];
          return Card(
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: const Icon(Icons.fastfood, color: Colors.green),
              title: Text(item['food']!, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text("Calories: ${item['calories']}"),
              trailing: Text(item['date']!, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            ),
          );
        },
      ),
    );
  }
}