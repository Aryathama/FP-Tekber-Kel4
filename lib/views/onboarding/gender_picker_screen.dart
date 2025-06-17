import 'package:flutter/material.dart';
import '/models/user_profile.dart'; // Sesuaikan path
import '/viewmodels/onboarding/gender_picker_viewmodel.dart'; // Sesuaikan path
import '/viewmodels/onboarding/bmi_detail_viewmodel.dart'; // Untuk navigasi
import '/views/onboarding/bmi_detail_screen.dart'; // Untuk navigasi
import 'package:provider/provider.dart';

class GenderPickerScreen extends StatelessWidget {
  final UserProfile userProfile; // Menerima UserProfile dari layar sebelumnya

  const GenderPickerScreen({super.key, required this.userProfile});

  @override
  Widget build(BuildContext context) {
    return Consumer<GenderPickerViewModel>(
      builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            toolbarHeight: 0,
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 40),
                  Text(
                    "What's your\ngender?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 60),

                  // ... (kode _buildGenderOptionCard tetap sama) ...
                  _buildGenderOptionCard(
                    context,
                    icon: 'assets/female_avatar.png',
                    text: 'Female',
                    genderValue: Gender.female,
                    isSelected: viewModel.selectedGender == Gender.female,
                    onTap: () => viewModel.selectGender(Gender.female),
                  ),
                  SizedBox(height: 20),

                  _buildGenderOptionCard(
                    context,
                    icon: 'assets/male_avatar.png',
                    text: 'Male',
                    genderValue: Gender.male,
                    isSelected: viewModel.selectedGender == Gender.male,
                    onTap: () => viewModel.selectGender(Gender.male),
                  ),
                  // ... (end _buildGenderOptionCard) ...

                  Spacer(),

                  ElevatedButton(
                    onPressed: viewModel.canProceed
                        ? () {
                            // Update userProfile dengan gender yang dipilih
                            final updatedProfile = userProfile.copyWith(gender: viewModel.selectedGender);

                            // Tambahkan data dummy age dan weight jika belum ada dari layar sebelumnya
                            // Di aplikasi nyata, ini akan datang dari layar input Age dan Weight
                            final finalProfile = updatedProfile.copyWith(
                              age: 19,    // Ganti dengan input asli dari layar Age
                              weight: 62, // Ganti dengan input asli dari layar Weight
                            );

                            print('Finish pressed! Final UserProfile: $finalProfile');

                            // Gunakan pushReplacement agar pengguna tidak bisa kembali ke onboarding
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChangeNotifierProvider(
                                  create: (_) => BMIDetailViewModel(finalProfile),
                                  child: BMIDetailScreen(),
                                ),
                              ),
                            );
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[600],
                      foregroundColor: Colors.white,
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Finish →',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 16),

                  TextButton(
                    onPressed: () {
                      print('Back pressed from GenderPickerScreen!');
                      Navigator.pop(context); // Kembali ke HeightPickerScreen
                    },
                    child: Text(
                      'Back',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildGenderOptionCard(
    BuildContext context, {
    required String icon,
    required String text,
    required Gender genderValue,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isSelected ? Colors.redAccent : Colors.grey[300]!,
            width: isSelected ? 2.0 : 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: Colors.grey[200],
              backgroundImage: AssetImage(icon),
            ),
            SizedBox(width: 20),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? Colors.redAccent : Colors.grey[400]!,
                  width: 2,
                ),
                color: isSelected ? Colors.redAccent : Colors.transparent,
              ),
              child: isSelected
                  ? Icon(Icons.circle, size: 12, color: Colors.white)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}