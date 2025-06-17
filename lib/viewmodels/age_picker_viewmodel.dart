import 'package:flutter/material.dart';

class AgePickerViewModel extends ChangeNotifier {
  int _selectedAge;
  late FixedExtentScrollController _scrollController;

  AgePickerViewModel({int initialAge = 18}) : _selectedAge = initialAge {
    _scrollController = FixedExtentScrollController(initialItem: _selectedAge);
  }

  // Getters
  int get selectedAge => _selectedAge;
  FixedExtentScrollController get scrollController => _scrollController;

  // Actions
  void updateSelectedAge(int newAge) {
    if (_selectedAge != newAge) {
      _selectedAge = newAge;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}