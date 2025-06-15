import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Impor semua service dan viewmodel yang dibutuhkan
import 'package:nutricore/services/api/gemini_service.dart';
import 'package:nutricore/services/api/nutritionix_service.dart';
import 'package:nutricore/services/local/auth_service.dart';
import 'package:nutricore/services/local/firestore_service.dart';
import 'package:nutricore/services/local/image_picker_service.dart';
import 'package:nutricore/viewmodels/nutrition_viewmodel.dart';

// Impor router
import 'package:nutricore/routes/app_router.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MultiProvider sekarang berada di sini
    return MultiProvider(
      providers: [
        // --- SERVICES ---
        Provider<AuthService>(create: (_) => AuthService()),
        Provider<GeminiService>(create: (_) => GeminiService()),
        Provider<ImagePickerService>(create: (_) => ImagePickerService()),
        Provider<NutritionixService>(create: (_) => NutritionixService()),

        ProxyProvider<AuthService, FirestoreService>(
          update: (context, authService, previous) =>
              FirestoreService(authService.currentUser),
        ),

        // --- VIEWMODELS ---
        ChangeNotifierProxyProvider<FirestoreService, NutritionViewModel>(
          create: (context) => NutritionViewModel(
            imagePickerService: context.read<ImagePickerService>(),
            geminiService: context.read<GeminiService>(),
            nutritionixService: context.read<NutritionixService>(),
            firestoreService: context.read<FirestoreService>(),
          ),
          update: (context, firestoreService, previousViewModel) =>
              NutritionViewModel(
                imagePickerService: context.read<ImagePickerService>(),
                geminiService: context.read<GeminiService>(),
                nutritionixService: context.read<NutritionixService>(),
                firestoreService: firestoreService,
              ),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: AppRouter.router,
        title: 'Nutricore',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.green,
          scaffoldBackgroundColor: Colors.grey.shade50,
          fontFamily: 'Poppins',
        ),
      ),
    );
  }
}
