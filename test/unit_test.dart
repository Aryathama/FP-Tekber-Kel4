import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:nutricore/models/nutrition_data.dart';
import 'package:nutricore/services/api/nutritionix_service.dart';

// Anotasi untuk membuat file mock dari http.Client
@GenerateMocks([http.Client])
import 'unit_test.mocks.dart'; // Jangan lupa jalankan `flutter pub run build_runner build`

void main() {
  group('NutritionixService', () {
    late MockClient mockClient;
    late NutritionixService nutritionixService;

    // setUp dijalankan sebelum setiap test
    setUp(() {
      mockClient = MockClient();
      // Suntikkan MockClient ke dalam service saat inisialisasi
      // Memastikan pemanggilan constructor menggunakan named parameter 'client'
      nutritionixService = NutritionixService(client: mockClient);
    });

    // Test Case 1: Panggilan API berhasil (Success Case)
    test('getNutritionData mengembalikan NutritionData jika panggilan API berhasil (200)', () async {
      // ARRANGE (Persiapan)
      final mockJsonResponse = jsonEncode({
        "foods": [
          {
            "food_name": "nasi goreng",
            "nf_calories": 350.5,
            "nf_protein": 12.2,
            "nf_total_carbohydrate": 45.8,
            "nf_total_fat": 15.1,
          }
        ]
      });

      // Atur agar saat mockClient.post dipanggil, ia mengembalikan respons sukses
      when(mockClient.post(
        any,
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response(mockJsonResponse, 200));

      // ACT (Aksi)
      // Panggil method yang ingin kita tes
      final result = await nutritionixService.getNutritionData('nasi goreng');

      // ASSERT (Pengecekan)
      // Pastikan hasilnya adalah objek NutritionData
      expect(result, isA<NutritionData>());
      // Pastikan datanya sesuai dengan JSON yang kita berikan
      expect(result.foodName, 'nasi goreng');
      expect(result.calories, 350.5);
    });

    // Test Case 2: Panggilan API gagal (Error Case)
    test('getNutritionData melempar Exception jika panggilan API gagal (misal: 404)', () async {
      // ARRANGE
      // Atur agar mockClient mengembalikan respons error
      when(mockClient.post(
        any,
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response('Not Found', 404));

      // ACT & ASSERT
      // Pastikan pemanggilan method akan melempar (throw) sebuah Exception
      expect(nutritionixService.getNutritionData('makanan aneh'), throwsException);
    });

    // Test Case 3: Respon API tidak berisi makanan
    test('getNutritionData melempar Exception jika API tidak menemukan makanan', () async {
      // ARRANGE
      // Respon sukses (200) tapi dengan array foods yang kosong
      final mockJsonResponse = jsonEncode({"foods": []});
      when(mockClient.post(
        any,
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response(mockJsonResponse, 200));

      // ACT & ASSERT
      expect(nutritionixService.getNutritionData('asdfghjkl'), throwsException);
    });
  });
}
