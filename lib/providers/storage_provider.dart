import 'package:flutter/material.dart';

class StorageProvider extends ChangeNotifier {
  List<String> _selectedDates = [];
  List<String> get selectedDates => _selectedDates;
  set selectedDates(List<String> value) {
    _selectedDates = value;
    notifyListeners();
  }
}