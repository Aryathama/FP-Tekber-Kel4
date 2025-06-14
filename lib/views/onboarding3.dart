// lib/views/onboarding3.dart

import 'package:flutter/material.dart';

class Onboarding3Page extends StatefulWidget {
  const Onboarding3Page({super.key});

  @override
  State<Onboarding3Page> createState() => _Onboarding3PageState();
}

class _Onboarding3PageState extends State<Onboarding3Page>
    with SingleTickerProviderStateMixin {
  // we allow 1kg … 150kg
  static const double _minKg = 1.0;
  static const double _maxKg = 150.0;
  static const double _pixelsPerKg = 10.0;
  static const double _rulerHeight = 100.0;

  double _currentKg = 70.0;
  bool _isKg = true;

  late final AnimationController _animCtrl;
  late Animation<double> _anim;
  double _scroll = 0.0;

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _scroll = (_currentKg - _minKg) * _pixelsPerKg;
  }

  @override
  void dispose() {
    _animCtrl.dispose();
    super.dispose();
  }

  double _kgToLbs(double kg) => kg * 2.20462;

  void _onDrag(DragUpdateDetails d) {
    setState(() {
      _scroll -= d.delta.dx;
      _currentKg = _minKg + (_scroll / _pixelsPerKg);
      _currentKg = _currentKg.clamp(_minKg, _maxKg);
      _scroll = (_currentKg - _minKg) * _pixelsPerKg;
    });
  }

  void _onDragEnd(DragEndDetails _) {
    final snap = _currentKg.roundToDouble();
    _anim = Tween(begin: _currentKg, end: snap).animate(_animCtrl)
      ..addListener(() {
        setState(() {
          _currentKg = _anim.value;
          _scroll = (_currentKg - _minKg) * _pixelsPerKg;
        });
      });
    _animCtrl.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    final bg = Colors.green[600]!;
    final lightLime = const Color(0xFFD9F99D); // matches your mock

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

            // 30px ↓
            const SizedBox(height: 30),

            // unit toggles
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _unitButton("Kg", _isKg, () => setState(() => _isKg = true)),
                const SizedBox(width: 16),
                _unitButton("Lbs", !_isKg, () => setState(() => _isKg = false)),
              ],
            ),

            // 20px ↓
            const SizedBox(height: 20),

            // big value
            Text(
              _isKg
                  ? "${_currentKg.round()} kg"
                  : "${_kgToLbs(_currentKg).toStringAsFixed(1)} lbs",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
            ),

            // 20px ↓
            const SizedBox(height: 20),

            // ruler + red indicator
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  GestureDetector(
                    onHorizontalDragUpdate: _onDrag,
                    onHorizontalDragEnd: _onDragEnd,
                    child: CustomPaint(
                      size: Size(
                        MediaQuery.of(context).size.width,
                        _rulerHeight,
                      ),
                      painter: _RulerPainter(
                        minV: _minKg,
                        maxV: _maxKg,
                        pxPerUnit: _pixelsPerKg,
                        scroll: _scroll,
                      ),
                    ),
                  ),
                  // red line exactly center
                  Container(
                    width: 3,
                    height: _rulerHeight + 20,
                    color: Colors.redAccent,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Next + Back
            Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Column(
                children: [
                  SizedBox(
                    width: 350,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pushNamed(context, '/login'),
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
                    onPressed: () => Navigator.pop(context),
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
