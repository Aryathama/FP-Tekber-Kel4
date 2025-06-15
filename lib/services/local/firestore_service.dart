// services/local/firestore_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nutricore/models/nutrition_data.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Ganti 'user_id_placeholder' dengan ID user yang sedang login nantinya
  // Untuk sekarang, kita hardcode dulu
  final String _userId = "user_id_placeholder";

  FirestoreService(currentUser);

  // Menyimpan satu data nutrisi ke riwayat
  Future<void> saveNutritionHistory(NutritionData data) async {
    try {
      await _db
          .collection('users')
          .doc(_userId)
          .collection('history')
          .add(data.toFirestore());
    } catch (e) {
      print("Error saving to Firestore: $e");
      throw Exception("Could not save history.");
    }
  }

  // Mengambil semua riwayat nutrisi
  Stream<List<NutritionData>> getNutritionHistory() {
    return _db
        .collection('users')
        .doc(_userId)
        .collection('history')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => NutritionData.fromFirestore(doc))
            .toList());
  }
}
