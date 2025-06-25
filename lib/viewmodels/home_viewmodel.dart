// lib/viewmodels/home_viewmodel.dart

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:health_tracker_app/utils/bmi_calculator_util.dart';
import 'package:health_tracker_app/viewmodels/bmi_detail_viewmodel.dart';
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
    // Memuat data saat ViewModel pertama kali dibuat
    loadData();
  }

  // --- LOGIC (METHODS) ---

  // Simulasi memuat data dari service.
  // REVISI: Buat data default yang lebih masuk akal.
  Future<void> loadData() async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1));

    _user = User(
      name: 'Gregorius Akbar',
      imageUrl: 'https://i.pravatar.cc/150?u=gregorius',
    );

    // REVISI: Inisialisasi dengan nilai default/kosong yang akan di-update.
    // Atau, Anda bisa memuat dari SharedPreferences jika sudah pernah di-set.
    // Ambil planText dari SharedPreferences (default: 'Maintaining!')
    final prefs = await SharedPreferences.getInstance();
    final planText = prefs.getString('planText') ?? 'Maintaining!';
    final goals = BMICalculatorUtil.getNutritionGoals(planText);

    _nutritionSummary = NutritionSummary(
      currentPlan: planText, // Ambil plan dari BMIDetailViewModel
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
  
  // --- REVISI: Metode baru untuk update goals dari BMI Detail Screen ---
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
      print('Goals updated from BMI screen: $currentPlan, Kalori=$caloriesGoal');
    }
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
        stepsTaken: _nutritionSummary!.stepsTaken
      );
      
      notifyListeners();
      print('User added: $amountInMl ml. New total: $newWater L');
    }
  }
}