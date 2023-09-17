import 'package:flutter/material.dart';

class PeriodNotification {
  String? reminderDays;
  String? reminderTime;
  String? reminderTextController;
  bool? hasData;

  PeriodNotification(
      {this.reminderDays, this.reminderTime, this.reminderTextController, this.hasData});

  PeriodNotification.fromJson(Map<String, dynamic> json) {
    reminderDays = json['reminderDays'];
    reminderTime = json['reminderTime'];
    hasData = json['hasData'];
    reminderTextController = json['reminderTextController'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reminderDays'] = this.reminderDays;
    data['reminderTime'] = this.reminderTime;
    data['hasData'] = this.hasData;
    data['reminderTextController'] = this.reminderTextController;
    return data;
  }
}

class LateNotification {
  String? reminderTime;
  String? reminderTextController;
  bool? hasData;

  LateNotification(
      {this.reminderTime, this.reminderTextController, this.hasData});

  LateNotification.fromJson(Map<String, dynamic> json) {
    reminderTime = json['reminderTime'];
    hasData = json['hasData'];
    reminderTextController = json['reminderTextController'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reminderTime'] = this.reminderTime;
    data['hasData'] = this.hasData;
    data['reminderTextController'] = this.reminderTextController;
    return data;
  }
}

class EndOfPeriodsNotification {
  String? reminderTime;
  String? reminderTextController;
  bool? hasData;

  EndOfPeriodsNotification(
      {this.reminderTime, this.reminderTextController, this.hasData});

  EndOfPeriodsNotification.fromJson(Map<String, dynamic> json) {
    reminderTime = json['reminderTime'];
    hasData = json['hasData'];
    reminderTextController = json['reminderTextController'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reminderTime'] = this.reminderTime;
    data['hasData'] = this.hasData;
    data['reminderTextController'] = this.reminderTextController;
    return data;
  }
}

class OvulationNotification {
  String? reminderDays;
  String? reminderTime;
  String? reminderTextController;
  bool? hasData;

  OvulationNotification(
      {this.reminderDays, this.reminderTime, this.reminderTextController, this.hasData});

  OvulationNotification.fromJson(Map<String, dynamic> json) {
    reminderDays = json['reminderDays'];
    reminderTime = json['reminderTime'];
    hasData = json['hasData'];
    reminderTextController = json['reminderTextController'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reminderDays'] = this.reminderDays;
    data['reminderTime'] = this.reminderTime;
    data['hasData'] = this.hasData;
    data['reminderTextController'] = this.reminderTextController;
    return data;
  }
}

