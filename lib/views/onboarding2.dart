import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart'; // for DragStartBehavior

class Onboarding2Page extends StatefulWidget {
  const Onboarding2Page({super.key});

  @override
  State<Onboarding2Page> createState() => _Onboarding2PageState();
}

class _Onboarding2PageState extends State<Onboarding2Page> {
  int selectedAge = 18;
  late FixedExtentScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = FixedExtentScrollController(initialItem: selectedAge);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final highlightBg = const Color(0xFFBEE78C); // pale green highlight

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
                controller: scrollController,
                itemExtent: 120,                // was 100 → 120
                diameterRatio: 1.5,
                perspective: 0.005,
                dragStartBehavior: DragStartBehavior.start,
                onSelectedItemChanged: (idx) {
                  setState(() => selectedAge = idx);
                },
                childDelegate: ListWheelChildBuilderDelegate(
                  childCount: 101,
                  builder: (context, idx) {
                    if (idx < 0 || idx > 100) return null;
                    final isSel = idx == selectedAge;
                    return Center(
                      child: Container(
                        width: 180,               // was 140 → 180
                        height: 140,              // was 100 → 140
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
                            fontSize: isSel ? 40 : 32,  // was 36/28 → 40/32
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
                  onPressed: () =>
                      Navigator.pushNamed(context, '/onboarding3'),
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
              onPressed: () =>
                  Navigator.pushReplacementNamed(context, '/onboarding1'),
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
  }
}
