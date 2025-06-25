import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;

import '../utils/bmi_calculator_util.dart';
import '../models/user_model.dart';
import '../models/nutrition_summary_model.dart';

class HomeViewModel extends ChangeNotifier {
  // --- STATE ---
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

  // --- LOAD DATA UTAMA (user + nutrition) ---
  Future<void> loadData() async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 500));

    // Ambil data user dari Firebase
    final fbUser = fb.FirebaseAuth.instance.currentUser;

    _user = User(
      name: fbUser?.displayName ?? 'User',
      imageUrl: fbUser?.photoURL ??
          'https://ui-avatars.com/api/?name=${fbUser?.displayName ?? 'U'}',
    );

    // Ambil plan dan goals dari SharedPreferences + util
    final prefs = await SharedPreferences.getInstance();
    final planText = prefs.getString('planText') ?? 'Maintaining!';
    final goals = BMICalculatorUtil.getNutritionGoals(planText);

    _nutritionSummary = NutritionSummary(
      currentPlan: planText,
      caloriesConsumed: 0,
      caloriesGoal: goals['calories'] ?? 0,
      proteinConsumed: 0,
      proteinGoal: goals['protein'] ?? 0,
      fatsConsumed: 0,
      fatsGoal: goals['fats'] ?? 0,
      carbsConsumed: 0,
      carbsGoal: goals['carbs'] ?? 0,
      waterConsumedLiters: 0,
      waterGoalLiters: goals['water'] ?? 0,
      stepsTaken: 0,
    );

    _isLoading = false;
    notifyListeners();
  }

  // --- UPDATE GOALS (dari hasil test BMI) ---
  void updateNutritionGoals({
    required String currentPlan,
    required double caloriesGoal,
    required double proteinGoal,
    required double fatsGoal,
    required double carbsGoal,
    required double waterGoalLiters,
  }) {
    if (_nutritionSummary != null) {
      _nutritionSummary = NutritionSummary(
        currentPlan: currentPlan,
        caloriesConsumed: _nutritionSummary!.caloriesConsumed,
        caloriesGoal: caloriesGoal,
        proteinConsumed: _nutritionSummary!.proteinConsumed,
        proteinGoal: proteinGoal,
        fatsConsumed: _nutritionSummary!.fatsConsumed,
        fatsGoal: fatsGoal,
        carbsConsumed: _nutritionSummary!.carbsConsumed,
        carbsGoal: carbsGoal,
        waterConsumedLiters: _nutritionSummary!.waterConsumedLiters,
        waterGoalLiters: waterGoalLiters,
        stepsTaken: _nutritionSummary!.stepsTaken,
      );
      notifyListeners();
      print('Goals updated: $currentPlan - $caloriesGoal kcal');
    }
  }

  // --- NAVIGATION & UI STATE ---
  void onBottomNavTapped(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  void markNotificationAsRead() {
    _hasNewNotification = false;
    notifyListeners();
  }

  // --- TRACKING WATER ---
  void addWater(int amountInMl) {
    if (_nutritionSummary != null) {
      final newWater = _nutritionSummary!.waterConsumedLiters + (amountInMl / 1000.0);
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
      print('Water added: $amountInMl ml -> ${newWater.toStringAsFixed(1)} L');
    }
  }
}