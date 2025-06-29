import 'package:flutter/material.dart';
import '/models/user_profile.dart'; // Sesuaikan path
import '/utils/bmi_calculator_util.dart'; // Sesuaikan path

class BMIDetailViewModel extends ChangeNotifier {
  final UserProfile _userProfile;

  BMIDetailViewModel(this._userProfile) {
    if (_userProfile.weight == null || _userProfile.height == null) {
      throw ArgumentError('Weight and Height must be provided for BMI calculation.');
    }
    if (_userProfile.age == null) {
      print('Warning: Age is null in BMIDetailViewModel');
    }
    if (_userProfile.gender == null) {
      print('Warning: Gender is null in BMIDetailViewModel');
    }
  }

  // Getters untuk data dari UserProfile
  Gender? get gender => _userProfile.gender;
  int? get age => _userProfile.age;
  int? get weight => _userProfile.weight;
  int? get height => _userProfile.height;

  // Getters untuk hasil perhitungan BMI
  double get bmi => BMICalculatorUtil.calculateBMI(weight!, height!);
  String get bmiCategory => BMICalculatorUtil.getBMICategory(bmi);
  Color get dynamicColor => BMICalculatorUtil.getCategoryColor(bmiCategory);
  String get planText => BMICalculatorUtil.getPlanText(bmiCategory);

  // Getter untuk tampilan teks gender
  String get genderText {
    if (gender == Gender.male) {
      return 'Male';
    } else if (gender == Gender.female) {
      return 'Female';
    }
    return '';
  }

  // --- Getters dinamis untuk nilai goals berdasarkan planText ---
  double get caloriesGoal => BMICalculatorUtil.getNutritionGoals(planText)['calories']!;
  double get waterGoalLiters => BMICalculatorUtil.getNutritionGoals(planText)['water']!;
  double get proteinGoal => BMICalculatorUtil.getNutritionGoals(planText)['protein']!;
  double get fatsGoal => BMICalculatorUtil.getNutritionGoals(planText)['fats']!;
  double get carbsGoal => BMICalculatorUtil.getNutritionGoals(planText)['carbs']!;
}