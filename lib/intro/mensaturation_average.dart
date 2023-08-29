import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:vertical_picker/vertical_picker.dart';

import '../utils/constants.dart';
import '../widgets/back_arrow_button.dart';
import '../widgets/build_slide_transition.dart';
import '../widgets/custom_app_button.dart';
import 'bithdate.dart';
import 'components/numberPicker.dart';

class MensaturationDays extends StatelessWidget {
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
                'assets/animations/run.json',
                height: 300.0,
                repeat: true,
                reverse: true,
                animate: true,
              ),
            ),
          ),
          SizedBox(height: 0),
          // Text Widget
          Transform.translate(
            offset: Offset(0, -20),
            child: Text(
              'How many days on average \n '
              'is your menstruation?',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: NumberPicker(
              min: 1,
              max: 12,
              onSelectionChange: (int number) {},
              startNumber: 5,
            ),
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => DateOfBith()));
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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DateOfBith()));
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
