class NutritionModel {
  final String foodName;
  final double calories;
  final double protein;
  final double fat;
  final double carbs;

  NutritionModel({
    required this.foodName,
    required this.calories,
    required this.protein,
    required this.fat,
    required this.carbs,
  });

  factory NutritionModel.fromJson(Map<String, dynamic> json) {
    final food = json['foods'][0];
    return NutritionModel(
      foodName: food['food_name'] ?? '',
      calories: (food['nf_calories'] ?? 0).toDouble(),
      protein: (food['nf_protein'] ?? 0).toDouble(),
      fat: (food['nf_total_fat'] ?? 0).toDouble(),
      carbs: (food['nf_total_carbohydrate'] ?? 0).toDouble(),
    );
  }
}