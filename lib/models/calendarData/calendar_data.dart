class CalendarData {
  List<dynamic> selectedSymptoms = [];
  List<dynamic> selectedMood = [];
  List<dynamic> selectedSex = [];
  List<dynamic> selectedDischarge = [];
  List<dynamic> selectedContraceptives = [];
  List<dynamic> selectedNotes = [];
  List<dynamic> selectedDates = [];

  CalendarData({
    required this.selectedSymptoms,
    required this.selectedMood,
    required this.selectedSex,
    required this.selectedDischarge,
    required this.selectedContraceptives,
    required this.selectedNotes,
    required this.selectedDates,
  });

  // Create a factory constructor to create a UserDataModel from a JSON map
  factory CalendarData.fromJson(Map<String, dynamic> json) {
    return CalendarData(
      selectedSymptoms: json['selectedSymptoms'] ?? [],
      selectedMood: json['selectedMood'] ?? [],
      selectedSex: json['selectedSex'] ?? [],
      selectedDischarge: json['selectedDischarge'] ?? [],
      selectedContraceptives: json['selectedContraceptives'] ?? [],
      selectedNotes: json['selectedNotes'] ?? [],
      selectedDates: json['selectedDates'] ?? [],
    );
  }

  // Create a method to convert a UserDataModel to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'selectedSymptoms': selectedSymptoms,
      'selectedMood': selectedMood,
      'selectedSex': selectedSex,
      'selectedDischarge': selectedDischarge,
      'selectedContraceptives': selectedContraceptives,
      'selectedNotes': selectedNotes,
      'selectedDates': selectedDates,
    };
  }
}
