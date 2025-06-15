import 'package:go_router/go_router.dart';
import 'package:nutricore/models/nutrition_data.dart';
import 'package:nutricore/views/food_nutrition_page.dart';
import 'package:nutricore/views/home_page.dart';
// import 'package:nutricore_fe/views/login_page.dart'; // Jika ada

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomePage(),
      ),
      // Rute untuk menampilkan hasil analisis
      GoRoute(
        path: '/scan',
        builder: (context, state) {
          // Mengambil data yang dikirim dari halaman sebelumnya
          final nutritionData = state.extra as NutritionData?;

          // Jika data tidak ada, kembali ke home untuk menghindari error
          if (nutritionData == null) {
            return const HomePage();
          }

          // Kirim data ke FoodNutritionPage
          return FoodNutritionPage(
            nutritionData: nutritionData,
          );
        },
      ),
      // Tambahkan rute lain di sini (login, register, dll)
      /*
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
      */
    ],
  );
}
