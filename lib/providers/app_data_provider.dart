import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:period_tracker/models/user_data.dart';
import 'package:period_tracker/routes/session_manager.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/constants.dart';

class AppDataProvider with ChangeNotifier {
  List<UserData> _userDataList = [];
  String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();

  String? _time;

  List<UserData> get userDataList => _userDataList;

  DateTime? _startDate;

  String? get time => _time;

  DateTime? get startDate => _startDate;

  set startDate(DateTime? value) {
    _startDate = value;
    notifyListeners();
  }

  set time(String? value) {
    _time = value;
    notifyListeners();
  }

  String _endTime = DateFormat("hh:mm a")
      .format(DateTime.now().add(const Duration(hours: 2)))
      .toString();

  void addUser(UserData userData, context) {
    _userDataList.add(userData);
    debugPrint("MA: sessionManager=>userData$userData");
    SessionManager sessionManager = SessionManager();
    sessionManager.storeIntroScreenData(userData);
    notifyListeners();
  }

  // String userDataToJson(UserData userData) {
  //   return json.encode({
  //     'selectedDate': userData.selectedDate,
  //     'cyclingAverageNo': userData.cyclingAverageNo,
  //     'menstruationDays': userData.menstruationDays,
  //     'dob': userData.dob,
  //     'remainderDays': userData.remainderDays,
  //     'remainderTime': userData.remainderTime,
  //   });
  // }
  //
  // // Future<void> storeUserData(context) async {
  // //   final appDataProvider = Provider.of<AppDataProvider>(context);
  // //   SharedPreferences prefs = await SharedPreferences.getInstance();
  // //
  // //   List<String> userDataStrings = appDataProvider.userDataList.map((userData) => userDataToJson(userData)).toList();
  // //
  // //   prefs.setStringList('user_data_list', userDataStrings);
  // // }

  Future selectTime(context) async {
    var pickedTime = await showTimePicker(
      context: context,
      builder: (BuildContext context, Widget? child) {
        return Theme(data: ThemeData(), child: child ?? const SizedBox());
      },
      initialTime: TimeOfDay(
          hour: int.parse(_startTime.split(':')[0]),
          minute: int.parse(_endTime.split(':')[1].split(" ")[0])),
    );
    String? formatTime = pickedTime?.format(context);
    if (pickedTime != null) {
      time = formatTime!;
    }
  }

  String formatDate(DateTime dateTime) {
    return DateFormat('M/d/y').format(dateTime);
  }

  Future<void> selectDate(BuildContext context,
      {type = "normal", initialDate = null}) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate == null ? DateTime.now() : initialDate,
      firstDate: type == "full" ? DateTime(1900) : DateTime.now(),
      lastDate: type == "full" ? DateTime.now() : DateTime(2090),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: fontColor,
            hintColor: fontColor,
            colorScheme: const ColorScheme.light(primary: fontColor),
            buttonTheme: const ButtonThemeData(
              textTheme: ButtonTextTheme.primary,
            ),
          ),
          child: child!,
        );
      },
    );
    if (pickedDate != null) {
      _startDate = pickedDate;
      notifyListeners();
    }
  }

  bool _isDarkMode = false;
  bool _check=false;


  bool get check => _check;

  set check(bool value) {
    _check = value;
    notifyListeners();
  }

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
    saveThemePreference();
  }
  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    check= prefs.getBool('isLightMode') ?? false;
    _isDarkMode =!check;
        print("load$_isDarkMode");
    notifyListeners();
  }

  Future<void> saveThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    print("save$_isDarkMode");
    await prefs.setBool('isLightMode', _isDarkMode);
  }
}
