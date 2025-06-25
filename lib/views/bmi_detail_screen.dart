// Lokasi file: lib/views/onboarding/bmi_detail_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../viewmodels/bmi_detail_viewmodel.dart';
import '../viewmodels/home_viewmodel.dart';
import 'home_page.dart';
import '../../models/user_profile.dart'; // Mungkin diperlukan untuk data lain

class BMIDetailScreen extends StatelessWidget {
  const BMIDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Menggunakan Consumer untuk mendapatkan data dari BMIDetailViewModel.
    return Consumer<BMIDetailViewModel>(
      builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            toolbarHeight: 0,
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  const Text(
                    "Our plan for you is",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Text(
                    viewModel.planText,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: viewModel.dynamicColor,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    "${viewModel.bmi.toStringAsFixed(0)} BMI",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: viewModel.dynamicColor,
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'Your BMI category is ',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: viewModel.bmiCategory,
                          style: TextStyle(
                            color: viewModel.dynamicColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildUserInfoColumn(
                        icon: viewModel.gender == Gender.male
                            ? Icons.male
                            : Icons.female,
                        label: 'Gender',
                        value: viewModel.genderText,
                      ),
                      _buildUserInfoColumn(
                        icon: Icons.person,
                        label: 'Age',
                        value: '${viewModel.age}',
                      ),
                      _buildUserInfoColumn(
                        icon: Icons.monitor_weight,
                        label: 'Weight',
                        value: '${viewModel.weight} kg',
                      ),
                      _buildUserInfoColumn(
                        icon: Icons.height,
                        label: 'Height',
                        value: '${viewModel.height} cm',
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  _buildBMICategoryRow('Underweight', '< 18.5', Colors.blue),
                  const SizedBox(height: 10),
                  _buildBMICategoryRow('Normal', '18.5 - 24.9', Colors.green),
                  const SizedBox(height: 10),
                  _buildBMICategoryRow(
                      'Overweight', '25 - 29.9', Colors.orange),
                  const SizedBox(height: 10),
                  _buildBMICategoryRow('Obese', '> 30', Colors.red),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 50,
                          width: 350,
                          child: ElevatedButton(
                            // --- REVISI: INI ADALAH BAGIAN YANG DIUBAH TOTAL ---
                            onPressed: () async {
                              // 1. Ambil data goals dari BMIDetailViewModel
                              final bmiViewModel = Provider.of<BMIDetailViewModel>(context, listen: false);
                              
                              final double calculatedCalories = bmiViewModel.caloriesGoal;
                              final double calculatedWater = bmiViewModel.waterGoalLiters;
                              final double calculatedProtein = bmiViewModel.proteinGoal;
                              final double calculatedFats = bmiViewModel.fatsGoal;
                              final double calculatedCarbs = bmiViewModel.carbsGoal;
                              final String currentPlanText = bmiViewModel.planText;

                              // 2. Dapatkan instance HomeViewModel yang sudah ada
                              final prefs = await SharedPreferences.getInstance();
                              await prefs.setString('planText', currentPlanText);

                              // karena sudah disediakan di main.dart
                              final homeViewModel = Provider.of<HomeViewModel>(context, listen: false);
                              
                              // 3. Panggil metode untuk memperbarui goals di HomeViewModel
                              homeViewModel.updateNutritionGoals(
                                currentPlan: currentPlanText,
                                caloriesGoal: calculatedCalories,
                                waterGoalLiters: calculatedWater,
                                proteinGoal: calculatedProtein,
                                fatsGoal: calculatedFats,
                                carbsGoal: calculatedCarbs,
                              );

                              // 4. Navigasi ke HomePage dan hapus semua halaman sebelumnya
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HomePage(), // Cukup panggil HomePage
                                ),
                                (Route<dynamic> route) => false,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green[600],
                              foregroundColor: Colors.white,
                              minimumSize: const Size(double.infinity, 55),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 0,
                            ),
                            child: const Text(
                              'Go to Homepage →',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // Helper widget untuk menampilkan info user (gender, umur, dll)
  Widget _buildUserInfoColumn({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Column(
      children: [
        Icon(icon, size: 30, color: Colors.grey[700]),
        const SizedBox(height: 5),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[700],
            fontSize: 14,
            fontWeight: FontWeight.normal,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          value,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  // Helper widget untuk menampilkan baris kategori BMI
  Widget _buildBMICategoryRow(String category, String range, Color dotColor) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: dotColor,
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Text(
            category,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Text(
          range,
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}