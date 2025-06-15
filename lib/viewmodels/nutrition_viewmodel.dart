// viewmodels/nutrition_viewmodel.dart
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nutricore/models/nutrition_data.dart';
import 'package:nutricore/services/api/gemini_service.dart';
import 'package:nutricore/services/api/nutritionix_service.dart'; // Import service baru
import 'package:nutricore/services/local/firestore_service.dart';
import 'package:nutricore/services/local/image_picker_service.dart';

enum AppState { idle, loading, success, error }

class NutritionViewModel with ChangeNotifier {
  // --- SERVICES ---
  final ImagePickerService _imagePickerService;
  final GeminiService _geminiService;
  final NutritionixService _nutritionixService; // Tambahkan NutritionixService
  final FirestoreService _firestoreService;

  // --- STATES ---
  AppState _state = AppState.idle;
  String _errorMessage = '';
  NutritionData? _latestAnalysis;
  XFile? _pickedImage; // State untuk menyimpan gambar yang dipilih

  // --- CONSTRUCTOR ---
  // Diperbarui untuk menerima semua service yang dibutuhkan
  NutritionViewModel({
    required ImagePickerService imagePickerService,
    required GeminiService geminiService,
    required NutritionixService nutritionixService, // Tambahkan dependency baru
    required FirestoreService firestoreService,
  })  : _imagePickerService = imagePickerService,
        _geminiService = geminiService,
        _nutritionixService = nutritionixService, // Inisialisasi service baru
        _firestoreService = firestoreService;

  // --- GETTERS ---
  // Ini adalah cara UI mengakses state secara aman (read-only)
  AppState get state => _state;
  String get errorMessage => _errorMessage;
  NutritionData? get latestAnalysis => _latestAnalysis;
  XFile? get pickedImage => _pickedImage; // Getter untuk gambar

  // --- Aksi Utama ---
  // Fungsi ini sekarang mengatur alur kerja 2-API
  Future<void> pickAndAnalyzeImage({required ImageSource source}) async {
    _setState(AppState.loading);
    _latestAnalysis = null;
    _pickedImage = null; // Reset gambar sebelumnya setiap kali fungsi dipanggil

    try {
      // Langkah 1: Ambil gambar menggunakan service
      final imageFile = await _imagePickerService.pickImage(source: source);
      if (imageFile == null) {
        _setState(AppState.idle); // User membatalkan, kembali ke state awal
        return;
      }
      _pickedImage = imageFile; // Simpan file gambar di state

      // Langkah 2: Identifikasi nama makanan menggunakan Gemini
      final foodName = await _geminiService.identifyFoodInImage(imageFile);

      // Langkah 3: Dapatkan data nutrisi detail dari Nutritionix
      final nutritionData = await _nutritionixService.getNutritionData(foodName);

      // Langkah 4: Simpan hasil yang sudah valid ke Firestore
      await _firestoreService.saveNutritionHistory(nutritionData);

      // Langkah 5: Update state dengan hasil yang sukses
      _latestAnalysis = nutritionData;
      _setState(AppState.success);

    } catch (e) {
      _errorMessage = "Gagal memproses gambar. Silakan coba lagi. ($e)";
      _setState(AppState.error);
    }
  }

  // Fungsi utilitas untuk mereset state
  void resetState() {
    _setState(AppState.idle);
  }

  // Helper pribadi untuk mengubah state dan memberi tahu UI
  void _setState(AppState newState) {
    _state = newState;
    notifyListeners();
  }
}
