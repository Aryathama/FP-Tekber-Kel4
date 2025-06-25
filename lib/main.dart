// lib/main.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'services/firebase/firebase_options.dart'; // Pastikan path benar
import 'dart:async';

// ViewModels
import 'viewmodels/home_viewmodel.dart'; // Pastikan path benar
import 'viewmodels/age_picker_viewmodel.dart'; // Pastikan path ini benar

// Models
import '/models/user_profile.dart'; // Ganti 'your_app_name'

// Views
import 'views/login_screen.dart'; // Pastikan path benar
import 'views/home_page.dart'; // Pastikan path benar
import 'views/onboarding1.dart';
import 'views/onboarding2.dart';
import 'views/onboarding3.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    ChangeNotifierProvider(
      create: (context) => HomeViewModel(), // HomeViewModel disediakan di root
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nutricore Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Poppins',
      ),
      debugShowCheckedModeBanner: false,

      home: const SplashScreen(),

      routes: {
        '/login': (_) => const LoginScreen(),
        '/home': (_) => const HomePage(),
        '/onboarding1': (_) => const Onboarding1Page(),
        '/onboarding2': (_) => ChangeNotifierProvider(

          create: (context) => AgePickerViewModel(), // Gunakan nama class yang benar

          child: Onboarding2Page(userProfile: UserProfile()),

          ),
        '/onboarding3': (_) => Onboarding3Page(userProfile: UserProfile()),
      },
    );
  }
}

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
      // Setelah splash screen, navigasi ke LoginScreen
      Navigator.pushReplacementNamed(context, '/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image(
          image: AssetImage('assets/logo.png'), // Pastikan path logo benar
          width: 200,
        ),
      ),
    );
  }
}