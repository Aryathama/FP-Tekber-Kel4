// lib/views/notification_page.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/notification_viewmodel.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: const Color(0xFF65B072),
        elevation: 0,
      ),
      body: Consumer<NotificationViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (viewModel.notifications.isEmpty) {
            return const Center(
              child: Text(
                'No new notifications.',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            itemCount: viewModel.notifications.length,
            itemBuilder: (context, index) {
              final notification = viewModel.notifications[index];
              return ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Color(0xFFD1E17D),
                  child: Icon(
                    Icons.notifications_active,
                    color: Colors.white,
                  ),
                ),
                title: Text(
                  notification.title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(notification.subtitle),
              );
            },
            separatorBuilder: (context, index) {
              return const Divider(
                indent: 16,
                endIndent: 16,
              );
            },
          );
        },
      ),
    );
  }
}