import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:period_tracker/utils/public_methods.dart';
import 'package:period_tracker/widgets/build_slide_transition.dart';

import '../utils/constants.dart';
import '../widgets/back_arrow_button.dart';
import '../widgets/custom_app_button.dart';
import 'goals_screens.dart';

class MensaturationPeriods extends StatefulWidget {
  @override
  _MensaturationPeriodsState createState() => _MensaturationPeriodsState();
}

class _MensaturationPeriodsState extends State<MensaturationPeriods> {
  String dropdownValue = '1 day before';
  TimeOfDay? selectedTime;

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        selectedTime = pickedTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 0,
      ),
      backgroundColor: Colors.white,
      body: Container(
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
                          builder: (context) => GoalsScreen(),
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
                        value: dropdownValue,
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValue = newValue!;
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
                            text: selectedTime != null
                                ? '${selectedTime!.format(context)}'
                                : '',
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            CustomAppButton(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GoalsScreen(),
                  ),
                );
              },
              title: 'NEXT',
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
