// lib/models/nutrition_summary_model.dart

class NutritionSummary {
  final String currentPlan;
  final double caloriesConsumed;
  final double caloriesGoal; // Pastikan ini ada
  final double proteinConsumed;
  final double proteinGoal; // Pastikan ini ada
  final double fatsConsumed;
  final double fatsGoal;     // Pastikan ini ada
  final double carbsConsumed;
  final double carbsGoal;    // Pastikan ini ada
  final double waterConsumedLiters;
  final double waterGoalLiters; // Pastikan ini ada
  final int stepsTaken;

  NutritionSummary({
    required this.currentPlan,
    required this.caloriesConsumed,
    required this.caloriesGoal,
    required this.proteinConsumed,
    required this.proteinGoal,
    required this.fatsConsumed,
    required this.fatsGoal,
    required this.carbsConsumed,
    required this.carbsGoal,
    required this.waterConsumedLiters,
    required this.waterGoalLiters,
    required this.stepsTaken,
  });

  // Tambahkan metode copyWith untuk memudahkan pembuatan instance baru dengan perubahan
  NutritionSummary copyWith({
    String? currentPlan,
    double? caloriesConsumed,
    double? caloriesGoal,
    double? proteinConsumed,
    double? proteinGoal,
    double? fatsConsumed,
    double? fatsGoal,
    double? carbsConsumed,
    double? carbsGoal,
    double? waterConsumedLiters,
    double? waterGoalLiters,
    int? stepsTaken,
  }) {
    return NutritionSummary(
      currentPlan: currentPlan ?? this.currentPlan,
      caloriesConsumed: caloriesConsumed ?? this.caloriesConsumed,
      caloriesGoal: caloriesGoal ?? this.caloriesGoal,
      proteinConsumed: proteinConsumed ?? this.proteinConsumed,
      proteinGoal: proteinGoal ?? this.proteinGoal,
      fatsConsumed: fatsConsumed ?? this.fatsConsumed,
      fatsGoal: fatsGoal ?? this.fatsGoal,
      carbsConsumed: carbsConsumed ?? this.carbsConsumed,
      carbsGoal: carbsGoal ?? this.carbsGoal,
      waterConsumedLiters: waterConsumedLiters ?? this.waterConsumedLiters,
      waterGoalLiters: waterGoalLiters ?? this.waterGoalLiters,
      stepsTaken: stepsTaken ?? this.stepsTaken,
    );
  }
}