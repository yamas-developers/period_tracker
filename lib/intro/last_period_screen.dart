import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:period_tracker/models/user_data.dart';
import 'package:period_tracker/routes/session_manager.dart';
import 'package:period_tracker/utils/public_methods.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/constants.dart';
import '../widgets/back_arrow_button.dart';
import '../widgets/build_slide_transition.dart';
import '../widgets/custom_app_button.dart';
import 'cycling_avergage_day.dart';

class LastPeriodScreen extends StatefulWidget {
  @override
  _LastPeriodScreenState createState() => _LastPeriodScreenState();
}

class _LastPeriodScreenState extends State<LastPeriodScreen> {
  DateTime? selectedDate;
  FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: greyBgColor,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 10.0, left: 16, right: 16, bottom: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // const BackArrowButton(),
              BuildSlideTransition(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 40.0),
                  child: Lottie.asset(
                    'assets/animations/cal.json',
                    height: 200.0,
                    repeat: true,
                    reverse: true,
                    animate: true,
                  ),
                ),
              ),
              // Text Widget
              SizedBox(
                width: 300,
                child: Text(
                  'Choose day \n your last period started',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              SizedBox(height: getHeight(context) * 0.08),
              // Date Selector
              GestureDetector(
                onTap: () {
                  if (_focusNode.hasFocus) {
                    _focusNode.unfocus();
                  }
                },
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Select Date',
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: accentColor, width: 2.0)),
                    suffixIcon: Icon(Icons.arrow_drop_down_outlined),
                    border: OutlineInputBorder(),
                  ),
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime.now(),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        selectedDate = pickedDate;
                        debugPrint("MA: SQLDatabase=>Last Period Screen$selectedDate");
                      });
                    }
                  },
                  controller: TextEditingController(
                    text: DateFormat('MMMM dd')
                        .format(selectedDate ??= DateTime.now()),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Spacer(),
              CustomAppButton(
                  onTap: () async{
                    // print('MK: selected Date: = ${selectedDate}');
                    if (selectedDate == null) {
                      return;
                    }
                    SessionManager sessionManager=SessionManager();
                    sessionManager.storeString("date", selectedDate.toString());
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CyclingAverageDay()));
                  },
                  title: 'NEXT'),
            ],
          ),
        ),
      ),
    );
  }
}
