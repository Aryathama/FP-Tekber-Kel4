// services/api/nutritionix_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nutricore/models/nutrition_data.dart';

class NutritionixService {
  // Kunci API tetap dibaca dari environment variables
  static const String _appId = String.fromEnvironment('NUTRITIONIX_APP_ID');
  static const String _apiKey = String.fromEnvironment('NUTRITIONIX_API_KEY');

  final String _url = 'https://trackapi.nutritionix.com/v2/natural/nutrients';

  // --- Perubahan untuk Dependency Injection ---
  // 1. Tambahkan http.Client sebagai properti final
  final http.Client _client;

  // 2. Buat constructor yang bisa menerima client dari luar.
  //    Jika tidak ada yang diberikan (saat aplikasi berjalan normal), ia akan membuat http.Client() baru.
  //    Ini memungkinkan kita menyuntikkan MockClient saat testing.
  NutritionixService({http.Client? client}) : _client = client ?? http.Client();
  // ---------------------------------------------

  Future<NutritionData> getNutritionData(String foodName) async {
    if (_appId.isEmpty || _apiKey.isEmpty) {
      throw Exception('Nutritionix API keys are not configured.');
    }

    try {
      // 3. Gunakan _client.post, bukan lagi http.post statis
      final response = await _client.post(
        Uri.parse(_url),
        headers: {
          'Content-Type': 'application/json',
          'x-app-id': _appId,
          'x-app-key': _apiKey,
        },
        body: jsonEncode({'query': foodName}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['foods'] == null || (data['foods'] as List).isEmpty) {
          throw Exception('Makanan "$foodName" tidak ditemukan oleh Nutritionix.');
        }
        final foodData = data['foods'][0];

        // Mengubah data dari Nutritionix menjadi model NutritionData kita
        return NutritionData.fromJson({
          'foodName': foodData['food_name'] ?? 'Unknown',
          'calories': foodData['nf_calories'] ?? 0.0,
          'protein': foodData['nf_protein'] ?? 0.0,
          'carbs': foodData['nf_total_carbohydrate'] ?? 0.0,
          'fat': foodData['nf_total_fat'] ?? 0.0,
          'description': 'Analisis nutrisi detail untuk ${foodData['food_name']}.',
          'ingredients': [foodData['food_name']],
        });
      } else {
        throw Exception('Gagal mendapatkan data dari Nutritionix. Status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan saat menghubungi Nutritionix: $e');
    }
  }
}
