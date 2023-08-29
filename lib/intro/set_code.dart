import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:period_tracker/main.dart';
import 'package:period_tracker/widgets/custom_app_button.dart';
import 'package:vertical_picker/vertical_picker.dart';

import '../utils/constants.dart';
import '../utils/public_methods.dart';
import '../widgets/back_arrow_button.dart';
import 'code_screens.dart';
import 'components/numberPicker.dart';

class SetCode extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 14,
          ),
          BackArrowButton(),
          // Animated Moving Image
          Lottie.asset(
            'assets/animations/setcode.json',
            height: 200.0,
            repeat: true,
            reverse: true,
            animate: true,
          ),
          SizedBox(height: 30),
          // Text Widget
          Center(
              child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Text(
                  'Protect your app with access \ncode',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 14.0),
                Text(
                  'After enabling this option, the application can \n'
                  'only be opened with a code or fingerprint',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
          )),

          SizedBox(
            height: 10,
          ),
          Spacer(),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PinCodeScreen()));
              },
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3.0),
                    side: BorderSide(
                        color: accentColor,
                        width: 1.4), // Set the desired border radius
                  ),
                  backgroundColor: Colors.white),
              child: Text(
                'Set Code',
                style: TextStyle(color: accentColor, fontSize: 16),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          CustomAppButton(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              },
              title: 'Continue without Code'.toUpperCase()),
          SizedBox(
            height: 16,
          )
          // Date Selector
        ],
      ),
    );
  }


}
