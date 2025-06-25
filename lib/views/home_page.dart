// lib/views/home_page.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/home_viewmodel.dart';
import '../viewmodels/notification_viewmodel.dart';
import '../models/user_model.dart';
import '../models/nutrition_summary_model.dart';

// Widget kustom
import 'widgets/add_water_dialog.dart';
import 'widgets/info_card.dart';
import 'widgets/macro_nutrient_item.dart';

import 'notification_page.dart';
import 'profile_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          floatingActionButton: _buildFloatingActionButton(),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: _buildBottomAppBar(context, viewModel),
          body: viewModel.isLoading
              ? const Center(child: CircularProgressIndicator())
              : _buildBody(context, viewModel),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, HomeViewModel viewModel) {
    final user = viewModel.user;
    final summary = viewModel.nutritionSummary;

    if (user == null || summary == null) {
      return const Center(child: Text('Data not available.'));
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          _buildHeader(context, viewModel, user),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCurrentPlan(summary),
                const SizedBox(height: 20),
                _buildCalorieTracker(summary),
                const SizedBox(height: 25),
                _buildMacroNutrients(summary),
                const SizedBox(height: 30),
                _buildRedoTestButton(context),
                const SizedBox(height: 20),
                _buildInfoCards(context, viewModel, summary),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return Transform.translate(
      offset: const Offset(0, 12),
      child: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFFD1E17D),
        foregroundColor: Colors.white,
        elevation: 4.0,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, size: 32),
      ),
    );
  }

  BottomAppBar _buildBottomAppBar(BuildContext context, HomeViewModel viewModel) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 8.0,
      color: Colors.white,
      elevation: 10.0,
      child: Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Colors.black, width: 0.7)),
        ),
        child: SizedBox(
          height: 60.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _buildBottomNavItem(context, viewModel, Icons.home, 0),
              const SizedBox(width: 40),
              _buildBottomNavItem(context, viewModel, Icons.person, 1),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavItem(
      BuildContext context, HomeViewModel viewModel, IconData icon, int index) {
    final isSelected = viewModel.selectedIndex == index;

    return Expanded(
      child: InkWell(
        onTap: () {
          viewModel.onBottomNavTapped(index);
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfileScreen()),
            ).then((_) => viewModel.loadData()); // ⬅ Refresh setelah kembali
          }
        },
        borderRadius: BorderRadius.circular(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? const Color(0xFF4CAF50) : Colors.grey,
              size: 28,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, HomeViewModel viewModel, User user) {
    return Container(
      padding: const EdgeInsets.only(top: 50, bottom: 20, left: 20, right: 20),
      decoration: const BoxDecoration(
        color: Color(0xFF65B072),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundImage: NetworkImage(user.imageUrl),
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Welcome',
                  style: TextStyle(color: Colors.white, fontSize: 14)),
              Text(user.name,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
            ],
          ),
          const Spacer(),
          CircleAvatar(
            backgroundColor: Colors.white.withOpacity(0.25),
            child: IconButton(
              icon: Stack(
                clipBehavior: Clip.none,
                children: [
                  const Icon(Icons.notifications, color: Colors.white),
                  if (viewModel.hasNewNotification)
                    Positioned(
                      top: -2,
                      right: -4,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: const Color(0xFF4CAF50), width: 2),
                        ),
                        constraints: const BoxConstraints(
                            minWidth: 12, minHeight: 12),
                      ),
                    ),
                ],
              ),
              onPressed: () {
                viewModel.markNotificationAsRead();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChangeNotifierProvider(
                      create: (context) => NotificationViewModel(),
                      child: const NotificationPage(),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentPlan(NutritionSummary summary) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Current Plan: ',
            style: TextStyle(fontSize: 18, color: Colors.black87)),
        Text(
          summary.currentPlan,
          style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF4CAF50)),
        ),
      ],
    );
  }

  Widget _buildCalorieTracker(NutritionSummary summary) {
    double progress = summary.caloriesGoal > 0
        ? summary.caloriesConsumed / summary.caloriesGoal
        : 0;

    return Column(
      children: [
        const Text('🔥', style: TextStyle(fontSize: 28)),
        const SizedBox(height: 8),
        RichText(
          text: TextSpan(
            text: summary.caloriesConsumed.toStringAsFixed(0),
            style: const TextStyle(
                fontSize: 42, fontWeight: FontWeight.bold, color: Colors.black),
            children: const [
              TextSpan(
                text: ' Kcal',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'of ${summary.caloriesGoal.toStringAsFixed(0)} kcal',
          style: const TextStyle(color: Colors.grey, fontSize: 16),
        ),
        const SizedBox(height: 20),
        LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              clipBehavior: Clip.none,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 20,
                    backgroundColor: const Color(0xFF628FD9),
                    valueColor: const AlwaysStoppedAnimation<Color>(
                        Color(0xFF32619D)),
                  ),
                ),
                Positioned(
                  left: (constraints.maxWidth * progress)
                          .clamp(0, constraints.maxWidth) -
                      12,
                  top: -10,
                  child: const Icon(Icons.arrow_drop_down,
                      color: Color(0xFF4CAF50), size: 24),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildMacroNutrients(NutritionSummary summary) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MacroNutrientItem(
          name: 'Protein',
          value:
              '${summary.proteinConsumed.toInt()}g / ${summary.proteinGoal.toInt()}g',
          color: Colors.blue,
        ),
        MacroNutrientItem(
          name: 'Fats',
          value:
              '${summary.fatsConsumed.toInt()}g / ${summary.fatsGoal.toInt()}g',
          color: Colors.orange,
        ),
        MacroNutrientItem(
          name: 'Carbs',
          value:
              '${summary.carbsConsumed.toInt()}g / ${summary.carbsGoal.toInt()}g',
          color: Colors.yellow,
        ),
      ],
    );
  }

  Widget _buildRedoTestButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => Navigator.pushNamed(context, '/onboarding2'),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFCB5E59),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Redo Test', style: TextStyle(fontSize: 16, color: Colors.white)),
            SizedBox(width: 8),
            Icon(Icons.arrow_forward, color: Colors.white, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCards(
      BuildContext context, HomeViewModel viewModel, NutritionSummary summary) {
    return Row(
      children: [
        Expanded(
          child: InfoCard(
            value:
                '${summary.waterConsumedLiters.toStringAsFixed(1)}/${summary.waterGoalLiters.toStringAsFixed(1)}',
            unit: 'litres',
            message: "You're doing good,\nKeep it up!",
            primaryColor: const Color(0xFFA2C9FA),
            secondaryColor: const Color(0xFF628FD9),
            onTap: () => _showAddWaterDialog(context, viewModel),
            child: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: LinearProgressIndicator(
                value: (summary.waterGoalLiters > 0)
                    ? (summary.waterConsumedLiters / summary.waterGoalLiters)
                        .clamp(0.0, 1.0)
                    : 0.0,
                minHeight: 8,
                backgroundColor: const Color(0xFFA2C9FA),
                valueColor:
                    const AlwaysStoppedAnimation<Color>(Color(0xFF628FD9)),
              ),
            ),
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: InfoCard(
            value: summary.stepsTaken.toString(),
            unit: 'steps',
            message: "You're doing good,\nKeep it up!",
            primaryColor: const Color(0xFFF6C86F),
            secondaryColor: const Color(0xFFF2AA3B),
          ),
        ),
      ],
    );
  }

  void _showAddWaterDialog(BuildContext context, HomeViewModel viewModel) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.3),
      builder: (BuildContext context) {
        return AddWaterDialog(
          onAdd: (amount) => viewModel.addWater(amount),
        );
      },
    );
  }
}