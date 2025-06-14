import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import '../services/firebase/firebase_options.dart';
import 'dart:async';

import 'views/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();


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
      home: const SplashScreen(),
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
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
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
