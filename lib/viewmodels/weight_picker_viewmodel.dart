import 'package:flutter/material.dart';

class WeightPickerViewModel extends ChangeNotifier {
  double _currentKg;
  bool _isKgSelected;
  double _scrollOffset;

  final double _minKg = 1.0;
  final double _maxKg = 150.0;
  final double _pixelsPerKg = 10.0;

  // Constructor
  WeightPickerViewModel({double initialWeightKg = 70.0})
      : _currentKg = initialWeightKg,
        _isKgSelected = true,
        _scrollOffset = (initialWeightKg - 1.0) * 10.0;

  // Getters
  double get currentKg => _currentKg;
  bool get isKgSelected => _isKgSelected;
  double get scrollOffset => _scrollOffset;
  double get minKg => _minKg;
  double get maxKg => _maxKg;
  double get pixelsPerKg => _pixelsPerKg;

  // Setters/Actions
  void toggleUnit(bool toKg) {
    if (_isKgSelected != toKg) {
      _isKgSelected = toKg;
      notifyListeners();
    }
  }

  void updateScrollAndWeight(double deltaX) {
    _scrollOffset -= deltaX;
    _currentKg = _minKg + (_scrollOffset / _pixelsPerKg);
    _currentKg = _currentKg.clamp(_minKg, _maxKg);
    _scrollOffset = (_currentKg - _minKg) * _pixelsPerKg;
    notifyListeners();
  }

  void snapWeight() {
    double snappedWeight = _currentKg.roundToDouble();
    _currentKg = snappedWeight;
    _scrollOffset = (_currentKg - _minKg) * _pixelsPerKg;
    notifyListeners();
  }

  String getFormattedWeight() {
    if (_isKgSelected) {
      return '${_currentKg.round()} kg';
    } else {
      return '${(_currentKg * 2.20462).toStringAsFixed(1)} lbs';
    }
  }

  // Tambahkan ini jika Anda perlu mengatur offset awal dari luar
  void setInitialScrollOffset(double offset) {
    _scrollOffset = offset;
    notifyListeners();
  }
}