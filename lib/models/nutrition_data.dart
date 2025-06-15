// models/nutrition_data.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class NutritionData {
  final String id; // Untuk ID dokumen di Firestore
  final String foodName;
  final double calories;
  final double protein;
  final double carbs;
  final double fat;
  final String description; // Deskripsi singkat dari Gemini
  final List<String> ingredients; // Bahan-bahan utama
  final DateTime createdAt;

  NutritionData({
    required this.id,
    required this.foodName,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fat,
    required this.description,
    required this.ingredients,
    required this.createdAt,
  });

  // Factory constructor untuk membuat instance dari JSON (output Gemini)
  factory NutritionData.fromJson(Map<String, dynamic> json) {
    return NutritionData(
      id: '', // ID akan diisi oleh Firestore
      foodName: json['foodName'] ?? 'Tidak Dikenali',
      calories: (json['calories'] as num?)?.toDouble() ?? 0.0,
      protein: (json['protein'] as num?)?.toDouble() ?? 0.0,
      carbs: (json['carbs'] as num?)?.toDouble() ?? 0.0,
      fat: (json['fat'] as num?)?.toDouble() ?? 0.0,
      description: json['description'] ?? 'Tidak ada deskripsi.',
      ingredients: List<String>.from(json['ingredients'] ?? []),
      createdAt: DateTime.now(),
    );
  }

  // Factory constructor untuk membuat instance dari dokumen Firestore
  factory NutritionData.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return NutritionData(
      id: doc.id,
      foodName: data['foodName'] ?? 'Tidak Dikenali',
      calories: (data['calories'] as num?)?.toDouble() ?? 0.0,
      protein: (data['protein'] as num?)?.toDouble() ?? 0.0,
      carbs: (data['carbs'] as num?)?.toDouble() ?? 0.0,
      fat: (data['fat'] as num?)?.toDouble() ?? 0.0,
      description: data['description'] ?? 'Tidak ada deskripsi.',
      ingredients: List<String>.from(data['ingredients'] ?? []),
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  // Method untuk mengubah instance menjadi Map untuk disimpan ke Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'foodName': foodName,
      'calories': calories,
      'protein': protein,
      'carbs': carbs,
      'fat': fat,
      'description': description,
      'ingredients': ingredients,
      'createdAt': FieldValue.serverTimestamp(),
    };
  }
}
