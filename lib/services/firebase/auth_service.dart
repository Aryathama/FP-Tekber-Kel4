import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Login
  Future<User?> login(String email, String password) async {
    final result = await _auth.signInWithEmailAndPassword(email: email, password: password);
    return result.user;
  }

  // Register
  Future<User?> register(String email, String password, String displayName) async {
    final result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    await result.user?.updateDisplayName(displayName);
    return result.user;
  }

  // Logout
  Future<void> logout() async {
    await _auth.signOut();
  }

  // Stream user perubahan login/logout
  Stream<User?> get userChanges => _auth.authStateChanges();

  // User saat ini
  User? get currentUser => _auth.currentUser;
}