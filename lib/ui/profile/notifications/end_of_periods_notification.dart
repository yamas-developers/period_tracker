import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:period_tracker/models/profile/notification/notification.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../providers/app_data_provider.dart';
import '../../../providers/user_data_provider.dart';
import '../../../routes/session_manager.dart';
import '../../../utils/constants.dart';
import '../../../utils/public_methods.dart';
import '../../../widgets/custom_text_field.dart';

class NotificationEndOfPeriodsScreen extends StatefulWidget {
  const NotificationEndOfPeriodsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationEndOfPeriodsScreen> createState() =>
      _NotificationEndOfPeriodsScreenState();
}

class _NotificationEndOfPeriodsScreenState
    extends State<NotificationEndOfPeriodsScreen> {
  bool metricSystem = false;
  bool isEndOfPeriodsOn = false;
  String? reminderTime;
  final reminderTextController = TextEditingController();
  String? cyclesJson;

  Future<void> getEndOfPeriodNotification() async {
    final provider = Provider.of<UserDataProvider>(context, listen: false);
    final appDataProvider = Provider.of<AppDataProvider>(context, listen: false);
    SessionManager _sessionManager=SessionManager();
    bool? data =await  _sessionManager.checkData("endOfPeriodsNotification");
    print("data$data");
    if(data==true){
      print("lateNoti$data");
      setState(() {
        isEndOfPeriodsOn=true;
        metricSystem=true;
      });
      cyclesJson=await  _sessionManager.getDataFromSP("endOfPeriodsNotification");
      if (cyclesJson != null) {
        Map<String, dynamic> cyclesData = jsonDecode(cyclesJson!);
        print("cycles$cyclesData");
        EndOfPeriodsNotification periods = EndOfPeriodsNotification.fromJson(cyclesData);
        print("cycles$periods");
        provider.endOfPeriodsNotification=periods;
        setState(() {
          appDataProvider.time=provider.endOfPeriodsNotification.reminderTime;
          reminderTextController.text=provider.endOfPeriodsNotification.reminderTextController??"";
        });
      }else{
        DateTime currentTime = DateTime.now();
        String formattedTime = DateFormat('h:mm a').format(currentTime);
        reminderTime=formattedTime;
        isEndOfPeriodsOn=false;
        metricSystem=false;
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp)async{
      DateTime currentTime = DateTime.now();
      String formattedTime = DateFormat('h:mm a').format(currentTime);
      reminderTime = formattedTime;
      print("object");
      getEndOfPeriodNotification();
    });
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
          "End of periods",
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
          isEndOfPeriodsOn
              ? Consumer<AppDataProvider>(
                  builder: (context, appDataProvider, child) {
                    return Consumer<UserDataProvider>(
                      builder: (context, userDataProvider, child){
                        return GestureDetector(
                          onTap: () {
                            if (reminderTextController.text.isEmpty ||
                                reminderTime==null) {
                              toastMessage("Please enter data");
                            } else {
                              print(
                                  "RT${appDataProvider.time}/RTEXT${reminderTextController.text}");
                              SessionManager _sessionManager = SessionManager();
                              _sessionManager.storeData(
                                  "endOfPeriodsNotification",
                                  EndOfPeriodsNotification(
                                      hasData: true,
                                      reminderTime: reminderTime??appDataProvider.time,
                                      reminderTextController:
                                      reminderTextController.text));
                              userDataProvider.notEndOfPeriod=true;
                              // Navigator.popUntil(context, (route) => route.isFirst);
                              Navigator.pop(context);
                            }
                          },
                          child: const Padding(
                            padding: EdgeInsets.only(top: 20, right: 15),
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
                )
              : const SizedBox()
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
                  "End of periods",
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
                      isEndOfPeriodsOn = value;
                    });
                    if(value==false){
                      userDataProvider.notEndOfPeriod=value;
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
            isEndOfPeriodsOn
                ? Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Consumer<AppDataProvider>(
                          builder: (context, appDataProvider, child) {
                            return GestureDetector(
                              onTap: () {
                                // selectTime(context);
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
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
                                      borderSide:
                                          BorderSide(color: Colors.grey),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.deepPurpleAccent,
                                          width: 2.0),
                                    ),
                                  ),
                                  readOnly: true,
                                  onTap: () {
                                    appDataProvider.selectTime(context, "");
                                  },
                                  controller: TextEditingController(
                                    text: appDataProvider.time ?? reminderTime,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 32),
                        child: CustomTextField(
                          reminderTextController: reminderTextController,
                          hintText: "Reminder Text",
                          textInputType: TextInputType.text,
                          maxLines: 1,
                        ),
                      )
                    ],
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}
