import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart'; // <-- LANGKAH 1: TAMBAHKAN IMPORT INI

// Sesuaikan path ini dengan struktur folder Anda
import '../../models/user_profile.dart';
import '../viewmodels/gender_picker_viewmodel.dart';
import '../viewmodels/bmi_detail_viewmodel.dart';
import 'bmi_detail_screen.dart';


class GenderPickerScreen extends StatelessWidget {
  final UserProfile userProfile;

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
                  const SizedBox(height: 40),
                  const Text(
                    "What's your\ngender?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 60),
                  
                  // Memanggil _buildGenderOptionCard untuk Female
                  _buildGenderOptionCard(
                    context,
                    iconPath: 'assets/femaleavatar.svg', // Menggunakan path String
                    text: 'Female',
                    genderValue: Gender.female,
                    isSelected: viewModel.selectedGender == Gender.female,
                    onTap: () => viewModel.selectGender(Gender.female),
                  ),
                  const SizedBox(height: 20),
                  
                  // Memanggil _buildGenderOptionCard untuk Male
                  _buildGenderOptionCard(
                    context,
                    iconPath: 'assets/maleavatar.svg', // Menggunakan path String
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
                            final finalProfile = userProfile.copyWith(gender: viewModel.selectedGender);

                            print('Finish pressed! Final UserProfile: ${finalProfile}');

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
                  const SizedBox(height: 16),
                  
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
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

  // --- WIDGET INI TELAH DIREVISI ---
  Widget _buildGenderOptionCard(
    BuildContext context, {
    required String iconPath, // Parameter sekarang bernama iconPath
    required String text,
    required Gender genderValue,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipOval(
            child: SizedBox(
              width: 50,  // Diameter lingkaran (radius 25 * 2)
              height: 50, // Diameter lingkaran
              child: SvgPicture.asset(
                iconPath,
                fit: BoxFit.cover, // Perintahkan SVG untuk mengisi penuh area
              ),
            ),
          ),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
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
                  ? const Icon(Icons.circle, size: 12, color: Colors.white)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}