import 'package:flutter/material.dart';
import '../viewmodels/height_picker_viewmodel.dart'; // Sesuaikan path
import '../viewmodels/gender_picker_viewmodel.dart'; // Sesuaikan path
import 'package:provider/provider.dart';
import '/models/user_profile.dart'; // Untuk meneruskan data
import '/views/gender_picker_screen.dart'; // Untuk navigasi

class HeightPickerScreen extends StatefulWidget {
  final UserProfile userProfile; // Menerima UserProfile dari layar sebelumnya

  HeightPickerScreen({required this.userProfile});

  @override
  _HeightPickerScreenState createState() => _HeightPickerScreenState();
}

class _HeightPickerScreenState extends State<HeightPickerScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    final viewModel = Provider.of<HeightPickerViewModel>(context, listen: false);
    // Jika UserProfile.height sudah ada (misal dari edit profil), set nilai awal
    if (widget.userProfile.height != null) {
      // Hitung scrollOffset berdasarkan tinggi yang ada di userProfile
      // Ini sedikit tricky karena kita perlu offset relatif terhadap titik awal
      final initialOffset = (widget.userProfile.height! - viewModel.minHeightCm) * viewModel.pixelsPerCm;
      viewModel.setInitialScrollOffset(initialOffset); // Tambahkan method ini di ViewModel
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleHorizontalDragUpdate(DragUpdateDetails details, HeightPickerViewModel viewModel) {
    viewModel.updateScrollAndHeight(details.delta.dx);
  }

  void _handleHorizontalDragEnd(DragEndDetails details, HeightPickerViewModel viewModel) {
    // Animasi untuk snapping
    _animation = Tween<double>(
      begin: viewModel.currentHeightCm,
      end: viewModel.currentHeightCm.roundToDouble(),
    ).animate(_animationController)
      ..addListener(() {
        // Ini akan memicu UI update selama animasi
        // Namun, kita tidak update state di sini lagi karena ViewModel sudah mengurusnya
      });
    _animationController.forward(from: 0.0).then((_) {
      viewModel.snapHeight(); // Panggil snapHeight setelah animasi selesai
      _animationController.reset(); // Reset controller untuk penggunaan berikutnya
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HeightPickerViewModel>(
      builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor: Colors.green[600],
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            toolbarHeight: 0,
          ),
          body: SafeArea(
            child: Column(
              children: [
                SizedBox(height: 40),
                Text(
                  "What's your current\nheight right now?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildUnitButton('cm', viewModel.isCmSelected, () {
                      viewModel.toggleUnit(true);
                    }),
                    SizedBox(width: 16),
                    _buildUnitButton('ft', !viewModel.isCmSelected, () {
                      viewModel.toggleUnit(false);
                    }),
                  ],
                ),
                SizedBox(height: 60),
                Text(
                  viewModel.getFormattedHeight(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 40),
                Expanded(
                  child: GestureDetector(
                    onHorizontalDragUpdate: (details) => _handleHorizontalDragUpdate(details, viewModel),
                    onHorizontalDragEnd: (details) => _handleHorizontalDragEnd(details, viewModel),
                    child: CustomPaint(
                      size: Size(MediaQuery.of(context).size.width, 100.0),
                      painter: RulerPainter(
                        minHeight: viewModel.minHeightCm,
                        maxHeight: viewModel.maxHeightCm,
                        pixelsPerCm: viewModel.pixelsPerCm,
                        scrollOffset: viewModel.scrollOffset,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 3,
                    height: 100.0 + 20,
                    color: Colors.redAccent,
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Update userProfile dengan tinggi yang dipilih
                          final updatedProfile = widget.userProfile.copyWith(height: viewModel.currentHeightCm.round());
                          print('Next pressed! Height: ${updatedProfile.height} cm');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChangeNotifierProvider(
                                create: (_) => GenderPickerViewModel(),
                                child: GenderPickerScreen(userProfile: updatedProfile), // Teruskan UserProfile
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.yellow[400],
                          foregroundColor: Colors.black,
                          minimumSize: Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'Next →',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      SizedBox(height: 16),
                      TextButton(
                        onPressed: () {
                          print('Back pressed from HeightPickerScreen!');
                          Navigator.pop(context); // Kembali ke layar sebelumnya (jika ada, atau keluar app)
                        },
                        child: Text(
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

  Widget _buildUnitButton(String text, bool isSelected, VoidCallback onPressed) {
    return SizedBox(
      width: 100,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? Colors.white : Colors.green[400],
          foregroundColor: isSelected ? Colors.black : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: isSelected ? BorderSide.none : BorderSide(color: Colors.white54, width: 1),
          ),
          elevation: 0,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

// RulerPainter tetap sama
class RulerPainter extends CustomPainter {
  final double minHeight;
  final double maxHeight;
  final double pixelsPerCm;
  final double scrollOffset;

  RulerPainter({
    required this.minHeight,
    required this.maxHeight,
    required this.pixelsPerCm,
    required this.scrollOffset,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint tickPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;

    final TextPainter textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );

    final double screenCenterX = size.width / 2;

    for (double i = minHeight; i <= maxHeight; i += 1.0) {
      double xContentPos = (i - minHeight) * pixelsPerCm;
      double x = screenCenterX - scrollOffset + xContentPos;

      if (x >= -20 && x <= size.width + 20) {
        double tickLength = 0;
        if (i % 10 == 0) {
          tickLength = 40.0;
          textPainter.text = TextSpan(
            text: i.round().toString(),
            style: TextStyle(color: Colors.white, fontSize: 16),
          );
          textPainter.layout();
          textPainter.paint(canvas, Offset(x - textPainter.width / 2, size.height / 2 + tickLength / 2 + 5));
        } else if (i % 5 == 0) {
          tickLength = 30.0;
        } else {
          tickLength = 20.0;
        }

        canvas.drawLine(
          Offset(x, size.height / 2 - tickLength / 2),
          Offset(x, size.height / 2 + tickLength / 2),
          tickPaint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant RulerPainter oldDelegate) {
    return oldDelegate.scrollOffset != scrollOffset ||
           oldDelegate.minHeight != minHeight ||
           oldDelegate.maxHeight != maxHeight;
  }
}