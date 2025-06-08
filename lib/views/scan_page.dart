import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nutricore_fe/routes/app_router.dart'; // Mengimpor DummyNutritionData

class ScanPage extends StatelessWidget {
  final String? imagePath; // Path gambar dummy yang akan diterima

  const ScanPage({super.key, this.imagePath});

  // Fungsi untuk membuat data nutrisi dummy untuk Nasi Goreng
  DummyNutritionData _createDummyNasiGorengNutritionData() {
    return DummyNutritionData(
      foodName: "Nasi Goreng",
      calories: 450.0,
      proteinGrams: 15.0,
      carbsGrams: 50.0,
      fatGrams: 20.0,
      servingUnit: 'portion',
      servingWeightGrams: 300.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (imagePath == null) {
      return Center(
        child: Text(
          'Tidak ada gambar dummy yang disediakan.\nKembali ke Home dan pilih gambar.',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey.shade500, fontSize: 18),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Analisis Makanan'),
        centerTitle: true,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/'); // Kembali ke HomePage
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Menampilkan gambar dummy dari assets
              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.green.shade300, width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Image.asset(
                    imagePath!, // imagePath sekarang adalah path ke aset
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      // Placeholder jika gambar aset tidak ditemukan
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.broken_image, size: 80, color: Colors.red.shade300),
                            const SizedBox(height: 10),
                            const Text(
                              'Gambar aset tidak ditemukan!',
                              style: TextStyle(color: Colors.red, fontSize: 16),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 30),
              // Tombol untuk "memproses" dan navigasi ke halaman nutrisi dummy
              ElevatedButton(
                onPressed: () {
                  final dummyNutrition = _createDummyNasiGorengNutritionData();
                  context.pushReplacement('/nutrition', extra: {
                    'imagePath': imagePath!, // Kirim path gambar dummy
                    'nutritionData': dummyNutrition,
                  });
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: Colors.green.shade700,
                  foregroundColor: Colors.white,
                  elevation: 5,
                ),
                child: const Text(
                  'Simulasikan Analisis Nasi Goreng', // Ubah teks tombol
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}