import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';
// import 'dart:async';
// // Import screen lain
// import 'firebase_options.dart'; // ⬅️ Tambahkan ini
import 'screen/login_screen.dart';
import 'views/onboarding1.dart';
import 'views/onboarding2.dart';
import 'views/onboarding3.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Health Tracker App',
      theme: ThemeData(primarySwatch: Colors.teal),
      initialRoute: '/login',
      routes: {
        '/login': (_) => const LoginScreen(),
        '/onboarding1': (_) => const Onboarding1Page(),
        '/onboarding2': (_) => const Onboarding2Page(),
        '/onboarding3': (_) => const Onboarding3Page(),
      },
    );
  }
}
