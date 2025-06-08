import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // Tetap butuh GoRouter
import 'package:nutricore_fe/routes/app_router.dart'; // Mengimpor AppRouter

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Food Scanner',
      theme: ThemeData(
        primarySwatch: Colors.green,
        useMaterial3: true,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routerConfig: AppRouter.router,
    );
  }
}