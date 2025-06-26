import 'package:flutter/material.dart';
import 'package:nutricore/models/user_model.dart';
import 'package:nutricore/services/local/auth_service.dart';
import 'package:nutricore/services/local/firestore_service.dart';
// Menggunakan utilitas yang sudah ada dari teman Anda
import 'package:nutricore/utils/bmi_calculator_util.dart';

/// ViewModel ini bertindak sebagai 'otak' atau 'orkestrator' untuk seluruh alur kuis onboarding.
class QuizViewModel with ChangeNotifier {
  final AuthService _authService;
  final FirestoreService _firestoreService;

  QuizViewModel(this._authService, this._firestoreService);

  // --- STATE SEMENTARA UNTUK MENYIMPAN INPUT KUIS ---
  int? _age;
  double? _weight;
  double? _height;
  String? _gender; // 'male' atau 'female'

  // --- METHODS UNTUK DIPANGGIL DARI SETIAP HALAMAN KUIS ---
  void setAge(int age) => _age = age;
  void setWeight(double weight) => _weight = weight;
  void setHeight(double height) => _height = height;
  void setGender(String gender) => _gender = gender.toLowerCase();

  // --- AKSI UTAMA: KALKULASI DAN SIMPAN PROFIL ---
  Future<void> calculateAndSaveProfile() async {
    final currentUser = _authService.currentUser;

    if (currentUser == null || _age == null || _weight == null || _height == null || _gender == null) {
      throw Exception("Data kuis tidak lengkap untuk membuat profil.");
    }

    // --- PERBAIKAN: Menggunakan method dari BMICalculatorUtil ---
    // 1. Hitung BMI. Cast double ke int sesuai requirement fungsi teman Anda.
    final bmi = BMICalculatorUtil.calculateBMI(_weight!.toInt(), _height!.toInt());

    // 2. Dapatkan kategori BMI
    final bmiCategory = BMICalculatorUtil.getBMICategory(bmi);

    // 3. Dapatkan nama rencana dari kategori BMI
    final planName = BMICalculatorUtil.getPlanText(bmiCategory).replaceAll('!', ''); // Hapus '!'

    // 4. Hitung kebutuhan nutrisi harian (logika ini kita letakkan di sini)
    final needs = _calculateDailyNeeds(_weight!, _height!, _age!, _gender!, planName);

    // 5. Buat objek UserModel yang lengkap
    final userProfile = UserModel(
      id: currentUser.uid,
      name: currentUser.displayName ?? 'New User',
      email: currentUser.email!,
      age: _age,
      weight: _weight,
      height: _height,
      gender: _gender,
      bmi: bmi,
      nutritionPlan: planName,
      targetCalories: needs['calories'],
      targetProtein: needs['protein'],
      targetCarbs: needs['carbs'],
      targetFat: needs['fat'],
    );

    // 6. Simpan profil lengkap ke Firestore
    await _firestoreService.saveUserProfile(userProfile);
  }

  // --- HELPER UNTUK KALKULASI KEBUTUHAN HARIAN ---
  Map<String, double> _calculateDailyNeeds(double weight, double height, int age, String gender, String plan) {
    // Rumus Harris-Benedict untuk BMR
    double bmr;
    if (gender == 'male') {
      bmr = 88.362 + (13.397 * weight) + (4.799 * height) - (5.677 * age);
    } else {
      bmr = 447.593 + (9.247 * weight) + (3.098 * height) - (4.330 * age);
    }

    // TDEE (Total Daily Energy Expenditure), asumsi aktivitas ringan
    double tdee = bmr * 1.375;

    // Sesuaikan kalori berdasarkan rencana
    double targetCalories;
    if (plan == 'Bulking') {
      targetCalories = tdee + 400;
    } else if (plan == 'Cutting') {
      targetCalories = tdee - 400;
    } else {
      targetCalories = tdee; // Maintain
    }

    // Hitung makronutrien (contoh: 30% P, 40% C, 30% F)
    return {
      'calories': targetCalories,
      'protein': (targetCalories * 0.30) / 4,
      'carbs': (targetCalories * 0.40) / 4,
      'fat': (targetCalories * 0.30) / 9,
    };
  }
}
