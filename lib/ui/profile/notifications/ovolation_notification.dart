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
class NotificationOvulationScreen extends StatefulWidget {
  const NotificationOvulationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationOvulationScreen> createState() =>
      _NotificationOvulationScreenState();
}

class _NotificationOvulationScreenState extends State<NotificationOvulationScreen> {
  String reminderDays = '1 day before';
  String? reminderTime;
  bool metricSystem = false;
  bool isOvulationOn=false;
  String? ovulationData;
  final reminderTextController=TextEditingController();
  String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  String? time;
  String _endTime = DateFormat("hh:mm a").format(
      DateTime.now().add(const Duration(hours: 2))).toString();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp)async{
      final provider=Provider.of<AppDataProvider>(context, listen: false);
      DateTime currentTime = DateTime.now();
      String formattedTime = DateFormat('h:mm a').format(currentTime);
      provider.time=formattedTime;
      getOvulationNotification();
    });
  }

  Future<void> getOvulationNotification() async {
    final provider = Provider.of<UserDataProvider>(context, listen: false);
    final appDataProvider = Provider.of<AppDataProvider>(context, listen: false);
    SessionManager _sessionManager=SessionManager();
    bool? data =await  _sessionManager.checkData("OvulationNotification");
    if(data==true){
      print("lateNoti$data");
      setState(() {
        isOvulationOn=true;
        metricSystem=true;
      });
      ovulationData=await  _sessionManager.getDataFromSP("OvulationNotification");
      if (ovulationData != null) {
        Map<String, dynamic> cyclesData = jsonDecode(ovulationData!);
        print("cycles$cyclesData");
        OvulationNotification periods = OvulationNotification.fromJson(cyclesData);
        print("cycles$periods");
        provider.ovulationNotification=periods;
        setState(() {
          metricSystem=true;
          reminderDays=provider.ovulationNotification.reminderDays??"";
          reminderTime=provider.ovulationNotification.reminderTime;
          reminderTextController.text=provider.ovulationNotification.reminderTextController??"";
        });
      }else{
        DateTime currentTime = DateTime.now();
        String formattedTime = DateFormat('h:mm a').format(currentTime);
        reminderTime=formattedTime;
        isOvulationOn=false;
        reminderDays = '1 day before';
        reminderTextController.clear();
        metricSystem=false;
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
          "Ovulation",
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
          isOvulationOn?
          Consumer<AppDataProvider>(
            builder: (context, appDataProvider, child){
              return Consumer<UserDataProvider>(
                builder: (context, userDatProvider, child){
                  return GestureDetector(
                    onTap: () {
                      if(reminderTextController.text.isEmpty||appDataProvider.time==null||reminderDays.isEmpty){
                        toastMessage("Please enter data");
                      }else{
                        print("$reminderDays/RT${appDataProvider.time}/RTEXT${reminderTextController.text}");
                        SessionManager _sessionManager=SessionManager();
                        _sessionManager.storeData(
                            "OvulationNotification",
                            OvulationNotification(
                                hasData: true,
                                reminderDays: reminderDays,
                                reminderTime: appDataProvider.time,
                                reminderTextController: reminderTextController.text
                            )
                        );
                        userDatProvider.notOvolution=true;
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
                  "Ovulation",
                  style: TextStyle(
                      fontSize: 18,
                      color: fontColor,
                      fontWeight: FontWeight.w400),
                ),
                Switch(
                  value: metricSystem,
                  onChanged: (bool value)async {
                    setState(() {
                      metricSystem = !metricSystem;
                      isOvulationOn=value;
                    });
                    if(value==false){
                      userDataProvider.notOvolution=value;
                      print("notOvolution${userDataProvider.notOvolution}/$value");
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      prefs.remove("OvulationNotification");
                      setState(() {
                        reminderTextController.clear();
                      });
                    }
                  },
                  activeColor: accentColor,
                ),
              ],
            ),
            isOvulationOn?Column(
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
