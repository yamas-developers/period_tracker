import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:period_tracker/models/profile/notification/notification.dart';
import 'package:period_tracker/providers/app_data_provider.dart';
import 'package:period_tracker/ui/profile/notifications/notifications_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../providers/user_data_provider.dart';
import '../../../routes/session_manager.dart';
import '../../../utils/constants.dart';
import '../../../utils/public_methods.dart';
import '../../../widgets/custom_text_field.dart';

class NotificationPeriodScreen extends StatefulWidget {
  const NotificationPeriodScreen({Key? key}) : super(key: key);

  @override
  State<NotificationPeriodScreen> createState() =>
      _NotificationPeriodScreenState();
}

class _NotificationPeriodScreenState extends State<NotificationPeriodScreen> {
  String reminderDays = '1 day before';
  String? reminderTime;
  bool metricSystem = false;
  bool isPeriodOn=false;
  final reminderTextController=TextEditingController();
  String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  String? time;
  String _endTime = DateFormat("hh:mm a").format(
      DateTime.now().add(const Duration(hours: 2))).toString();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{
      final provider=Provider.of<AppDataProvider>(context, listen: false);
      DateTime currentTime = DateTime.now();
      String formattedTime = DateFormat('h:mm a').format(currentTime);
      provider.time=formattedTime;
      getPeriodNotification();
      setState(() {
      });
    });
  }
  Future<void> getPeriodNotification() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    SessionManager _sessionManager=SessionManager();
    final provider = Provider.of<UserDataProvider>(context, listen: false);
    String? cyclesJson =await  _sessionManager.getDataFromSP("PeriodNotification");
    if (cyclesJson != null) {
      Map<String, dynamic> cyclesData = jsonDecode(cyclesJson);
      print("cycles$cyclesData");
      PeriodNotification periods = PeriodNotification.fromJson(cyclesData);
      print("cycles$periods");
      provider.notificationPeriod=periods;
      if(provider.notificationPeriod.hasData==true){
        setState(() {
          isPeriodOn=true;
          metricSystem=true;
          reminderDays=provider.notificationPeriod.reminderDays??"";
          reminderTime=provider.notificationPeriod.reminderTime;
          reminderTextController.text=provider.notificationPeriod.reminderTextController??"";
        });
      }else{
        reminderDays='1 day before';
        DateTime currentTime = DateTime.now();
        String formattedTime = DateFormat('h:mm a').format(currentTime);
        reminderTime=formattedTime;
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    final userDataProvider=Provider.of<UserDataProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: accentColor,
        elevation: 0,
        title: Text(
          "Period",
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
        actions: [
          isPeriodOn?
          Consumer<AppDataProvider>(
            builder: (context, appDataProvider, child){
              return Consumer<UserDataProvider>(
                builder: (context, userDataProvider, child){
                  return GestureDetector(
                    onTap: () {
                      if(reminderTextController.text.isEmpty||appDataProvider.time==null||reminderDays.isEmpty){
                        toastMessage("Please enter data");
                      }else{
                        print("$reminderDays/RT${appDataProvider.time}/RTEXT${reminderTextController.text}");
                        SessionManager _sessionManager=SessionManager();
                        _sessionManager.storeData(
                            "PeriodNotification",
                            PeriodNotification(
                                hasData: true,
                                reminderDays: reminderDays,
                                reminderTime: appDataProvider.time,
                                reminderTextController: reminderTextController.text
                            )
                        );
                        userDataProvider.notPeriod=true;
                        Navigator.pop(context);
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20, right: 15),
                      child: Text(
                        "Save",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ):
          const SizedBox()
        ],
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
                  "Period",
                  style: TextStyle(
                      fontSize: 18,
                      color: fontColor,
                      fontWeight: FontWeight.w400),
                ),
                Switch(
                  value: metricSystem,
                  onChanged: (bool value) async{
                    setState(() {
                      metricSystem = !metricSystem;
                      isPeriodOn=value;
                    });
                    if(value==false){
                      userDataProvider.notPeriod=value;
                      print(value);
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      prefs.remove("PeriodNotification");
                      setState(() {
                      });
                    }
                  },
                  activeColor: accentColor,
                ),
              ],
            ),
            isPeriodOn?Column(
              children: [
                Consumer<AppDataProvider>(
                  builder: (context, appDataProvider, child){
                    return Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Days Picker
                          Expanded(
                            flex: 1,
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.2,
                              height: 60,
                              child: DropdownButtonFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'How many days before',
                                  hintText: 'Select days',
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.deepPurpleAccent, width: 2.0),
                                  ),
                                ),
                                value: reminderDays,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    reminderDays = newValue!;
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
                          SizedBox(width: 15),
                          Expanded(
                            flex: 1,
                            child: GestureDetector(
                              onTap: () {
                                // selectTime(context);
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.2,
                                // height: 80,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Reminder Time',
                                    hintText: 'Select time',
                                    // labelStyle: TextStyle(
                                    //   color: Colors.deepPurpleAccent,
                                    // ),
                                    suffixIcon: Icon(Icons.arrow_drop_down),
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
                                    appDataProvider.selectTime(context, "");
                                  },
                                  controller: TextEditingController(
                                    text: appDataProvider.time != null
                                        ? appDataProvider.time
                                        : '',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 35),
                  child: CustomTextField(
                    reminderTextController: reminderTextController,
                    hintText: "Reminder Text",
                    textInputType: TextInputType.text,
                  ),
                )
              ],
            ):const SizedBox(),
          ],
        ),
      ),
    );
  }
}
