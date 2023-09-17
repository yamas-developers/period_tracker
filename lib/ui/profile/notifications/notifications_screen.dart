import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/profile/notification/notification.dart';
import '../../../providers/user_data_provider.dart';
import '../../../routes/session_manager.dart';
import '../../../utils/constants.dart';
class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool? isPeriodOn;
  bool? isLateOn;
  bool? endOfPeriodNotification;
  bool? isOvulationNotification;


  Future<void> getPeriodNotification() async {
    SessionManager _sessionManager=SessionManager();
    final provider = Provider.of<UserDataProvider>(context, listen: false);
    bool? periodNotification =await  _sessionManager.checkData("PeriodNotification");
    bool? lateNotification =await  _sessionManager.checkData("LateNotification");
    bool? endOfPNotification =await  _sessionManager.checkData("endOfPeriodsNotification");
    bool? ovulationNotification =await  _sessionManager.checkData("OvulationNotification");
    bool? oralContraceptionNotification =await  _sessionManager.checkData("OralContraceptive");
    print("NS=>lateNot$lateNotification/${provider.notLate}");
    print("NS=>pon$periodNotification/${provider.notPeriod}");
    print("NS=>endON$endOfPNotification/${provider.notEndOfPeriod}");
    print("NS=>oN$ovulationNotification/${provider.notOvolution}");
    print("NS=>oralContraception$oralContraceptionNotification/${provider.notContraception}");
    lateNotification==true?provider.notLate=true:provider.notLate=false;
    periodNotification==true?provider.notPeriod=true:provider.notPeriod=false;
    endOfPNotification==true?provider.notEndOfPeriod=true:provider.notEndOfPeriod=false;
    ovulationNotification==true?provider.notOvolution=true:provider.notOvolution=false;
    oralContraceptionNotification==true?provider.notContraception=true:provider.notContraception=false;
    setState(() {
    });
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp)async{
      final provider = Provider.of<UserDataProvider>(context, listen: false);
      // provider.notOvolution=false;
      // provider.notPeriod=false;
      // provider.notEndOfPeriod=false;
      // provider.notLate=false;
    });
    getPeriodNotification();
}
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
      body: Consumer<UserDataProvider>(
        builder: (context, userDataProvider, child){
          return Column(
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
                        // color: fontColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 17
                    ),
                  ),
                  subtitle:  Text(
                    userDataProvider.notPeriod==true?"On":"Off",
                    style: TextStyle(
                        // color: fontLightColor,
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
                        // color: fontColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 17
                    ),
                  ),
                  subtitle:  Text(
                    userDataProvider.notLate==true?"On":"Off",
                    style: TextStyle(
                        // color: fontLightColor,
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
                        // color: fontColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 17
                    ),
                  ),
                  subtitle:  Text(
                    userDataProvider.notEndOfPeriod==true?"On":"Off",
                    style: TextStyle(
                        // color: fontLightColor,
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
                        // color: fontColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 17
                    ),
                  ),
                  subtitle:  Text(
                    userDataProvider.notOvolution==true?"On":"Off",
                    style: TextStyle(
                        // color: fontLightColor,
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
                        // color: fontColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 17
                    ),
                  ),
                  subtitle:  Text(
                    userDataProvider.notContraception==true?"On":"Off",
                    style: TextStyle(
                        // color: fontLightColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 15
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
