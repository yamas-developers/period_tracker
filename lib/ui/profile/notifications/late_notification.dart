import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:period_tracker/models/profile/notification/notification.dart';
import 'package:period_tracker/providers/app_data_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../providers/user_data_provider.dart';
import '../../../routes/session_manager.dart';
import '../../../utils/constants.dart';
import '../../../utils/public_methods.dart';
import '../../../widgets/custom_text_field.dart';
import 'notifications_screen.dart';
class NotificationLateScreen extends StatefulWidget {
  const NotificationLateScreen({Key? key}) : super(key: key);

  @override
  State<NotificationLateScreen> createState() => _NotificationLateScreenState();
}

class _NotificationLateScreenState extends State<NotificationLateScreen> {
  bool metricSystem = false;
  bool isLateOn=false;
  String? reminderTime;
  String? cyclesJson;
  final reminderTextController=TextEditingController();
  Future<void> getLateNotification() async {
    final provider = Provider.of<UserDataProvider>(context, listen: false);
    final appDataProvider = Provider.of<AppDataProvider>(context, listen: false);
    SessionManager _sessionManager=SessionManager();
    bool? data =await  _sessionManager.checkData("LateNotification");
    if(data==true){
      print("lateNoti$data");
      setState(() {
        isLateOn=true;
        metricSystem=true;
      });
       cyclesJson=await  _sessionManager.getDataFromSP("LateNotification");
      if (cyclesJson != null) {
        Map<String, dynamic> cyclesData = jsonDecode(cyclesJson!);
        print("cycles$cyclesData");
        LateNotification periods = LateNotification.fromJson(cyclesData);
        print("cycles$periods");
        provider.lateNotification=periods;
        setState(() {
          appDataProvider.time=provider.lateNotification.reminderTime;
          reminderTextController.text=provider.lateNotification.reminderTextController??"";
        });
    }else{
        DateTime currentTime = DateTime.now();
        String formattedTime = DateFormat('h:mm a').format(currentTime);
        reminderTime=formattedTime;
      isLateOn=false;
      metricSystem=false;
    }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp)async{
      getLateNotification();
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
          "Late",
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.clear_rounded,
            color: ovulationColor,
            size: 30,
          ),
          onPressed: () {
            // Navigator.of(context).popUntil((route) {
            //   return route.settings.name == 'notificationScreen';
            // });
            Navigator.pop(context);          },
        ),
        actions: [
          isLateOn?
          Consumer<AppDataProvider>(
            builder: (context, appDataProvider, child){
              return Consumer<UserDataProvider>(
                builder: (context, userDataProvider, child){
                  return GestureDetector(
                    onTap: () {
                      if(reminderTextController.text.isEmpty||appDataProvider.time==null){
                        toastMessage("Please enter data");
                      }else{
                        print("RT${appDataProvider.time}/RTEXT${reminderTextController.text}");
                        SessionManager _sessionManager=SessionManager();
                        _sessionManager.storeData(
                            "LateNotification",
                            LateNotification(
                                hasData: true,
                                reminderTime: appDataProvider.time,
                                reminderTextController: reminderTextController.text
                            )
                        );
                        userDataProvider.notLate=true;
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
                  "Late",
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
                      isLateOn=value;
                    });
                    if(value==false){
                      userDataProvider.notLate=value;
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      prefs.remove("LateNotification");
                      setState(() {
                        reminderTextController.clear();
                      });
                    }
                  },
                  activeColor: accentColor,
                ),
              ],
            ),
            isLateOn?
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Consumer<AppDataProvider>(
                    builder: (context, appDataProvider, child){
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
            ):const SizedBox()
          ],
        ),
      ),
    );
  }
}
