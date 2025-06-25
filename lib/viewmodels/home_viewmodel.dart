// lib/viewmodels/home_viewmodel.dart

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;

import '../models/user_model.dart';
import '../models/nutrition_summary_model.dart';

class HomeViewModel extends ChangeNotifier {
  // --- PROPERTIES (STATE) ---

  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  bool _hasNewNotification = true;
  bool get hasNewNotification => _hasNewNotification;

  User? _user;
  User? get user => _user;

  NutritionSummary? _nutritionSummary;
  NutritionSummary? get nutritionSummary => _nutritionSummary;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  // --- CONSTRUCTOR ---

  HomeViewModel() {
    loadData();
  }

  // --- LOGIC (METHODS) ---

  Future<void> loadData() async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 500));

    final fbUser = fb.FirebaseAuth.instance.currentUser;

    _user = User(
      name: fbUser?.displayName ?? 'User',
      imageUrl: fbUser?.photoURL ??
          'https://ui-avatars.com/api/?name=${fbUser?.displayName ?? 'U'}',
    );

    _nutritionSummary = NutritionSummary(
      currentPlan: 'Maintain',
      caloriesConsumed: 1721,
      caloriesGoal: 2213,
      proteinConsumed: 78,
      proteinGoal: 90,
      fatsConsumed: 45,
      fatsGoal: 70,
      carbsConsumed: 95,
      carbsGoal: 110,
      waterConsumedLiters: 2.1,
      waterGoalLiters: 2.8,
      stepsTaken: 3732,
    );

    _isLoading = false;
    notifyListeners();
  }

  void onBottomNavTapped(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  void markNotificationAsRead() {
    _hasNewNotification = false;
    notifyListeners();
  }

  void addWater(int amountInMl) {
    if (_nutritionSummary != null) {
      final currentWater = _nutritionSummary!.waterConsumedLiters;
      final newWater = currentWater + (amountInMl / 1000.0);

      _nutritionSummary = NutritionSummary(
        currentPlan: _nutritionSummary!.currentPlan,
        caloriesConsumed: _nutritionSummary!.caloriesConsumed,
        caloriesGoal: _nutritionSummary!.caloriesGoal,
        proteinConsumed: _nutritionSummary!.proteinConsumed,
        proteinGoal: _nutritionSummary!.proteinGoal,
        fatsConsumed: _nutritionSummary!.fatsConsumed,
        fatsGoal: _nutritionSummary!.fatsGoal,
        carbsConsumed: _nutritionSummary!.carbsConsumed,
        carbsGoal: _nutritionSummary!.carbsGoal,
        waterConsumedLiters: newWater,
        waterGoalLiters: _nutritionSummary!.waterGoalLiters,
        stepsTaken: _nutritionSummary!.stepsTaken,
      );

      notifyListeners();
      print('User added: $amountInMl ml. New total: $newWater L');
    }
  }
}