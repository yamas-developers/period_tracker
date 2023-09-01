import 'package:flutter/material.dart';

import '../../../utils/constants.dart';
class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: accentColor,
        elevation: 0,
        title: Text(
          "Notifications",
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
      body: Column(
        children: [
          SizedBox(height: 20,),
          GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, "notificationPeriodScreen");
            },
            child: ListTile(
              title:  Text(
                "Period",
                style: TextStyle(
                  color: fontColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 17
                ),
              ),
              subtitle:  Text(
                "On",
                style: TextStyle(
                    color: fontLightColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 15
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, "notificationLateScreen");
            },
            child: ListTile(
              title:  Text(
                "Late",
                style: TextStyle(
                  color: fontColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 17
                ),
              ),
              subtitle:  Text(
                "On",
                style: TextStyle(
                    color: fontLightColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 15
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, "notificationEndOfPeriodsScreen");
            },
            child: ListTile(
              title:  Text(
                "End of periods",
                style: TextStyle(
                    color: fontColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 17
                ),
              ),
              subtitle:  Text(
                "On",
                style: TextStyle(
                    color: fontLightColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 15
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, "notificationOvulationScreen");
            },
            child: ListTile(
              title:  Text(
                "Ovolution",
                style: TextStyle(
                    color: fontColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 17
                ),
              ),
              subtitle:  Text(
                "On",
                style: TextStyle(
                    color: fontLightColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 15
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, "notificationContraceptionScreen");
            },
            child: ListTile(
              title:  Text(
                "Contraception",
                style: TextStyle(
                    color: fontColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 17
                ),
              ),
              subtitle:  Text(
                "On",
                style: TextStyle(
                    color: fontLightColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 15
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
