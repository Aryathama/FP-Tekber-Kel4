// lib/viewmodels/home_viewmodel.dart

import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../models/nutrition_summary_model.dart';
// Di dunia nyata, Anda akan mengimpor Service di sini
// import '../services/api/nutrition_service.dart';

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

  // Simulasi memuat data dari service
  Future<void> loadData() async {
    _isLoading = true;
    notifyListeners(); // Beri tahu UI untuk menampilkan loading indicator

    // Simulasi penundaan jaringan (network delay)
    await Future.delayed(const Duration(seconds: 1));

    // Di aplikasi nyata, data ini akan datang dari service:
    // _user = await _userService.getCurrentUser();
    // _nutritionSummary = await _nutritionService.getTodaysSummary();
    _user = User(
      name: 'Gregorius Akbar',
      imageUrl: 'https://i.pravatar.cc/150?u=gregorius',
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
    notifyListeners(); // Beri tahu UI bahwa data sudah siap dan tampilkan
  }

  void onBottomNavTapped(int index) {
    _selectedIndex = index;
    notifyListeners(); // Update UI untuk item navigasi yang aktif
  }

  void markNotificationAsRead() {
    _hasNewNotification = false;
    notifyListeners(); // Update UI untuk menghilangkan badge notifikasi
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
        waterConsumedLiters: newWater, // Update nilai air
        waterGoalLiters: _nutritionSummary!.waterGoalLiters, 
        stepsTaken: _nutritionSummary!.stepsTaken
      );
      
      notifyListeners(); // Update UI dengan data air yang baru
      print('User added: $amountInMl ml. New total: $newWater L');
    }
  }
}