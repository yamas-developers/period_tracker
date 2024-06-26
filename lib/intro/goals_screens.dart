import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:period_tracker/intro/last_period_screen.dart';
import 'package:period_tracker/widgets/back_arrow_button.dart';
import 'package:period_tracker/widgets/custom_app_button.dart';

import '../utils/constants.dart';
import 'circular_progress_indicator.dart';

class GoalsScreen extends StatefulWidget {
  @override
  State<GoalsScreen> createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<GoalsScreen> {
  String? type;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    final Map<String, dynamic>? data =
    ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (data != null) {
      type=data["type"];
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            // BackArrowButton(),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                'Choose a goal\n so that we can configure\n Clover for you',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  // color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            GoalWidget(
              title: 'Keep track of your cycle',
              subTitle: 'Track symptoms\n'
                  'and moods',
              animPath: 'assets/animations/track.json',
              iconOnLeft: false,
              type: type??"",
              onChoose: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LastPeriodScreen()));
              },
            ),
            GoalWidget(
              title: 'Monitor your health',
              subTitle: 'Track your well-being\n'
                  'throughout your cycle',
              animPath: 'assets/animations/doctor.json',
              iconOnLeft: true,
              type: "",
              onChoose: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LastPeriodScreen()));
              },
            ),
            GoalWidget(
              title: 'Get pregnant',
              subTitle: 'Track favorable days for conception',
              animPath: 'assets/animations/pregannt.json',
              type: "",
              iconOnLeft: false,
              onChoose: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LastPeriodScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class GoalWidget extends StatelessWidget {
  const GoalWidget({
    super.key,
    required this.title,
    required this.subTitle,
    required this.animPath,
    this.onChoose,
    this.iconOnLeft = true, this.type,
  });

  final String title;
  final String subTitle;
  final String animPath;
  final String? type;
  final dynamic onChoose;
  final bool iconOnLeft;

  @override
  Widget build(BuildContext context) {
    Widget icon = Lottie.asset(
      animPath,
      height: 140,
      repeat: true,
      reverse: true,
      animate: true,
      fit: BoxFit.fill,
    );
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 1,
                spreadRadius: 3)
          ]),
      margin: EdgeInsets.all(13.0),
      child: Row(
        children: [
          if (iconOnLeft)
            Padding(
              padding: const EdgeInsets.only(right: 18.0),
              child: icon,
            ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 6.0),
                  child: Text(
                    subTitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                SizedBox(
                  width: 110,
                  child: CustomAppButton(onTap: onChoose, title: 'CHOOSE', type: type,),
                ),
              ],
            ),
          ),
          if (!iconOnLeft) icon,
        ],
      ),
    );
  }
}
