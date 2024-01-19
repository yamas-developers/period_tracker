import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:period_tracker/utils/constants.dart';
import 'package:period_tracker/widgets/custom_app_button.dart';
import 'package:vertical_picker/vertical_picker.dart';

import '../routes/session_manager.dart';
import '../widgets/back_arrow_button.dart';
import '../widgets/build_slide_transition.dart';
import 'components/numberPicker.dart';
import 'mensaturation_average.dart';

class CyclingAverageDay extends StatelessWidget {
  int cyclingAverageDay=1;
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
            child: Transform.translate(
              offset: Offset(0, -40),
              child: Lottie.asset(
                'assets/animations/cycling.json',
                height: 280.0,
                repeat: true,
                reverse: true,
                animate: true,
              ),
            ),
          ),
          // Text Widget
          Transform.translate(
            offset: Offset(0, -20),
            child: Center(
              child: Text(
                'How many days on average\n'
                'is your cycle?',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          ),

          SizedBox(
            height: 20,
          ),

          Center(
            child: NumberPicker(
                min: 21,
                max: 56,
                onSelectionChange: (int number) {
                  cyclingAverageDay=number;
                  debugPrint("MA: SQLDatabase=>cyclingAverageNo$cyclingAverageDay");
                },
                startNumber: 1),
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MensaturationDays()));
                },
                child: Text(
                  "I DON'T REMEMBER",
                  style: TextStyle(fontSize: 14.2, color: accentColor),
                ),
              ),
            ],
          ),
          CustomAppButton(
            onTap: () {
              SessionManager sessionManager=SessionManager();
              sessionManager.storeString("cyclingAverageDays", cyclingAverageDay.toString());
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MensaturationDays()));
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
