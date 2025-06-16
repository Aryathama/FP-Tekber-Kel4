import 'package:flutter/material.dart';
import '/models/user_profile.dart'; // Sesuaikan path

class GenderPickerViewModel extends ChangeNotifier {
  Gender? _selectedGender;

  Gender? get selectedGender => _selectedGender;

  void selectGender(Gender? gender) {
    if (_selectedGender != gender) {
      _selectedGender = gender;
      notifyListeners();
    }
  }

  bool get canProceed => _selectedGender != null;
}