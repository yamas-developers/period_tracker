class UserData {
  String selectedDate;
  String cyclingAverageNo;
  String menstruationDays;
  String dob;
  String remainderDays;
  String remainderTime;

  UserData({
    required this.selectedDate,
    required this.cyclingAverageNo,
    required this.menstruationDays,
    required this.dob,
    required this.remainderDays,
    required this.remainderTime,
  });

  Map<String, dynamic> toJson() {
    return {
      'selectedDate': selectedDate,
      'cyclingAverageNo': cyclingAverageNo,
      'menstruationDays': menstruationDays,
      'dob': dob,
      'remainderDays': remainderDays,
      'remainderTime': remainderTime,
    };
  }
}
