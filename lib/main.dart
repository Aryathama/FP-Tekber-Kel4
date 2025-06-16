// lib/main.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';                 
import 'package:firebase_core/firebase_core.dart';        
import 'services/firebase/firebase_options.dart';
import 'dart:async';                                      

// ViewModels
import 'viewmodels/home_viewmodel.dart';              

// Views
import 'views/login_screen.dart';                       
import 'views/onboarding1.dart';                        
import 'views/onboarding2.dart';                        
import 'views/onboarding3.dart';                        
import 'views/home_page.dart';                          

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(
    ChangeNotifierProvider(
      create: (context) => HomeViewModel(),
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
        '/onboarding1': (_) => const Onboarding1Page(),
        '/onboarding2': (_) => const Onboarding2Page(),
        '/onboarding3': (_) => const Onboarding3Page(),
        '/home': (_) => const HomePage(),
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