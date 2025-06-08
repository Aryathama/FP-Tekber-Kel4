// === File: lib/views/food_nutrition_page.dart ===
import 'package:flutter/material.dart';
// Tidak perlu lagi import 'package:flutter_svg/flutter_svg.dart'; karena tidak pakai SVG
import 'package:go_router/go_router.dart';
import 'dart:io'; // Untuk menggunakan File

import 'package:nutricore_fe/routes/app_router.dart'; // Untuk DummyNutritionData

class FoodNutritionPage extends StatelessWidget {
  final String imagePath;
  final DummyNutritionData nutritionData; // Menggunakan DummyNutritionData

  const FoodNutritionPage({
    super.key,
    required this.imagePath,
    required this.nutritionData,
  });

  // Widget pembantu untuk menampilkan satu baris nutrisi
  // Sekarang menggunakan Icon() dari Flutter, bukan SvgPicture.asset()
  Widget _buildNutritionRow(BuildContext context, {
    required IconData iconData, // Mengganti iconAssetName menjadi iconData (IconData)
    required String label,
    required String value,
    required double progress,
    required Color color,
  }) {
    return Row(
      children: [
        Icon( // Menggunakan Icon()
          iconData,
          size: 35,
          color: color,
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              LinearProgressIndicator(
                value: progress.clamp(0.0, 1.0),
                backgroundColor: color.withOpacity(0.2),
                color: color,
                minHeight: 8,
                borderRadius: BorderRadius.circular(10),
              ),
            ],
          ),
        ),
        const SizedBox(width: 15),
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  // Helper untuk mendapatkan IconData berdasarkan label nutrisi
  IconData _getIconForNutrition(String label) {
    switch (label.toLowerCase()) {
      case 'protein':
        return Icons.egg_alt_outlined; // Contoh ikon protein
      case 'karbohidrat':
        return Icons.rice_bowl_outlined; // Contoh ikon karbohidrat
      case 'lemak':
        return Icons.local_dining_outlined; // Contoh ikon lemak
      default:
        return Icons.info_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nutrisi'),
        centerTitle: true,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/');
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_horiz),
            onPressed: () {
              // Aksi untuk menu lainnya
            },
          ),
        ],
      ),
      body: Column( // Mengganti SingleChildScrollView menjadi Column agar tombol Add Calorie di bawah layar
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Menampilkan gambar makanan
          Container(
            height: MediaQuery.of(context).size.height * 0.35,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded( // Menggunakan Expanded agar sisa ruang diisi oleh daftar nutrisi
            child: SingleChildScrollView( // Tambahkan SingleChildScrollView di sini
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nama Makanan dan Ringkasan Kalori/Berat
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            nutritionData.foodName.isNotEmpty
                                ? nutritionData.foodName
                                : 'Nama Makanan Tidak Dikenali',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.green.shade800,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Nilai Nutrisi',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '${nutritionData.servingWeightGrams.toStringAsFixed(0)}g',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.green.shade800,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${nutritionData.calories.toStringAsFixed(0)} kal',
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),

                  // Detail Nutrisi (Protein, Karbohidrat, Lemak) menggunakan ikon Material
                  _buildNutritionRow(
                    context,
                    iconData: _getIconForNutrition('protein'), // Menggunakan helper untuk ikon
                    label: 'Protein',
                    value: '${nutritionData.proteinGrams.toStringAsFixed(1)}g',
                    progress: nutritionData.proteinGrams / 100,
                    color: Colors.purple,
                  ),
                  const SizedBox(height: 20),
                  _buildNutritionRow(
                    context,
                    iconData: _getIconForNutrition('karbohidrat'), // Menggunakan helper untuk ikon
                    label: 'Karbohidrat',
                    value: '${nutritionData.carbsGrams.toStringAsFixed(1)}g',
                    progress: nutritionData.carbsGrams / 100,
                    color: Colors.orange,
                  ),
                  const SizedBox(height: 20),
                  _buildNutritionRow(
                    context,
                    iconData: _getIconForNutrition('lemak'), // Menggunakan helper untuk ikon
                    label: 'Lemak',
                    value: '${nutritionData.fatGrams.toStringAsFixed(1)}g',
                    progress: nutritionData.fatGrams / 100,
                    color: Colors.red,
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
          // Tombol "Add Calorie" di bagian bawah layar
          Padding(
            padding: const EdgeInsets.all(60.0),
            child: ElevatedButton(
              onPressed: () {
                // Aksi ketika tombol "Add Calorie" ditekan
                debugPrint('Add Calorie button pressed!');
                // Misalnya, kembali ke Home atau halaman lain
                // context.go('/');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 5,
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Add Calorie',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 10),
                  Icon(Icons.arrow_forward),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
