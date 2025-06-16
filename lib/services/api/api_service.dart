import 'package:dio/dio.dart';
import '../../models/nutrition_model.dart';

class ApiService {
  final Dio _dio = Dio();

  final String baseUrl = 'https://trackapi.nutritionix.com/v2/natural/nutrients';
  final String appId = '185592af';
  final String appKey = '767bce3fd35e532bcf017a1abced3513';

  Future<NutritionModel> getNutritionData(String query) async {
    try {
      final response = await _dio.post(
        baseUrl,
        data: {'query': query},
        options: Options(
          headers: {
            'x-app-id': appId,
            'x-app-key': appKey,
            'Content-Type': 'application/json',
          },
        ),
      );

      return NutritionModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Gagal mengambil data nutrisi: $e');
    }
  }
}