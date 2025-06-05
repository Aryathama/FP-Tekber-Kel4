import 'package:flutter/material.dart';
import '../api/api_service.dart';
import '../models/nutrition_model.dart';

class NutritionScreen extends StatefulWidget {
  const NutritionScreen({super.key});

  @override
  _NutritionScreenState createState() => _NutritionScreenState();
}

class _NutritionScreenState extends State<NutritionScreen> {
  final TextEditingController _controller = TextEditingController();
  NutritionModel? _nutritionData;
  bool _isLoading = false;
  String? _error;

  void _cekNutrisi() async {
    setState(() {
      _isLoading = true;
      _nutritionData = null;
      _error = null;
    });

    try {
      final api = ApiService();
      final data = await api.getNutritionData(_controller.text);
      setState(() {
        _nutritionData = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Gagal memuat data: $e';
        _isLoading = false;
      });
    }
  }

  Widget _buildNutritionCard() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (_error != null) {
      return Text(_error!, style: const TextStyle(color: Colors.red));
    } else if (_nutritionData != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image dan judul
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              'assets/avocado_dish.jpg', // ganti sesuai image asset kamu
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            _nutritionData!.foodName,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            "100g • ${_nutritionData!.calories} cal",
            style: const TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 24),

          // Protein
          _buildNutritionRow("Protein", _nutritionData!.protein, 22, Colors.green, Icons.spa),
          const SizedBox(height: 12),

          // Carbs
          _buildNutritionRow("Carbs", _nutritionData!.carbs, 1.8, Colors.amber, Icons.coffee),
          const SizedBox(height: 12),

          // Fat
          _buildNutritionRow("Fat", _nutritionData!.fat, 19, Colors.redAccent, Icons.bubble_chart),
          const SizedBox(height: 24),

          // Bottom card info
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              children: [
                Image.asset('assets/avocado_icon.png', width: 48),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Health body comes with good nutrition",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4),
                      Text("Get good nutrition now!", style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.yellow.shade600,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: const Icon(Icons.arrow_forward, color: Colors.white),
                )
              ],
            ),
          )
        ],
      );
    } else {
      return const Text("Masukkan nama makanan dan tekan Cek.");
    }
  }

  Widget _buildNutritionRow(String title, double value, double maxValue, Color color, IconData icon) {
    double percentage = (value / maxValue).clamp(0, 1);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: 8),
            Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            const Spacer(),
            Text("${value}g", style: const TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
        const SizedBox(height: 4),
        LinearProgressIndicator(
          value: percentage,
          color: color,
          backgroundColor: Colors.grey.shade300,
          minHeight: 6,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nutrition'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Nama Makanan',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _cekNutrisi,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow.shade700,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text('Cek Nutrisi'),
            ),
            const SizedBox(height: 24),
            _buildNutritionCard(),
          ],
        ),
      ),
    );
  }
}
