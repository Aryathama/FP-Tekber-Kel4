// services/api/gemini_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class GeminiService {
  static const String _apiKey = String.fromEnvironment('GEMINI_API_KEY');
  final String _model = "gemini-2.0-flash";

  // Method diubah untuk mengembalikan Future<String> (nama makanan)
  // dan namanya diubah menjadi identifyFoodInImage
  Future<String> identifyFoodInImage(XFile imageFile) async {
    if (_apiKey.isEmpty) {
      throw Exception('Gemini API key is not configured.');
    }

    final Uri url = Uri.parse(
        'https://generativelanguage.googleapis.com/v1beta/models/$_model:generateContent?key=$_apiKey');

    final imageBytes = await imageFile.readAsBytes();
    final String base64Image = base64Encode(imageBytes);

    // Prompt diperbarui agar hanya meminta nama makanan dalam format simpel.
    const String prompt = "Identify the main food item in this image. Provide only the name of the food, for example: 'Nasi Goreng with Fried Egg'. Do not add any other text or markdown specifiers like ```json.";

    final String requestBody = jsonEncode({
      "contents": [
        {
          "parts": [
            {"text": prompt},
            {
              "inline_data": {
                "mime_type": "image/jpeg",
                "data": base64Image,
              }
            }
          ]
        }
      ]
    });

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: requestBody,
      );

      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        // Mengambil dan membersihkan teks respons untuk mendapatkan nama makanan
        final String foodName = decodedResponse['candidates'][0]['content']['parts'][0]['text'];
        return foodName.trim(); // .trim() untuk menghapus spasi/baris baru yang tidak perlu
      } else {
        print("Error from Gemini API: ${response.body}");
        throw Exception('Gagal mengidentifikasi gambar dari Gemini.');
      }
    } catch (e) {
      print("Error calling Gemini Service: $e");
      throw Exception('Terjadi kesalahan saat menghubungi Gemini.');
    }
  }
}
