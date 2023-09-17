import 'dart:developer';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:period_tracker/constants.dart';

class DatesProvider extends ChangeNotifier {
  bool _editMode = false;
  String? _calendarData;

  String? get calendarData => _calendarData;

  set calendarData(String? value) {
    _calendarData = value;
    print("MA: DP=>$value");
    notifyListeners();
  }

  Map<DateTime, String> _feelingData = {};

  Map<DateTime, String> get feelingData => _feelingData;

  set feelingData(Map<DateTime, String> value) {
    _feelingData = value;
    notifyListeners();
  }

  DateTime _selectedDay = DateTime.now();

  DateTime get selectedDay => _selectedDay;

  set selectedDay(DateTime value) {
    _selectedDay = value;
    notifyListeners();
  }

  List<DateTime> _periods = [
    DateTime.parse("2023-05-04"),
    DateTime.parse("2023-05-05"),
    DateTime.parse("2023-05-06"),
    DateTime.parse("2023-05-07"),
    DateTime.parse("2023-05-08"),
    DateTime.parse("2023-05-09"),
  ];

  List<DateTime> _futurePeriods = [];
  List<DateTime> _futureOvulations = [];
  List<DateTime> _ovulations = [];

  List<DateTime> get ovulations => _ovulations;

  set ovulations(List<DateTime> value) {
    _ovulations = value;
    notifyListeners();
  }

  List<DateTime> get futurePeriods => _futurePeriods;

  set futurePeriods(List<DateTime> value) {
    _futurePeriods = value;
    notifyListeners();
  }

  List<DateTime> get futureOvulations => _futureOvulations;

  set futureOvulations(List<DateTime> value) {
    _futureOvulations = value;
    notifyListeners();
  }

  DateTime _maxPeriodDay = DateTime.now();

  DateTime get maxPeriodDay => _maxPeriodDay;

  set maxPeriodDay(DateTime value) {
    _maxPeriodDay = value;
    notifyListeners();
  }

  List<DateTime> get periods => _periods;

  set periods(List<DateTime> value) {
    _periods = value;
    notifyListeners();
  }

  bool get editMode => _editMode;

  set editMode(bool value) {
    _editMode = value;
    notifyListeners();
  }

  addOrRemoveDays(DateTime date) {
    _periods.contains(date) ? _periods.remove(date) : _periods.add(date);
    _periods = _periods;
    if (date.isAfter(_maxPeriodDay)) {
      _maxPeriodDay = date;
    }
    notifyListeners();
    log('MK: periods: ${_periods}');
  }

  predict() {
    // Sort the mergedPeriodDates list in ascending order
    _periods.sort();

    // Split the merged list into individual periods
    List<List<DateTime>> individualPeriods = splitIntoPeriods(_periods);

    // Calculate the average cycle length
    int averageCycleLength = 0;
    for (int i = 0; i < individualPeriods.length - 1; i++) {
      int totalDays = individualPeriods[i + 1]
          .first
          .difference(individualPeriods[i].first)
          .inDays;

      if (totalDays < 41 && totalDays > 21) {
        if (averageCycleLength == 0) {
          averageCycleLength = totalDays;
        } else {
          averageCycleLength = ((totalDays + averageCycleLength) / 2).floor();
        }
      }

      log('MK: averageCycleLength: $averageCycleLength and $totalDays');
    }
    if (averageCycleLength == 0) {
      averageCycleLength = 29;
    }

    log('MK: Average Cycle Length: $averageCycleLength days');

    // Iterate over each period to find the first and last period dates and calculate the average cycle length
    for (List<DateTime> periodDates in individualPeriods) {
      DateTime firstPeriod = periodDates.first;
      DateTime lastPeriod = periodDates.last;

      // int averageCycleLength = calculateAverageCycleLength(periodDates);
      log('Period:');
      log('First Period: ${DateFormat('yyyy-MM-dd').format(firstPeriod)}');
      log('Last Period: ${DateFormat('yyyy-MM-dd').format(lastPeriod)}');

      // Predict future periods and ovulation days
      int monthsToPredict = 6;
      List<DateTime> nextPeriods = predictFuturePeriods(
          firstPeriod, averageCycleLength, monthsToPredict);
      _futurePeriods.clear();
      for (DateTime period in nextPeriods) {
        for (int i = 0; i < 5; i++) {
          _futurePeriods.add(period.add(Duration(days: i)));
        }
      }
      _ovulations.clear();
      List<DateTime> ovulationDays = calculateOvulationDays(nextPeriods);
      _ovulations = ovulationDays;
      _futureOvulations.clear();
      for (DateTime period in ovulationDays) {
        for (int i = 0; i < 7; i++) {
          _futureOvulations.add(period.add(Duration(days: i)));
        }
      }

      log('--------------------------- ${_futurePeriods}');
    }
    notifyListeners();
  }

  List<List<DateTime>> splitIntoPeriods(List<DateTime> mergedPeriodDates) {
    List<List<DateTime>> individualPeriods = [];
    List<DateTime> currentPeriod = [];

    for (int i = 0; i < mergedPeriodDates.length; i++) {
      if (currentPeriod.isEmpty ||
          currentPeriod.last.nextDay.isSameDay(mergedPeriodDates[i])) {
        currentPeriod.add(mergedPeriodDates[i]);
      } else {
        individualPeriods.add(currentPeriod);
        currentPeriod = [];
        currentPeriod.add(mergedPeriodDates[i]);
      }
    }

    if (currentPeriod.isNotEmpty) {
      individualPeriods.add(currentPeriod);
    }

    return individualPeriods;
  }

  List<DateTime> predictFuturePeriods(
      DateTime firstPeriod, int averageCycleLength, int months) {
    List<DateTime> futurePeriods = [];

    for (int i = 0; i < months; i++) {
      DateTime nextPeriod = firstPeriod.add(Duration(days: averageCycleLength));
      futurePeriods.add(nextPeriod);
      firstPeriod = nextPeriod;
    }

    return futurePeriods;
  }

  List<DateTime> calculateOvulationDays(List<DateTime> futurePeriods) {
    List<DateTime> ovulationDays = [];

    for (DateTime period in futurePeriods) {
      DateTime ovulationDay = period.subtract(Duration(days: 14));
      ovulationDays.add(ovulationDay);
    }

    return ovulationDays;
  }
}
