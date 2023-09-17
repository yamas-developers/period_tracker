import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/profile/cycles.dart';
import '../models/profile/notification/notification.dart';
import '../models/user_data.dart';

class SessionManager {
  Future<String?> getDataFromSP(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (key.isNotEmpty) {
      return prefs.getString(key);
    }
    return null;
  }

  Future<bool?> checkData(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (key.isNotEmpty) {
      String? data = prefs.getString(key);
      if (data != null) {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }
  Future<bool?> checkBoolData(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (key.isNotEmpty) {
      bool? data = prefs.getBool(key);
      if (data ==true) {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }

  Future<void> saveCalendarData(
    List<dynamic> date,
    List<dynamic> selectedSymptoms,
    List<dynamic> selectedMood,
    List<dynamic> selectedSex,
    List<dynamic> selectedMensus,
    List<dynamic> vaginalDischarge,
    List<dynamic> contraceptives,
  ) async {
    Map<dynamic, dynamic> dataMap = {};
    for (int i = 0; i < date.length; i++) {
      dataMap[date[i]] = {
        'symptoms': selectedSymptoms,
        'mood': selectedMood,
        'sex': selectedSex,
        'discharge': selectedMensus,
        'contraceptives': vaginalDischarge,
        'notes': contraceptives,
      };
    }
    storeData("CalendarData", jsonEncode(dataMap));
  }

  void storeData(String key, dynamic object) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = json.encode(object);
    print("storeData=>SM=>$jsonString");
    prefs.setString(key, jsonString);
  }
  Future<String?> getData(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? saveData=prefs.getString(key);
    print("storeData=>SM=>$saveData");
    return saveData;
  }

  void storeSPData(String key, Map<DateTime, String> object) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> stringMap = {};
    object.forEach((key, value) {
      stringMap[key.toString()] = value;
    });
    String jsonString = jsonEncode(stringMap);
    print("storeSPData$jsonString");

    prefs.setString("CalendarData", jsonString);
  }

  void storeString(String key, String data)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    debugPrint("MA: sessionManager=>$data");
    prefs.setString(key, data);
  }

  void reminderDays(String days, String time) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    debugPrint("MA: sessionManager=>reminder$days/time$time}");
    prefs.setString('reminderDays', days);
    prefs.setString('reminderTime', time);
  }

  void storeIntroScreenData(UserData userData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userDataJson = jsonEncode(userData.toJson());
    debugPrint(
        "MA: sessionManager=>Last Period Screen${userData.selectedDate}/${userData.remainderTime}");
    prefs.setString('introScreensData', userDataJson);
  }

  void storeProfileCycles(Cycles cycles) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userDataJson = jsonEncode(cycles.toJson());
    debugPrint(
        "MA: sessionManager=>CyclesData${cycles.cycles}/${cycles.periods}/${cycles.hasData}");
    prefs.setString('profileCyclesData', userDataJson);
  }

  void storeDarkModel(String theme) async {
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
