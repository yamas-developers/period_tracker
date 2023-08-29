class DayValues {
  /// The current day in layout
  final DateTime day;

  /// The text (day)
  final String text;

  /// If the item is select or not
  final bool isSelected;
  final bool isFuturePeriod;
  final bool isFutureOvulation;
  final bool isOvulationDay;

  /// The first day in the row for each week
  final bool isFirstDayOfWeek;

  /// The last day in the row for each week, but just the item seven
  final bool isLastDayOfWeek;

  /// The min date selected
  /// If [rangeMode] is false the rangeMinDate is the date selected (don't use [rangeMaxDate])
  final bool isLastPeriodDay;

  /// The max date selected
  final bool isFirstPeriodDay;

  /// The min date
  final DateTime minDate;

  /// The max date
  final DateTime maxDate;

  DayValues({
    required this.day,
    required this.text,
    required this.isSelected,
    required this.isFuturePeriod,
    required this.isFutureOvulation,
    required this.isOvulationDay,
    required this.isFirstDayOfWeek,
    required this.isLastDayOfWeek,
    required this.isLastPeriodDay,
    required this.isFirstPeriodDay,
    required this.minDate,
    required this.maxDate,
  });
}
