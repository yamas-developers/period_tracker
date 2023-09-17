import 'package:flutter/material.dart';

import '../models/profile/cycles.dart';
import '../models/profile/notification/notification.dart';

class UserDataProvider with ChangeNotifier{
 Cycles _cycles=Cycles();
 PeriodNotification _notificationPeriod=PeriodNotification();
 bool _notPeriod=false;
 bool _notLate=false;
 bool _notEndOfPeriod=false;
 bool _notOvolution=false;
 bool _notContraception=false;

 bool? _checkIntroData;
 String? _introScreenData;
 String? _calendarData;
 bool? _checkCalendarData;

 String? get calendarData => _calendarData;

  set calendarData(String? value) {
    _calendarData = value;
  }

  String? get introScreenData => _introScreenData;

  set introScreenData(String? value) {
    _introScreenData = value;
    notifyListeners();
  }

  bool? get checkIntroData => _checkIntroData;

  set checkIntroData(bool? value) {
    _checkIntroData = value;
    notifyListeners();
  } // TimeOfDay timeOfDay = TimeOfDay(hour: 12, minute: 0);

  LateNotification _lateNotification=LateNotification();

 EndOfPeriodsNotification _endOfPeriodsNotification=EndOfPeriodsNotification();

 OvulationNotification _ovulationNotification=OvulationNotification();
 LateNotification get lateNotification => _lateNotification;
 bool get notPeriod => _notPeriod;


 PeriodNotification get notificationPeriod => _notificationPeriod;
  EndOfPeriodsNotification get endOfPeriodsNotification => _endOfPeriodsNotification;
 Cycles get cycles => _cycles;
 OvulationNotification get ovulationNotification => _ovulationNotification;
  set ovulationNotification(OvulationNotification value) {
    _ovulationNotification = value;
    notifyListeners();
  }


  set notPeriod(bool value) {
    _notPeriod = value;
    notifyListeners();
  }

  set endOfPeriodsNotification(EndOfPeriodsNotification value) {
    _endOfPeriodsNotification = value;
    notifyListeners();
  }
  set notificationPeriod(PeriodNotification value) {
    _notificationPeriod = value;
    notifyListeners();
  }
 set lateNotification(LateNotification value) {
   _lateNotification = value;
   print("MA: UDP=>${value.reminderTime}");
   notifyListeners();
 }

  set cycles(Cycles value) {
    _cycles = value;
    notifyListeners();
  }

 bool get notEndOfPeriod => _notEndOfPeriod;

  set notEndOfPeriod(bool value) {
    _notEndOfPeriod = value;
    notifyListeners();
  }

 bool get notOvolution => _notOvolution;

  set notOvolution(bool value) {
    _notOvolution = value;
    notifyListeners();
  }

 bool get notLate => _notLate;

 set notLate(bool value) {
   _notLate = value;
   notifyListeners();
 }

 bool get notContraception => _notContraception;

  set notContraception(bool value) {
    _notContraception = value;
    notifyListeners();
  }

 bool? get checkCalendarData => _checkCalendarData;

  set checkCalendarData(bool? value) {
    _checkCalendarData = value;
  }
}