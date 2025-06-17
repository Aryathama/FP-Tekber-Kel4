import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:provider/provider.dart';
import '/models/user_profile.dart';
import '/viewmodels/age_picker_viewmodel.dart';
import '/views/onboarding3.dart';
import '/viewmodels/weight_picker_viewmodel.dart';

class Onboarding2Page extends StatelessWidget {
  final UserProfile userProfile; // Terima UserProfile dari layar sebelumnya

  const Onboarding2Page({super.key, required this.userProfile});

  @override
  Widget build(BuildContext context) {
    final highlightBg = const Color(0xFFBEE78C); // pale green highlight

    return Consumer<AgePickerViewModel>(
      builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 40),
                const Text(
                  "What’s your Age?",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                const Spacer(),

                // BIGGER wheel picker
                SizedBox(
                  height: 480,
                  child: ListWheelScrollView.useDelegate(
                    controller: viewModel.scrollController, // Gunakan controller dari ViewModel
                    itemExtent: 120,
                    diameterRatio: 1.5,
                    perspective: 0.005,
                    dragStartBehavior: DragStartBehavior.start,
                    onSelectedItemChanged: (idx) {
                      viewModel.updateSelectedAge(idx); // Update ViewModel
                    },
                    childDelegate: ListWheelChildBuilderDelegate(
                      childCount: 101, // Ages 0 to 100
                      builder: (context, idx) {
                        if (idx < 0 || idx > 100) return null;
                        final isSel = idx == viewModel.selectedAge; // Ambil dari ViewModel
                        return Center(
                          child: Container(
                            width: 180,
                            height: 140,
                            decoration: isSel
                                ? BoxDecoration(
                                    color: highlightBg,
                                    borderRadius: BorderRadius.circular(12),
                                  )
                                : null,
                            alignment: Alignment.center,
                            child: Text(
                              '$idx',
                              style: TextStyle(
                                fontSize: isSel ? 40 : 32,
                                fontWeight:
                                    isSel ? FontWeight.bold : FontWeight.normal,
                                color: isSel ? Colors.white : Colors.grey,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                const Spacer(),

                // Next button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        // Update UserProfile dengan age
                        final updatedProfile = userProfile.copyWith(age: viewModel.selectedAge);
                        print('Age selected: ${updatedProfile.age}');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChangeNotifierProvider(
                              // BARIS INI: Pastikan syntax ini sudah benar
                              create: (context) => WeightPickerViewModel(), // <-- Ini adalah baris 97
                              child: Onboarding3Page(userProfile: updatedProfile), // Teruskan UserProfile
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[600],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Next →',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                // Back link
                TextButton(
                  onPressed: () {
                    print('Back pressed from Onboarding2Page (Age)');
                    // Sesuaikan ini jika ada onboarding1 sebelumnya atau langsung pop
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Back',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        );
      },
    );
  }
}