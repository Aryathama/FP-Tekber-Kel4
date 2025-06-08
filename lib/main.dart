import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:firebase_core/firebase_core.dart';
<<<<<<< HEAD
import 'firebase_options.dart';
import 'dart:async';

// Import screen lain
=======
>>>>>>> parent of 1f8ce0c (login dan register (fix))
=======
import 'firebase_options.dart'; // ⬅️ Tambahkan ini
>>>>>>> parent of 5b6f44e (splash screen ketinggalan)
import 'screen/login_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Health Tracker App',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: LoginScreen(),
    );
  }
}
