import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Onboarding1Page extends StatelessWidget {
  const Onboarding1Page({super.key});

  @override
  Widget build(BuildContext context) {
    // warna hijau yang dipakai untuk highlight & tombol
    final highlight = Colors.green[600]!;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 40),

            // Logo
            SvgPicture.asset(
              'assets/logowithtext.svg',
              width: 100,
              height: 32,
            ),

            const Spacer(), // pushes illustration downward

            // Ilustrasi bowl + buah
            SvgPicture.asset(
              'assets/1072730OMUNMK1.svg',
              width: 350,
              height: 350,
              fit: BoxFit.contain,
            ),

            // !-- tighten the gap here --!
            const SizedBox(height: 24),

            // Judul 2 baris dengan highlight
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(text: 'Track Your '),
                        TextSpan(
                          text: 'Nutrition,',
                          style: TextStyle(color: highlight),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(text: 'Transform Your '),
                        TextSpan(
                          text: 'Health',
                          style: TextStyle(color: highlight),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // Subjudul
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                'Stay healthy by tracking every meal.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ),

            const Spacer(), // pushes button to bottom

            // Tombol Next
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/onboarding2'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: highlight,
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

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
