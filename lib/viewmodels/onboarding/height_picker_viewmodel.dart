import 'package:flutter/material.dart';

class HeightPickerViewModel extends ChangeNotifier {
  double _currentHeightCm;
  bool _isCmSelected;
  double _scrollOffset;

  final double _minHeightCm = 100.0;
  final double _maxHeightCm = 250.0;
  final double _pixelsPerCm = 10.0;

  // Constructor
  HeightPickerViewModel({double initialHeightCm = 172.0})
      : _currentHeightCm = initialHeightCm,
        _isCmSelected = true,
        _scrollOffset = (initialHeightCm - 100.0) * 10.0; // Calculate initial offset

  // Getters
  double get currentHeightCm => _currentHeightCm;
  bool get isCmSelected => _isCmSelected;
  double get scrollOffset => _scrollOffset;
  double get minHeightCm => _minHeightCm;
  double get maxHeightCm => _maxHeightCm;
  double get pixelsPerCm => _pixelsPerCm;

  // Setters/Actions
  void toggleUnit(bool toCm) {
    if (_isCmSelected != toCm) {
      _isCmSelected = toCm;
      notifyListeners();
    }
  }

  void updateScrollAndHeight(double deltaX) {
    _scrollOffset -= deltaX; // Invert for natural dragging
    _currentHeightCm = _minHeightCm + (_scrollOffset / _pixelsPerCm);

    // Clamp the height to the min/max values
    _currentHeightCm = _currentHeightCm.clamp(_minHeightCm, _maxHeightCm);
    _scrollOffset = (_currentHeightCm - _minHeightCm) * _pixelsPerCm;

    notifyListeners();
  }

  void snapHeight() {
    double snappedHeight = _currentHeightCm.roundToDouble();
    // In a real app, you might animate this in the ViewModel or let the View handle animation
    // For simplicity, we directly set it here after rounding.
    _currentHeightCm = snappedHeight;
    _scrollOffset = (_currentHeightCm - _minHeightCm) * _pixelsPerCm;
    notifyListeners();
  }

  String getFormattedHeight() {
    if (_isCmSelected) {
      return '${_currentHeightCm.round()} cm';
    } else {
      return '${(_currentHeightCm * 0.0328084).toStringAsFixed(1)} ft';
    }
  }
}