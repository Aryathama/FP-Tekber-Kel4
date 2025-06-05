import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xFF4CAF50); // Hijau utama
  static const secondary = Color(0xFF81C784);
  static const background = Color(0xFFF5F5F5);
  static const card = Color(0xFFFFFFFF);
  static const textPrimary = Color(0xFF212121);
  static const textSecondary = Color(0xFF757575);
  static const danger = Color(0xFFE53935);
}

class AppTextStyles {
  static const title = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static const subtitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
  );

  static const body = TextStyle(
    fontSize: 14,
    color: AppColors.textPrimary,
  );
}
