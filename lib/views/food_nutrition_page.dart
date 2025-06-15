import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nutricore/models/nutrition_data.dart';
import 'package:nutricore/viewmodels/nutrition_viewmodel.dart';
import 'package:provider/provider.dart';

class FoodNutritionPage extends StatelessWidget {
  final NutritionData nutritionData;

  const FoodNutritionPage({
    super.key,
    required this.nutritionData,
  });

  // Widget untuk baris nutrisi, tidak ada perubahan
  Widget _buildNutritionRow(
      {required IconData icon,
        required String label,
        required String value,
        required double progress,
        required Color color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 28),
              const SizedBox(width: 16),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              const Spacer(),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey.shade200,
            color: color,
            minHeight: 8,
            borderRadius: BorderRadius.circular(5),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<NutritionViewModel>();

    final proteinProgress = nutritionData.protein / 90;
    final carbsProgress = nutritionData.carbs / 150;
    final fatProgress = nutritionData.fat / 70;

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.height * 0.4,
            pinned: true,
            stretch: true,
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.black87,
            elevation: 0,
            leading: Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 16.0),
              child: CircleAvatar(
                backgroundColor: Colors.black.withOpacity(0.5),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => context.go('/'),
                ),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: viewModel.pickedImage != null
                  ? Image.file(
                File(viewModel.pickedImage!.path),
                fit: BoxFit.cover,
              )
                  : Container(
                color: Colors.grey.shade300,
                child: const Icon(Icons.image_not_supported,
                    size: 50, color: Colors.grey),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Transform.translate(
              offset: const Offset(0, -30),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                  BorderRadius.vertical(top: Radius.circular(30)),
                ),
                // PERUBAHAN: Padding diubah untuk memberi jarak atas dan bawah
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 40, 24, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // SizedBox yang sebelumnya di sini sudah digantikan oleh Padding di atas
                      // --- Header ---
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  nutritionData.foodName,
                                  style: const TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                                const SizedBox(height: 4),
                                const Text(
                                  'Nutrition value',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text(
                                '100g',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${nutritionData.calories.toStringAsFixed(0)} cal',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: 24),
                      const Divider(),
                      // --- Nutrition Details ---
                      _buildNutritionRow(
                        icon: Icons.local_florist_outlined,
                        label: 'Protein',
                        value: '${nutritionData.protein.toStringAsFixed(1)}g',
                        progress: proteinProgress,
                        color: Colors.green,
                      ),
                      _buildNutritionRow(
                        icon: Icons.local_fire_department_outlined,
                        label: 'Carbs',
                        value: '${nutritionData.carbs.toStringAsFixed(1)}g',
                        progress: carbsProgress,
                        color: Colors.orange,
                      ),
                      _buildNutritionRow(
                        icon: Icons.water_drop_outlined,
                        label: 'Fat',
                        value: '${nutritionData.fat.toStringAsFixed(1)}g',
                        progress: fatProgress,
                        color: Colors.red,
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 12),
          child: ElevatedButton(
            onPressed: () {
              context.go('/');
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content:
                  Text('${nutritionData.foodName} berhasil ditambahkan!'),
                  backgroundColor: Colors.green,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Add Calorie',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 8),
                Icon(Icons.arrow_forward),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
