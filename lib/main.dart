import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nutricore/app.dart'; // Mengimpor MyApp dari app.dart
import 'services/local/firebase_options.dart';

void main() async {
  // Memastikan semua setup internal Flutter siap
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Menjalankan root widget aplikasi dari app.dart
  runApp(const MyApp());
}
