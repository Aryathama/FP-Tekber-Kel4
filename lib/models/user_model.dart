// lib/models/user_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id; // Diambil dari Firebase Auth UID
  final String name;
  final String email;

  // Data dari kuis
  final int? age;
  final double? weight;
  final double? height;
  final String? gender;

  // Data hasil kalkulasi
  final double? bmi;
  final String? nutritionPlan; // 'Bulking', 'Maintain', atau 'Cutting'
  final double? targetCalories;
  final double? targetProtein;
  final double? targetCarbs;
  final double? targetFat;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.age,
    this.weight,
    this.height,
    this.gender,
    this.bmi,
    this.nutritionPlan,
    this.targetCalories,
    this.targetProtein,
    this.targetCarbs,
    this.targetFat,
  });

  // Factory untuk membuat dari dokumen Firestore
  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return UserModel(
      id: doc.id,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      age: data['age'],
      weight: (data['weight'] as num?)?.toDouble(),
      height: (data['height'] as num?)?.toDouble(),
      gender: data['gender'],
      bmi: (data['bmi'] as num?)?.toDouble(),
      nutritionPlan: data['nutritionPlan'],
      targetCalories: (data['targetCalories'] as num?)?.toDouble(),
      targetProtein: (data['targetProtein'] as num?)?.toDouble(),
      targetCarbs: (data['targetCarbs'] as num?)?.toDouble(),
      targetFat: (data['targetFat'] as num?)?.toDouble(),
    );
  }

  // Method untuk mengubah menjadi Map agar bisa disimpan ke Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'email': email,
      'age': age,
      'weight': weight,
      'height': height,
      'gender': gender,
      'bmi': bmi,
      'nutritionPlan': nutritionPlan,
      'targetCalories': targetCalories,
      'targetProtein': targetProtein,
      'targetCarbs': targetCarbs,
      'targetFat': targetFat,
    };
  }
}