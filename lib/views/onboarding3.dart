// lib/views/onboarding/onboarding3.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/models/user_profile.dart';
import '/viewmodels/weight_picker_viewmodel.dart';
import '/views/height_picker_screen.dart'; // Navigasi ke HeightPickerScreen
import '/viewmodels/height_picker_viewmodel.dart'; // Import ViewModel

class Onboarding3Page extends StatefulWidget {
  final UserProfile userProfile;

  const Onboarding3Page({super.key, required this.userProfile});

  @override
  State<Onboarding3Page> createState() => _Onboarding3PageState();
}

class _Onboarding3PageState extends State<Onboarding3Page>
    with SingleTickerProviderStateMixin {
  // Tambahkan deklarasi _rulerHeight di sini sebagai static const
  static const double _rulerHeight = 100.0; // Pindahkan deklarasi ini ke sini

  late final AnimationController _animCtrl;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    final viewModel = Provider.of<WeightPickerViewModel>(context, listen: false);
    if (widget.userProfile.weight != null) {
      final initialOffset = (widget.userProfile.weight! - viewModel.minKg) * viewModel.pixelsPerKg;
      viewModel.setInitialScrollOffset(initialOffset);
    }
  }

  @override
  void dispose() {
    _animCtrl.dispose();
    super.dispose();
  }

  void _onDrag(DragUpdateDetails d, WeightPickerViewModel viewModel) {
    viewModel.updateScrollAndWeight(d.delta.dx);
  }

  void _onDragEnd(DragEndDetails _, WeightPickerViewModel viewModel) {
    _anim = Tween(begin: viewModel.currentKg, end: viewModel.currentKg.roundToDouble()).animate(_animCtrl)
      ..addListener(() {
        // No setState here, ViewModel handles notifyListeners()
      });
    _animCtrl.forward(from: 0).then((_) {
      viewModel.snapWeight();
      _animCtrl.reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    final bg = Colors.green[600]!;
    final lightLime = const Color(0xFFD9F99D);

    return Consumer<WeightPickerViewModel>(
      builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor: bg,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            toolbarHeight: 0,
          ),
          body: SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 40),
                const Text(
                  "What's your current\nweight right now?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 30),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _unitButton("Kg", viewModel.isKgSelected, () => viewModel.toggleUnit(true)),
                    const SizedBox(width: 16),
                    _unitButton("Lbs", !viewModel.isKgSelected, () => viewModel.toggleUnit(false)),
                  ],
                ),

                const SizedBox(height: 20),

                Text(
                  viewModel.getFormattedWeight(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      GestureDetector(
                        onHorizontalDragUpdate: (d) => _onDrag(d, viewModel),
                        onHorizontalDragEnd: (d) => _onDragEnd(d, viewModel),
                        child: CustomPaint(
                          size: Size(
                            MediaQuery.of(context).size.width,
                            _rulerHeight, // Menggunakan _rulerHeight yang sudah dideklarasikan
                          ),
                          painter: _RulerPainter(
                            minV: viewModel.minKg,
                            maxV: viewModel.maxKg,
                            pxPerUnit: viewModel.pixelsPerKg,
                            scroll: viewModel.scrollOffset,
                          ),
                        ),
                      ),
                      Container(
                        width: 3,
                        height: _rulerHeight + 20, // Menggunakan _rulerHeight
                        color: Colors.redAccent,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Column(
                    children: [
                      SizedBox(
                        width: 350,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            final updatedProfile = widget.userProfile.copyWith(weight: viewModel.currentKg.round());
                            print('Weight selected: ${updatedProfile.weight} kg');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChangeNotifierProvider(
                                  // Perbaikan syntax di sini:
                                  create: (context) => HeightPickerViewModel(
                                    initialHeightCm: updatedProfile.height?.toDouble() ?? 172.0,
                                  ),
                                  child: HeightPickerScreen(userProfile: updatedProfile),
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: lightLime,
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Next →',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextButton(
                        onPressed: () {
                          print('Back pressed from Onboarding3Page (Weight)');
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Back',
                          style: TextStyle(color: Colors.white70, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _unitButton(String label, bool selected, VoidCallback onTap) {
    final lightLime = const Color(0xFFD9F99D);
    return SizedBox(
      width: 100,
      height: 50,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: selected ? lightLime : Colors.white,
          foregroundColor: selected ? Colors.black : Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: selected
                ? BorderSide.none
                : BorderSide(color: Colors.white54, width: 1),
          ),
          elevation: 0,
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 18,
            fontWeight: selected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

class _RulerPainter extends CustomPainter {
  final double minV, maxV, pxPerUnit, scroll;
  _RulerPainter({
    required this.minV,
    required this.maxV,
    required this.pxPerUnit,
    required this.scroll,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
    final tp = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    final cx = size.width / 2;

    for (double v = minV; v <= maxV; v++) {
      final x = cx - scroll + (v - minV) * pxPerUnit;
      if (x < -20 || x > size.width + 20) continue;

      double len;
      if (v % 10 == 0) {
        len = 40;
        tp.text = TextSpan(
          text: v.round().toString(),
          style: const TextStyle(color: Colors.white, fontSize: 16),
        );
        tp.layout();
        tp.paint(
          canvas,
          Offset(x - tp.width / 2, size.height / 2 + len / 2 + 5),
        );
      } else if (v % 5 == 0) {
        len = 30;
      } else {
        len = 20;
      }

      canvas.drawLine(
        Offset(x, size.height / 2 - len / 2),
        Offset(x, size.height / 2 + len / 2),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _RulerPainter o) =>
      o.scroll != scroll || o.minV != minV || o.maxV != maxV;
}