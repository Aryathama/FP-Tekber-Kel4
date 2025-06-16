// lib/services/api/notification_service.dart

import '../../models/notification_model.dart';

class NotificationService {
  // Fungsi ini seolah-olah mengambil data dari API
  Future<List<NotificationModel>> getNotifications() async {
    // Simulasi jeda waktu seperti saat memanggil API sungguhan
    await Future.delayed(const Duration(milliseconds: 800));

    // Data lama Anda, sekarang diubah menjadi List<NotificationModel>
    final List<Map<String, String>> mockData = [
      {
        'title': 'Time to Hydrate! 💧',
        'subtitle': "Don't forget to drink a glass of water and keep your body happy!",
      },
      {
        'title': 'Water check! 👀',
        'subtitle': "Have you had a sip lately? Your body's waiting!",
      },
      {
        'title': 'Lunch Time Suggestion 🥗',
        'subtitle': "A balanced meal is waiting. Consider a salad with grilled chicken.",
      },
      {
        'title': 'Evening Walk Reminder 🚶‍♀️',
        'subtitle': 'A short 15-minute walk can do wonders for your digestion and mood.',
      },
    ];

    // Mengubah List<Map> menjadi List<NotificationModel>
    return mockData.map((item) {
      return NotificationModel(
        title: item['title']!,
        subtitle: item['subtitle']!,
      );
    }).toList();
  }
}