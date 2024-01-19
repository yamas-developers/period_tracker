import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:period_tracker/widgets/build_slide_transition.dart';
import 'package:vertical_picker/vertical_picker.dart';

import '../routes/session_manager.dart';
import '../utils/constants.dart';
import '../widgets/back_arrow_button.dart';
import '../widgets/custom_app_button.dart';
import 'mensaturation_periods.dart';
import 'components/numberPicker.dart';

class DateOfBith extends StatefulWidget {
  @override
  State<DateOfBith> createState() => _DateOfBithState();
}

class _DateOfBithState extends State<DateOfBith> {
  int? dob;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp)async{
      dob=2003;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 20,
          ),
          const BackArrowButton(),
          // Animated Moving Image
          BuildSlideTransition(
            child: Lottie.asset(
              'assets/animations/birthdate.json',
              height: 280.0,
              repeat: true,
              reverse: true,
              animate: true,
            ),
          ),
          SizedBox(height: 24.0),
          // Text Widget
          Center(
            child: Text(
              ' Set your birth date',
              style: TextStyle(fontSize: 20.0),
            ),
          ),

          SizedBox(
            height: 6,
          ),

          Center(
            child: DobPicker(
                startNumber: 6,
                onSelectionChange: (int number) {
                  dob=number;
                  print('MK: birth year: $dob');
                }),
          ),
          Spacer(),

          CustomAppButton(
            onTap: () {
              SessionManager sessionManager=SessionManager();
              sessionManager.storeString("dob", dob.toString());
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MensaturationPeriods()));
            },
            title: 'NEXT',
          ),

          SizedBox(
            height: 16,
          )
          // Date Selector
        ],
      ),
    );
  }
}
