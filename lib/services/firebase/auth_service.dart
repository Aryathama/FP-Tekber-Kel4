import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// 🔐 Login
  Future<User?> login(String email, String password) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return result.user;
    } catch (e) {
      rethrow; // biar bisa ditangani di UI
    }
  }

  /// 🔐 Register + update displayName
  Future<User?> register(String email, String password, String displayName) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      await result.user?.updateDisplayName(displayName);
      return result.user;
    } catch (e) {
      rethrow;
    }
  }

  /// 🔐 Logout
  Future<void> logout() async {
    await _auth.signOut();
  }

  /// 📡 Stream perubahan login/logout
  Stream<User?> get userChanges => _auth.authStateChanges();

  /// 👤 User saat ini
  User? get currentUser => _auth.currentUser;

  /// ✏ Update displayName (nama pengguna)
  Future<void> updateDisplayName(String name) async {
    if (_auth.currentUser != null) {
      await _auth.currentUser!.updateDisplayName(name);
      await _auth.currentUser!.reload(); // wajib untuk apply perubahan
    }
  }

  /// ✏ Update email
  Future<void> updateEmail(String email) async {
    if (_auth.currentUser != null) {
      await _auth.currentUser!.updateEmail(email);
      await _auth.currentUser!.reload();
    }
  }

  /// ✏ Update password
  Future<void> updatePassword(String newPassword) async {
    if (_auth.currentUser != null) {
      await _auth.currentUser!.updatePassword(newPassword);
    }
  }
}