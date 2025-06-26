import 'package:flutter/material.dart'; // Untuk Colors

class BMICalculatorUtil {
  static double calculateBMI(int weight, int heightCm) {
    if (heightCm == 0) return 0.0; // Hindari pembagian dengan nol
    double heightInMeters = heightCm / 100.0;
    return weight / (heightInMeters * heightInMeters);
  }

  static String getBMICategory(double bmi) {
    if (bmi < 18.5) {
      return 'Underweight';
    } else if (bmi >= 18.5 && bmi < 25.0) {
      return 'Normal';
    } else if (bmi >= 25.0 && bmi < 30.0) {
      return 'Overweight';
    } else {
      return 'Obese';
    }
  }

  static Color getCategoryColor(String category) {
    switch (category) {
      case 'Underweight':
        return Colors.lightBlue;
      case 'Normal':
        return Colors.green;
      case 'Overweight':
        return Colors.orange;
      case 'Obese':
        return Colors.red;
      default:
        return Colors.black;
    }
  }

  static String getPlanText(String category) {
    switch (category) {
      case 'Underweight':
        return 'Bulking!';
      case 'Normal':
        return 'Maintaining!';
      case 'Overweight':
      case 'Obese':
        return 'Cutting!';
      default:
        return 'Unknown!';
    }
  }
}