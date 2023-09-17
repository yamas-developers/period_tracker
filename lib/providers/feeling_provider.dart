import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:period_tracker/providers/story_provider.dart';

import '../models/calendarData/calendar_data.dart';

class FeelingProvider extends ChangeNotifier {
  List _notes = [];

  /// these notes will not be specific to any day
  List _allNotes = [];

  /// these notes will be combination of day specific and

  /// other general ones
  List symptoms = [
    'Backache',
    'Headache',
    'Cramps',
    'Fetigue',
    'Acne',
    'Muscle pain',
    'Sensitive Breasts',
    'Everything is fine',
    'bloating',
    'Increased Appetite',
    'Insomnia',
    'Colic gas',
    'Nausea',
    'Diarrhea',
    'Constipation',
    'Chills'
  ];

  List mood = [
    'Sad',
    'Indifferent',
    'Happy',
    'Angry',
    'Neutral',
    'Changeable',
    'Anxious',
    'Stress',
    'Excited',
    'Melancholy',
    'panicking',
    'Inspired',
  ];

  List sex = [
    'Sex with protection',
    'Sex without protection',
    'Masturbation',
    'High sex drive',
    'Orgasm'
  ];

  List mensus = ['Light', 'Moderate', 'Heavy'];

  List vaginalDischarge = [
    'Spotting',
    'No discharge',
    'Sticky',
    'Creamy',
    'Egg-white',
    'Watery',
    'Bad odor',
    'Atypical',
  ];

  List contraceptives = ['Pill taken', 'Yesterday\'s pill'];

  /////////variables
  List<dynamic> _selectedSymptoms = [];
  List<dynamic> _selectedMood = [];
  List<dynamic> _selectedSex = [];
  List<dynamic> _selectedDischarge = [];
  List<dynamic> _selectedContraceptives = [];
  List<dynamic> _selectedNotes = [];
  List<dynamic> _selectedDates=[];


  /// these notes will be specific to any day

  String _selectedMensus = '';
  List<dynamic> _selectMensus=[];
  CalendarData? _calendarData;

  CalendarData? get calendarData => _calendarData;

  set calendarData(CalendarData? value) {
    _calendarData = value;
    notifyListeners();
  }

  List<dynamic> get selectMensus => _selectMensus;

  List<dynamic> get selectedDates => _selectedDates;

  set selectedDates(List<dynamic> value) {
    _selectedDates = value;
    print("selectedDatesFP$value");
    notifyListeners();
  }

  void addSelectedDate(String date){
    selectedDates.add(date);
    print("selectedDate$date");
    notifyListeners();
  }

  set selectMensus(List<dynamic> value) {
    _selectMensus = value;
    print("selectMensus$value");
    notifyListeners();
  }

  clearLists() {
    _selectedSymptoms.clear();
    _selectedMood.clear();
    _selectedSex.clear();
    _selectedDischarge.clear();
    _selectedContraceptives.clear();
    _selectedMensus = '';
    _selectedNotes.clear();
    _allNotes.clear();
    notifyListeners();
  }

  ////////misc

  storeData(String? jsonString) {
    clearLists();
    if (jsonString == null) {
      return;
    }
    Map<String, dynamic> data = jsonDecode(jsonString);
    _selectedSymptoms = data['symptoms'] ?? [];
    _selectedMood = data['mood'] ?? [];
    _selectedSex = data['sex'] ?? [];
    _selectedDischarge = data['discharge'] ?? [];
    _selectedContraceptives = data['contraceptives'] ?? [];
    _selectedMensus = data['mensus'] ?? '';
    _selectedNotes = data['notes'] ?? [];
    _allNotes = _selectedNotes.toList();
    log('MK: all notes in pro: ${notes} $_selectedNotes $_allNotes');
    _notes.forEach((element) {
      if (!_allNotes.contains(element)) {
        _allNotes.add(element);
      }
    });
    notifyListeners();
  }

  String getDecodedData() {
    if (_selectedSymptoms.isEmpty &&
        _selectedNotes.isEmpty &&
        _selectedMood.isEmpty &&
        _selectedSex.isEmpty &&
        _selectedDischarge.isEmpty &&
        _selectedContraceptives.isEmpty &&
        _selectedMensus == '') {
      return '';
    }
    return jsonEncode({
      'symptoms': _selectedSymptoms,
      'notes': _selectedNotes,
      'mood': _selectedMood,
      'sex': _selectedSex,
      'discharge': _selectedDischarge,
      'contraceptives': _selectedContraceptives,
      'mensus': _selectedMensus
    });
  }


  //////geters and setters
  List get selectedMood => _selectedMood;

  List get selectedSymptoms => _selectedSymptoms;

  set selectedMood(List value) {
    _selectedMood = value;
    notifyListeners();
  }

  set selectedSymptoms(List value) {
    _selectedSymptoms = value;
    notifyListeners();
  }

  List get selectedSex => _selectedSex;

  set selectedSex(List value) {
    _selectedSex = value;
    notifyListeners();
  }

  String get selectedMensus => _selectedMensus;

  set selectedMensus(String value) {
    _selectedMensus = value;
    print("selectedMensusFP$value");
    selectMensus.add(value);
    notifyListeners();
  }

  List get notes => _notes;

  set notes(List value) {
    _notes = value;
    notifyListeners();
  }

  List get selectedContraceptives => _selectedContraceptives;

  set selectedContraceptives(List value) {
    _selectedContraceptives = value;
    notifyListeners();
  }

  List get selectedDischarge => _selectedDischarge;

  set selectedDischarge(List value) {
    _selectedDischarge = value;
    notifyListeners();
  }

  List get selectedNotes => _selectedNotes;

  set selectedNotes(List value) {
    _selectedNotes = value;
    notifyListeners();
  }

  List get allNotes => _allNotes;

  set allNotes(List value) {
    _allNotes = value;
    notifyListeners();
  }
}
