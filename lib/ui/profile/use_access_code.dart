import 'package:flutter/material.dart';

import '../../utils/constants.dart';
class UseAccessCodeScreen extends StatefulWidget {
  const UseAccessCodeScreen({Key? key}) : super(key: key);

  @override
  State<UseAccessCodeScreen> createState() => _UseAccessCodeScreenState();
}

class _UseAccessCodeScreenState extends State<UseAccessCodeScreen> {
  bool metricSystem = false;
  bool isAccessModeOn=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: accentColor,
        elevation: 0,
        title: Text(
          "Use access code",
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.clear_rounded,
            color: ovulationColor,
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Use access code",
                  style: TextStyle(
                      fontSize: 18,
                      color: fontColor,
                      fontWeight: FontWeight.w400),
                ),
                Switch(
                  value: metricSystem,
                  onChanged: (bool value) {
                    setState(() {
                      metricSystem = !metricSystem;
                      Navigator.pushNamed(context, "pinCodeScreen",arguments: {
                      "type":"profile"
                      });
                    });
                  },
                  activeColor: accentColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
