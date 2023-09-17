import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:period_tracker/models/user_data.dart';
import 'package:period_tracker/utils/public_methods.dart';
import 'package:period_tracker/widgets/build_slide_transition.dart';
import 'package:provider/provider.dart';

import '../providers/app_data_provider.dart';
import '../routes/session_manager.dart';
import '../utils/constants.dart';
import '../widgets/back_arrow_button.dart';
import '../widgets/custom_app_button.dart';
import 'circular_progress_indicator.dart';
import 'goals_screens.dart';

class MensaturationPeriods extends StatefulWidget {
  @override
  _MensaturationPeriodsState createState() => _MensaturationPeriodsState();
}

class _MensaturationPeriodsState extends State<MensaturationPeriods> {
  String reminderDays = '1 day before';
  TimeOfDay? reminderTime;
  String? selectedDate;
  String? cyclingAverageNo;
  String? menstruationDays;
  String? dob;
  String? remainderDays;
  String? remainderTime;

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: reminderTime ?? TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        reminderTime = pickedTime;
      });
    }
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp)async{
      setState(() {
        reminderTime=TimeOfDay.now();
      });
      print("reminderTime$reminderTime");
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 0,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const BackArrowButton(),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LodingScreen(),
                        ),
                      );
                    },
                    child: Text(
                      "LATER",
                      style: TextStyle(fontSize: 16, color: Colors.deepPurple),
                    ),
                  ),
                ],
              ),
            ),
            // Animated Moving Image
            BuildSlideTransition(
              child: Lottie.asset(
                'assets/animations/rem.json',
                height: 260.0,
                repeat: true,
                reverse: true,
                animate: true,
              ),
            ),
            SizedBox(height: 16.0),
            // Text Widget
            Center(
              child: Text(
                'How many days on average\n '
                'before your cycle \n '
                'do you want a reminder?',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            // Row with Days Picker and Time Picker
            Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Days Picker
                  Expanded(
                    flex: 1,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: DropdownButtonFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Days',
                          hintText: 'Select days',
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.deepPurpleAccent, width: 2.0),
                          ),
                        ),
                        value: reminderDays,
                        onChanged: (String? newValue) {
                          setState(() {
                            reminderDays = newValue!;
                          });
                        },
                        items: [
                          '1 day before',
                          '2 days before',
                          '3 days before',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  // Time Picker
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        _selectTime(context);
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.2,
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Time',
                            hintText: 'Select time',
                            suffixIcon: Icon(Icons.access_time),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.deepPurpleAccent, width: 2.0),
                            ),
                          ),
                          readOnly: true,
                          onTap: () {
                            _selectTime(context);
                          },
                          controller: TextEditingController(
                            text: reminderTime != null
                                ? '${reminderTime!.format(context)}'
                                : remainderTime,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            Consumer<AppDataProvider>(
              builder: (context, appDataProvider, child) {
                return CustomAppButton(
                  onTap: () async {

                    SessionManager sessionManager = SessionManager();
                    sessionManager.reminderDays(reminderDays.toString(), reminderTime.toString());
                    selectedDate = await sessionManager.getDataFromSP("date");
                    cyclingAverageNo = await sessionManager.getDataFromSP("cyclingAverageDays");
                    menstruationDays = await sessionManager.getDataFromSP("menstruationAverage");
                    dob = await sessionManager.getDataFromSP("dob");
                    remainderDays = await sessionManager.getDataFromSP("reminderDays");
                    remainderTime = await sessionManager.getDataFromSP("reminderTime");
                    if (selectedDate!.isNotEmpty &&
                        cyclingAverageNo!.isNotEmpty &&
                        menstruationDays!.isNotEmpty &&
                        dob!.isNotEmpty &&
                        remainderDays!.isNotEmpty &&
                        remainderTime!.isNotEmpty) {
                      appDataProvider.addUser(
                        UserData(
                            selectedDate: selectedDate!,
                            cyclingAverageNo: cyclingAverageNo!,
                            menstruationDays: menstruationDays!,
                            dob: dob!,
                            remainderDays: remainderDays!,
                            remainderTime: remainderTime!
                        ),
                        context
                      );
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LodingScreen(),
                      ),
                    );
                  },
                  title: 'NEXT',
                );
              },
            ),
            SizedBox(
              height: 16,
            )
          ],
        ),
      ),
    );
  }
}
