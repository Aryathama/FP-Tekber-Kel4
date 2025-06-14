// lib/main.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'views/home_page.dart';
import 'viewmodels/home_viewmodel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // ChangeNotifierProvider akan membuat instance HomeViewModel
    // dan menyediakannya untuk semua widget di bawahnya (dalam hal ini, seluruh aplikasi).
    return ChangeNotifierProvider(
      create: (context) => HomeViewModel(),
      child: MaterialApp(
        title: 'Nutricore Demo',
        theme: ThemeData(
          primarySwatch: Colors.green,
          fontFamily: 'Poppins',
        ),
        debugShowCheckedModeBanner: false,
        home: const HomePage(), // Atur HomePage sebagai halaman utama
      ),
    );
  }
}