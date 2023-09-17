import 'dart:convert';

class OralContraceptives {
  String? type;
  String? time;
  String? reminderText;
  String? pillsIPack;
  String? pillStartDate;
  String? repeatUntilOc;

  OralContraceptives(
      {this.type,
        this.time,
        this.reminderText,
        this.pillsIPack,
        this.pillStartDate,
        this.repeatUntilOc});

  OralContraceptives.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    time = json['time'];
    reminderText = json['reminderText'];
    pillsIPack = json['pillsIPack'];
    pillStartDate = json['pillStartDate'];
    repeatUntilOc = json['repeatUntilOc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['time'] = this.time;
    data['reminderText'] = this.reminderText;
    data['pillsIPack'] = this.pillsIPack;
    data['pillStartDate'] = this.pillStartDate;
    data['repeatUntilOc'] = this.repeatUntilOc;
    return data;
  }
}

class Patch {
  String? type;
  String? time;
  String? reminderText;
  String? firstPatchDate;

  Patch({this.type, this.time, this.reminderText, this.firstPatchDate});

  Patch.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    time = json['time'];
    reminderText = json['reminderText'];
    firstPatchDate = json['firstPatchDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['time'] = this.time;
    data['reminderText'] = this.reminderText;
    data['firstPatchDate'] = this.firstPatchDate;
    return data;
  }
}
class IUD {
  String? type;
  String? iudType;
  String? periodOfUse;
  String? intrauterineInputDate;
  String? wireCheck;
  String? iudReplacementTime;
  String? iudReminderText;
  OnceAYear? onceAYear;
  AfterMenstruation? afterMenstruation;

  IUD(
      {this.type,
        this.iudType,
        this.periodOfUse,
        this.intrauterineInputDate,
        this.wireCheck,
        this.iudReplacementTime,
        this.onceAYear,
        this.afterMenstruation,
        this.iudReminderText});

  IUD.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    iudType = json['iudType'];
    periodOfUse = json['periodOfUser'];
    intrauterineInputDate = json['intrauterineInput'];
    if (json["wireCheck"] == "No check") {
      wireCheck = json['wireCheck'];
    }
    if (json["wireCheck"] == "After menstruation") {
      afterMenstruation = AfterMenstruation.fromJson(json['wireCheck']);
    }
    if((json["wireCheck"] == "Once a year")){
      onceAYear = OnceAYear.fromJson(json['wireCheck']);
    }
    iudReplacementTime = json['iudReplacementTime'];
    iudReminderText = json['iudReminderText'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['iudType'] = this.iudType;
    data['periodOfUser'] = this.periodOfUse;
    data['intrauterineInput'] = this.intrauterineInputDate;
    if (this.wireCheck == "No check") {
      data['wireCheck'] = this.wireCheck;
    } else if (this.wireCheck == "After menstruation") {
      data['After menstruation'] = this.afterMenstruation;
    } else {
      data['onceAYear'] = this.onceAYear;
    }
    data['iudReplacementTime'] = this.iudReplacementTime;
    data['iudReminderText'] = this.iudReminderText;
    return data;
  }
}

class Injection {
  String? type;
  String? pillInPack;
  String? injectionDate;
  String? injectionTime;
  String? injectionReminderText;

  Injection(
      {this.type,
        this.pillInPack,
        this.injectionDate,
        this.injectionTime,
        this.injectionReminderText});

  Injection.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    pillInPack = json['pillInPack'];
    injectionDate = json['injectionDate'];
    injectionTime = json['injectionTime'];
    injectionReminderText = json['injectionReminderText'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['pillInPack'] = this.pillInPack;
    data['injectionDate'] = this.injectionDate;
    data['injectionTime'] = this.injectionTime;
    data['injectionReminderText'] = this.injectionReminderText;
    return data;
  }
}
class Implant {
  String? type;
  String? frequencyOfInjectionYear;
  String? implantInsertionDate;
  String? implantTime;
  String? implantReminderText;

  Implant(
      {this.type,
        this.frequencyOfInjectionYear,
        this.implantInsertionDate,
        this.implantTime,
        this.implantReminderText});

  Implant.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    frequencyOfInjectionYear = json['frequencyOfInjection'];
    implantInsertionDate = json['implantInsertion'];
    implantTime = json['ImplantTime'];
    implantReminderText = json['implantReminderText'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['frequencyOfInjection'] = this.frequencyOfInjectionYear;
    data['implantInsertion'] = this.implantInsertionDate;
    data['ImplantTime'] = this.implantTime;
    data['implantReminderText'] = this.implantReminderText;
    return data;
  }
}
class VaginalRing {
  String? packStartDate;
  String? reminderTime;
  String? type;
  String? reminderText;
  String? ringReminderTime;
  String? ringReminderText;

  VaginalRing(
      {this.packStartDate,
        this.reminderTime,
        this.type,
        this.reminderText,
        this.ringReminderTime,
        this.ringReminderText});

  VaginalRing.fromJson(Map<String, dynamic> json) {
    packStartDate = json['packStartDate'];
    reminderTime = json['reminderTime'];
    reminderText = json['reminderText'];
    type = json['type'];
    ringReminderTime = json['ringReminderTime'];
    ringReminderText = json['ringReminderText'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['packStartDate'] = this.packStartDate;
    data['reminderTime'] = this.reminderTime;
    data['reminderText'] = this.reminderText;
    data['type'] = this.type;
    data['ringReminderTime'] = this.ringReminderTime;
    data['ringReminderText'] = this.ringReminderText;
    return data;
  }
}
class AfterMenstruation {
  String? afterMenstruationReminderTime;
  String? afterMenstruationReminderText;

  AfterMenstruation(
      {this.afterMenstruationReminderText, this.afterMenstruationReminderTime});

  AfterMenstruation.fromJson(Map<String, dynamic> json) {
    afterMenstruationReminderText = json['afterMenstruationReminderText'];
    afterMenstruationReminderTime = json['afterMenstruationReminderTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['afterMenstruationReminderText'] = this.afterMenstruationReminderText;
    data['afterMenstruationReminderTime'] = this.afterMenstruationReminderTime;
    return data;
  }
}

class OnceAYear {
  String? onceAYearReminderTime;
  String? onceAYearReminderText;

  OnceAYear(
      {this.onceAYearReminderTime, this.onceAYearReminderText});

  OnceAYear.fromJson(Map<String, dynamic> json) {
    onceAYearReminderTime = json['onceAYearReminderTime'];
    onceAYearReminderText = json['onceAYearReminderText'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['onceAYearReminderText'] = this.onceAYearReminderText;
    data['onceAYearReminderTime'] = this.onceAYearReminderTime;
    return data;
  }
}