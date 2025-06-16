import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import '../services/firebase/firebase_options.dart';
import 'dart:async';

// Login & Onboarding screens
import 'views/login_screen.dart';
import 'views/onboarding1.dart';
import 'views/onboarding2.dart';
import 'views/onboarding3.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // ✅ Inisialisasi Firebase dengan konfigurasi platform saat ini
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Health Tracker App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.teal),

      // Tampilkan SplashScreen pertama kali
      home: const SplashScreen(),

      // Named routes untuk Login & Onboarding
      routes: {
        '/login': (_) => const LoginScreen(),
        '/onboarding1': (_) => const Onboarding1Page(),
        '/onboarding2': (_) => const Onboarding2Page(),
        '/onboarding3': (_) => const Onboarding3Page(),
      },
    );
  }
}

// SplashScreen dengan background putih & logo di tengah
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      // Setelah splash delay, pindah ke LoginScreen via named route
      Navigator.pushReplacementNamed(context, '/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image(
          image: AssetImage('assets/logo.png'),
          width: 200,
        ),
      ),
    );
  }
}
