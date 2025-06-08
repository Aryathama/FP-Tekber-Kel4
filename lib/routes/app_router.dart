// === File: lib/routes/app_router.dart ===
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart'; // Diperlukan untuk Builder context

import 'package:nutricore_fe/views/home_page.dart';
import 'package:nutricore_fe/views/scan_page.dart';
import 'package:nutricore_fe/views/food_nutrition_page.dart';

// Struktur data dummy untuk nutrisi yang akan dikirim antar halaman
// Didefinisikan di sini karena tidak ada folder models terpisah untuk saat ini
class DummyNutritionData {
  final String foodName;
  final double calories;
  final double proteinGrams;
  final double carbsGrams;
  final double fatGrams;
  final String servingUnit;
  final double servingWeightGrams;

  DummyNutritionData({
    required this.foodName,
    required this.calories,
    required this.proteinGrams,
    required this.carbsGrams,
    required this.fatGrams,
    required this.servingUnit,
    required this.servingWeightGrams,
  });

  // Tambahkan metode ini agar objek dapat dibandingkan dalam test
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is DummyNutritionData &&
              runtimeType == other.runtimeType &&
              foodName == other.foodName &&
              calories == other.calories &&
              proteinGrams == other.proteinGrams &&
              carbsGrams == other.carbsGrams &&
              fatGrams == other.fatGrams &&
              servingUnit == other.servingUnit &&
              servingWeightGrams == other.servingWeightGrams;

  @override
  int get hashCode =>
      foodName.hashCode ^
      calories.hashCode ^
      proteinGrams.hashCode ^
      carbsGrams.hashCode ^
      fatGrams.hashCode ^
      servingUnit.hashCode ^
      servingWeightGrams.hashCode;
}

class AppRouter {
  static final GoRouter router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: '/',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/scan',
        builder: (context, state) => ScanPage(imagePath: state.extra as String?),
      ),
      GoRoute(
        path: '/nutrition',
        builder: (context, state) {
          final args = state.extra as Map<String, dynamic>;
          return FoodNutritionPage(
            imagePath: args['imagePath'] as String,
            nutritionData: args['nutritionData'] as DummyNutritionData,
          );
        },
      ),
    ],
  );
}
