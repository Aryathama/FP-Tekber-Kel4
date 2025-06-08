// === File: test/unit_test.dart ===
import 'package:flutter_test/flutter_test.dart';
import 'package:nutricore_fe/routes/app_router.dart'; // Impor DummyNutritionData

void main() {
  group('DummyNutritionData', () {
    test('Objek DummyNutritionData dapat dibuat dengan benar', () {
      final nutrition = DummyNutritionData(
        foodName: 'Nasi Goreng',
        calories: 450.0,
        proteinGrams: 15.0,
        carbsGrams: 50.0,
        fatGrams: 20.0,
        servingUnit: 'portion',
        servingWeightGrams: 300.0,
      );

      expect(nutrition.foodName, 'Nasi Goreng');
      expect(nutrition.calories, 450.0);
      expect(nutrition.proteinGrams, 15.0);
      expect(nutrition.carbsGrams, 50.0);
      expect(nutrition.fatGrams, 20.0);
      expect(nutrition.servingUnit, 'portion');
      expect(nutrition.servingWeightGrams, 300.0);
    });

    test('Dua objek DummyNutritionData dengan nilai yang sama dianggap setara', () {
      final nutrition1 = DummyNutritionData(
        foodName: 'Nasi Goreng',
        calories: 450.0,
        proteinGrams: 15.0,
        carbsGrams: 50.0,
        fatGrams: 20.0,
        servingUnit: 'portion',
        servingWeightGrams: 300.0,
      );
      final nutrition2 = DummyNutritionData(
        foodName: 'Nasi Goreng',
        calories: 450.0,
        proteinGrams: 15.0,
        carbsGrams: 50.0,
        fatGrams: 20.0,
        servingUnit: 'portion',
        servingWeightGrams: 300.0,
      );

      expect(nutrition1, nutrition2);
      expect(nutrition1.hashCode, nutrition2.hashCode);
    });

    test('Dua objek DummyNutritionData dengan nilai berbeda tidak setara', () {
      final nutrition1 = DummyNutritionData(
        foodName: 'Nasi Goreng',
        calories: 450.0,
        proteinGrams: 15.0,
        carbsGrams: 50.0,
        fatGrams: 20.0,
        servingUnit: 'portion',
        servingWeightGrams: 300.0,
      );
      final nutrition2 = DummyNutritionData(
        foodName: 'Nasi Goreng', // Food name sama
        calories: 500.0, // Kalori berbeda
        proteinGrams: 15.0,
        carbsGrams: 50.0,
        fatGrams: 20.0,
        servingUnit: 'portion',
        servingWeightGrams: 300.0,
      );

      expect(nutrition1, isNot(equals(nutrition2)));
    });
  });
}
