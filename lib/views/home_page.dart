import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nutricore/viewmodels/nutrition_viewmodel.dart';
import 'package:provider/provider.dart';

// Pastikan path impor ini sesuai dengan struktur folder kamu
import 'widgets/macro_progress_card.dart';
import 'widgets/info_card.dart';
import 'widgets/image_picker_buttons.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // Fungsi untuk menampilkan bottom sheet pilihan gambar
  void _showImageSourceActionSheet(BuildContext context) {
    // Ambil ViewModel tanpa 'listen' karena kita hanya akan memanggil fungsi,
    // bukan untuk membangun ulang UI di sini.
    final viewModel = Provider.of<NutritionViewModel>(context, listen: false);

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: ImagePickerButtons(
          onCameraTap: () {
            Navigator.pop(context); // Tutup bottom sheet dulu
            viewModel.pickAndAnalyzeImage(source: ImageSource.camera);
          },
          onGalleryTap: () {
            Navigator.pop(context); // Tutup bottom sheet dulu
            viewModel.pickAndAnalyzeImage(source: ImageSource.gallery);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // --- Placeholder Data ---
    // Nanti, data ini akan kita ganti dengan data sungguhan dari
    // model profil pengguna yang disimpan di Firestore.
    const String userName = 'Gregorius Akbar';
    const String currentPlan = 'Maintain';
    const int currentKcal = 1721;
    const int targetKcal = 2213;
    const int currentProtein = 78;
    const int targetProtein = 90;
    const int currentFats = 45;
    const int targetFats = 70;
    const int currentCarbs = 95;
    const int targetCarbs = 110;
    const double currentWater = 2.1;
    const double targetWater = 2.8;
    const int currentSteps = 3732;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: Colors.white,
              child: Icon(Icons.person, color: Colors.green.shade800, size: 30),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Welcome',
                  style: TextStyle(fontSize: 14, color: Colors.white70),
                ),
                Text(
                  userName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, size: 28),
            onPressed: () {
              // TODO: Implement search functionality
            },
          ),
          IconButton(
            icon: const Icon(Icons.notifications, size: 28),
            onPressed: () {
              // TODO: Implement notification page navigation
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      // Kita bungkus seluruh body dengan Consumer
      body: Consumer<NutritionViewModel>(
        builder: (context, viewModel, child) {
          // --- LOGIC REAKTIF ---
          // Bagian ini akan "mendengarkan" perubahan state dari ViewModel
          // dan melakukan aksi (navigasi, menampilkan snackbar, dll).
          // `addPostFrameCallback` memastikan aksi ini berjalan setelah build selesai.
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (viewModel.state == AppState.success && viewModel.latestAnalysis != null) {
              // Jika sukses, navigasi ke halaman detail dengan membawa data hasil analisis.
              context.go('/scan', extra: viewModel.latestAnalysis);
              // Penting: Reset state agar tidak terjebak dalam loop navigasi.
              viewModel.resetState();
            } else if (viewModel.state == AppState.error) {
              // Jika error, tampilkan pesan di bagian bawah layar.
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(viewModel.errorMessage),
                  backgroundColor: Colors.red.shade600,
                  behavior: SnackBarBehavior.floating,
                ),
              );
              // Penting: Reset state agar pesan error tidak muncul terus menerus.
              viewModel.resetState();
            }
          });

          // --- UI ---
          // Gunakan Stack untuk menumpuk UI utama dengan loading indicator.
          return Stack(
            children: [
              // 'child' ini adalah UI statis HomePage kamu yang sudah ada.
              // Kita meletakkannya di sini agar tidak perlu di-rebuild setiap kali
              // state ViewModel berubah, sehingga lebih efisien.
              child!,

              // Tampilkan overlay loading di atas segalanya jika state = loading.
              if (viewModel.state == AppState.loading)
                Container(
                  color: Colors.black.withOpacity(0.6),
                  child: const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(color: Colors.white),
                        SizedBox(height: 20),
                        Text(
                          'Menganalisis Makanan Anda...',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          );
        },
        // 'child' dari Consumer. Ini adalah UI utama halamanmu.
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Current Plan: ',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  Text(
                    currentPlan,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              Center(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.local_fire_department,
                            color: Colors.red.shade600, size: 32),
                        const SizedBox(width: 8),
                        Text(
                          '$currentKcal Kcal',
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'of $targetKcal Kcal',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Stack(
                      children: [
                        Container(
                          height: 12,
                          width: MediaQuery.of(context).size.width * 0.7,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        Container(
                          height: 12,
                          width: MediaQuery.of(context).size.width *
                              0.7 *
                              (currentKcal / targetKcal).clamp(0.0, 1.0),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade600,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MacroProgressCard(
                      label: 'Protein',
                      current: currentProtein,
                      target: targetProtein,
                      color: Colors.blue),
                  MacroProgressCard(
                      label: 'Fats',
                      current: currentFats,
                      target: targetFats,
                      color: Colors.orange),
                  MacroProgressCard(
                      label: 'Carbs',
                      current: currentCarbs,
                      target: targetCarbs,
                      color: Colors.yellow.shade700),
                ],
              ),
              const SizedBox(height: 40),

              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Implement Redo Test logic
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 4,
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Redo Test',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 10),
                      Icon(Icons.arrow_forward),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),

              Row(
                children: [
                  Expanded(
                    child: InfoCard(
                      color: Colors.blue.shade300,
                      value: '$currentWater/$targetWater',
                      unit: 'litres',
                      message: 'You\'re doing good,\nKeep it up!',
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: InfoCard(
                      color: Colors.orange.shade300,
                      value: currentSteps.toString(),
                      unit: 'steps',
                      message: 'You\'re doing good,\nKeep it up!',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),

      // Bagian Bottom Nav dan FAB tidak berubah
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.home, size: 28),
              color: Colors.green,
              onPressed: () {},
            ),
            const SizedBox(width: 48), // Ruang untuk FAB
            IconButton(
              icon: const Icon(Icons.person, size: 28),
              color: Colors.grey,
              onPressed: () {
                // TODO: Navigasi ke halaman profil
              },
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        shape: const CircleBorder(),
        onPressed: () => _showImageSourceActionSheet(context),
        child: const Icon(Icons.add, size: 36),
      ),
    );
  }
}
