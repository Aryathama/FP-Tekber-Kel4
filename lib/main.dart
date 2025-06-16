import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'dart:async';
// Import screen lain

import 'firebase_options.dart'; // ⬅️ Tambahkan ini
import 'screen/login_screen.dart';

// Import Views
import 'views/onboarding/height_picker_screen.dart';
// Import ViewModels
import 'viewmodels/onboarding/height_picker_viewmodel.dart';
// Import Models (untuk inisialisasi awal UserProfile)
import 'models/user_profile.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Health Tracker App',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // Provider akan disediakan di sini atau di root widget masing-masing
      home: MultiProvider(
        providers: [
          // Untuk layar pertama (HeightPickerScreen), kita sediakan ViewModel-nya
          // dan sebuah UserProfile kosong sebagai awal
          ChangeNotifierProvider(
            create: (_) => HeightPickerViewModel(),
          ),
          // Anda mungkin ingin menyediakan UserProfile di level yang lebih tinggi
          // jika ini adalah data yang akan mengalir di seluruh onboarding.
          // Untuk demo ini, UserProfile diteruskan antar layar.
        ],
        child: HeightPickerScreen(userProfile: UserProfile()), // Mulai dengan UserProfile kosong
      ),
    );
  }
}