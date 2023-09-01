import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_data.dart';

class SessionManager {

  Future<String?> getDataFromSP(String key)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(key.isNotEmpty){
      return prefs.getString(key);
    }
    return null;
  }

  void lastPeriodDate(String date)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    debugPrint("MA: sessionManager=>lastPeriodDate$date");
    prefs.setString('date', date);
  }
  void cyclingAverageDays(String days)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    debugPrint("MA: sessionManager=>averagePeriodDays$days");
    prefs.setString('cyclingAverageDays', days);
  }
  void menstruationAverage(String days)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    debugPrint("MA: sessionManager=>averageMenstruationDays$days");
    prefs.setString('menstruationAverage', days);
  }
  void dateOfBirth(String date)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    debugPrint("MA: sessionManager=>dateOfBirth$date");
    prefs.setString('dob', date);
  }
  void reminderDays(String days, String time)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    debugPrint("MA: sessionManager=>reminder$days/time$time}");
    prefs.setString('reminderDays', days);
    prefs.setString('reminderTime', time);
  }
  void storeAppData(UserData userData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userDataJson = jsonEncode(userData.toJson());
    debugPrint("MA: sessionManager=>Last Period Screen${userData.selectedDate}/${userData.remainderTime}");
    prefs.setString('userData', userDataJson);
  }

  void storeDarkModel(String theme)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("darkMode", theme);
    debugPrint("MA: sessionManager=>theme$theme");
  }

  // Future<void> storeUserData(List<UserData> userDataList) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //
  //   List<String> userDataStrings = userDataList.map((userData) => userDataToJson(userData)).toList();
  //
  //   prefs.setStringList('user_data_list', userDataStrings);
  // }
  // String userDataToJson(UserData userData) {
  //   return json.encode({
  //     'date': userData.selectedDate,
  //     'days': userData,
  //     'eachDay': userData.eachDay,
  //     'dateOfBirth': userData.dateOfBirth,
  //     'reminder': userData.reminder,
  //   });
  // }
}
