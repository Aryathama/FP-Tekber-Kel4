// lib/models/nutrition_summary_model.dart

class NutritionSummary {
  final String currentPlan;
  final double caloriesConsumed;
  final double caloriesGoal;
  final double proteinConsumed;
  final double proteinGoal;
  final double fatsConsumed;
  final double fatsGoal;
  final double carbsConsumed;
  final double carbsGoal;
  final double waterConsumedLiters;
  final double waterGoalLiters;
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
}