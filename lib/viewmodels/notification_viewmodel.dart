// lib/viewmodels/notification_viewmodel.dart

import 'package:flutter/material.dart';
import '../models/notification_model.dart';
import '../services/api/notification_service.dart';

class NotificationViewModel extends ChangeNotifier {
  final NotificationService _notificationService = NotificationService();

  List<NotificationModel> _notifications = [];
  List<NotificationModel> get notifications => _notifications;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  NotificationViewModel() {
    fetchNotifications();
  }

  Future<void> fetchNotifications() async {
    _isLoading = true;
    notifyListeners();

    _notifications = await _notificationService.getNotifications();

    _isLoading = false;
    notifyListeners();
  }
}