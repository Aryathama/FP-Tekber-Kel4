import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Impor widget pembantu dari views/widgets
import 'package:nutricore_fe/views/widgets/macro_progress_card.dart';
import 'package:nutricore_fe/views/widgets/info_card.dart';
import 'package:nutricore_fe/views/widgets/image_picker_buttons.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<void> _showImageSourceActionSheet(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: ImagePickerButtons(
          onCameraTap: () async {
            Navigator.pop(context); // Tutup bottom sheet
            context.go('/scan', extra: 'assets/images/nasi_goreng.jpeg');
          },
          onGalleryTap: () async {
            Navigator.pop(context); // Tutup bottom sheet
            context.go('/scan', extra: 'assets/images/nasi_goreng.jpeg');
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Placeholder Data untuk UI
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
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.notifications, size: 28),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
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
                      Icon(Icons.local_fire_department, color: Colors.red.shade600, size: 32),
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
                        width: MediaQuery.of(context).size.width * 0.7 * (currentKcal / targetKcal).clamp(0.0, 1.0),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade600,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      Positioned(
                        left: MediaQuery.of(context).size.width * 0.7 * (0.8),
                        child: Container(
                          width: 2,
                          height: 20,
                          color: Colors.green,
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
                MacroProgressCard(label: 'Protein', current: currentProtein, target: targetProtein, color: Colors.blue),
                MacroProgressCard(label: 'Fats', current: currentFats, target: targetFats, color: Colors.orange),
                MacroProgressCard(label: 'Carbs', current: currentCarbs, target: targetCarbs, color: Colors.yellow.shade700),
              ],
            ),
            const SizedBox(height: 40),

            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
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
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
            const SizedBox(width: 48),
            IconButton(
              icon: const Icon(Icons.person, size: 28),
              color: Colors.grey,
              onPressed: () {},
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