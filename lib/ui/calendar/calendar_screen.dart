import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../custom_calendar.dart';
import '../../dates_provider.dart';
import '../../utils/constants.dart';
import '../../utils/public_methods.dart';
import '../../widgets/calendar_controller.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({
    super.key,
  });

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<DatesProvider>().predict();
      showModalSheet(context: context, day: DateTime.now());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: mainColorLight,
      ),
      body: ScrollableCleanCalendar(
        calendarController: CleanCalendarController(
          minDate: DateTime.now().subtract(Duration(days: 90)),
          maxDate: DateTime.now().add(const Duration(days: 365)),
          onRangeSelected: (firstDate, secondDate) {},
          onDayTapped: (date) {},
          // readOnly: true,
          onPreviousMinDateTapped: (date) {},
          onAfterMaxDateTapped: (date) {},
          weekdayStart: DateTime.sunday,
          // initialFocusDate: DateTime(2023, 5),
          // initialDateSelected: DateTime(2022, 3, 15),
          // endDateSelected: DateTime(2022, 3, 20),
        ),
        monthTextStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
        weekdayTextStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        layout: Layout.BEAUTY,
        calendarCrossAxisSpacing: 0,
        dayRadius: 30,
      ),
      floatingActionButton:
          Consumer<DatesProvider>(builder: (context, datesProvider, _) {
        return FloatingActionButton(
          onPressed: () {
            datesProvider.editMode = !datesProvider.editMode;
            if (!datesProvider.editMode) {
              datesProvider.predict();
            }
          },
          backgroundColor: datesProvider.editMode ? mainColor : accentColor,
          foregroundColor: Colors.white,
          tooltip: 'Edit Mode For the Cycles',
          child: Icon(datesProvider.editMode ? Icons.check : Icons.edit),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        );
      }), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
