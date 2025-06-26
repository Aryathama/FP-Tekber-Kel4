import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nutricore/models/nutrition_data.dart';
import 'package:nutricore/models/user_model.dart';

/// Service ini adalah satu-satunya titik akses ke database Cloud Firestore.
/// Ia menangani semua operasi baca dan tulis untuk data pengguna dan riwayat makanan.
class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final User? _user;

  // Constructor menerima user yang sedang login dari AuthService.
  // Ini memastikan semua operasi terikat pada pengguna yang benar.
  FirestoreService(this._user);

  // --- FUNGSI BARU UNTUK PROFIL PENGGUNA ---

  /// Menyimpan atau memperbarui data profil pengguna di koleksi 'users'.
  /// Method ini menggunakan .set() dengan merge:true agar tidak menghapus
  /// field lain jika hanya sebagian data yang di-update.
  Future<void> saveUserProfile(UserModel userProfile) async {
    if (_user == null) throw Exception("User not logged in. Cannot save profile.");
    // ID dokumen sama dengan ID user dari Firebase Auth
    await _db.collection('users').doc(_user!.uid).set(userProfile.toFirestore(), SetOptions(merge: true));
  }

  /// Mengambil data profil lengkap untuk pengguna yang sedang login.
  /// Mengembalikan objek UserModel jika ada, atau null jika tidak ditemukan.
  Future<UserModel?> getUserProfile() async {
    if (_user == null) return null;
    final doc = await _db.collection('users').doc(_user!.uid).get();
    if (!doc.exists) return null;
    return UserModel.fromFirestore(doc);
  }

  /// Memeriksa dengan cepat apakah profil untuk user tertentu sudah ada.
  /// Ini penting untuk AuthWrapper agar bisa menentukan harus ke HomePage atau ke kuis.
  Future<bool> doesUserProfileExist() async {
    if (_user == null) return false;
    final doc = await _db.collection('users').doc(_user!.uid).get();
    return doc.exists;
  }


  // --- FUNGSI UNTUK RIWAYAT MAKANAN (CRUD) ---

  /// Menyimpan satu data entri nutrisi ke dalam sub-koleksi 'history'.
  Future<void> saveNutritionHistory(NutritionData data) async {
    if (_user == null) throw Exception("User not logged in. Cannot save history.");
    await _db
        .collection('users')
        .doc(_user!.uid)
        .collection('history')
        .add(data.toFirestore());
  }

  /// Mengambil semua riwayat nutrisi sebagai stream agar UI bisa update secara real-time.
  Stream<List<NutritionData>> getNutritionHistory() {
    if (_user == null) return Stream.value([]); // Return stream kosong jika tidak login
    return _db
        .collection('users')
        .doc(_user!.uid)
        .collection('history')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => NutritionData.fromFirestore(doc))
        .toList());
  }

  /// Menghapus satu entri riwayat berdasarkan ID dokumennya.
  Future<void> deleteHistoryEntry(String entryId) async {
    if (_user == null) throw Exception("User not logged in. Cannot delete history.");
    await _db
        .collection('users')
        .doc(_user!.uid)
        .collection('history')
        .doc(entryId)
        .delete();
  }
}
