import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:period_tracker/providers/app_data_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/profile/notification/oral_contraceptvies.dart';
import '../../../providers/user_data_provider.dart';
import '../../../routes/session_manager.dart';
import '../../../utils/constants.dart';
import '../../../utils/public_methods.dart';
import '../../../widgets/custom_text_field.dart';
class NotificationContraceptionScreen extends StatefulWidget {
  const NotificationContraceptionScreen({Key? key}) : super(key: key);

  @override
  State<NotificationContraceptionScreen> createState() => _NotificationContraceptionScreenState();
}

class _NotificationContraceptionScreenState extends State<NotificationContraceptionScreen> {
  bool metricSystem = false;
  bool isRepeatUntilOc = false;
  final oCReminderText=TextEditingController();
  final patchReminderText=TextEditingController();
  final iudReminderText=TextEditingController();
  final vRingReminderText=TextEditingController();
  final vRRingReminderText=TextEditingController();
  final injectionReminderText=TextEditingController();
  final implantReminderText=TextEditingController();
  final afterMenstruationReminderText=TextEditingController();
  final afterMensWireCheckReminderText=TextEditingController();
  final onceAYearWireCheckReminderText=TextEditingController();
  bool isContraceptionOn=false;
  String type = 'Oral contraceptives';
  String iudType = 'Not chosen';
  String periodOfUseYear = '1 year';
  String pillInPack="21";
  String injectionPillsInPack="4 weeks";
  String frequencyOfInjectionYear="1 years";
  String wireCheckType="No checks";
  String? selectedType;
  bool isOralContTrue=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp)async{
      final provider=Provider.of<AppDataProvider>(context, listen: false);
      final userDataProvider=Provider.of<UserDataProvider>(context, listen: false);
      DateTime currentTime = DateTime.now();
      String formattedTime = DateFormat('h:mm a').format(currentTime);
      provider.time=formattedTime;
      provider.startDate=currentTime;
      SessionManager sessionManager=SessionManager();
      metricSystem=userDataProvider.notContraception;
      isContraceptionOn=metricSystem;
      print("notContraception${userDataProvider.notContraception}");
      setState(() {});
      // if(isOralContTrue==true){
      //   SessionManager sessionManager=SessionManager();
      //   String? decodedData = await sessionManager.getData("OralContraceptive");
      //   if (decodedData != null) {
      //     final Map<String, dynamic> dataMap = jsonDecode(decodedData);
      //     if (dataMap['type'] == "Oral contraceptives") {
      //       setState(() {
      //         oCReminderText.text = dataMap['reminderText'];
      //         pillInPack = dataMap['pillsIPack'];
      //         provider.startDate = DateTime.parse(dataMap['pillStartDate']);
      //         isRepeatUntilOc = dataMap['repeatUntilOc'] == "true";
      //         if (dataMap['time'] != null) {
      //           provider.time = dataMap['time'];
      //         }
      //       });
      //     }
      //   }
      // }else{
      //   oCReminderText.text="Time to take a pill";
      //   pillInPack="28";
      //   isRepeatUntilOc=false;
      // }
      // setState(() {
      //   metricSystem=isOralContTrue;
      //   isContraceptionOn=metricSystem;
      // });
    });
  }
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      SessionManager _sessionManager=SessionManager();
      final appDataProvider=Provider.of<AppDataProvider>(context, listen: false);
      final userDataProvider=Provider.of<UserDataProvider>(context, listen: false);
      TimeOfDay selectedTime = TimeOfDay(hour: 12, minute: 0);
      String _time = selectedTime.format(context);
       if(type=="Oral contraceptives"){
         oCReminderText.text="Don't forget about this Patch";
         print("time$_time");
         appDataProvider.time=_time;
       }
       if(type=="Patch"){
         patchReminderText.text="Don't forget about this Patch";
         appDataProvider.time=_time;
       }
       if(type=="IUD"){
         iudType="Hormonal";
         // appDataProvider.time=userDataProvider.timeOfDay.toString();
         iudReminderText.text="Do not forget to replace your IUD";
         appDataProvider.time=_time;
         afterMenstruationReminderText.text="Do not forget about your Menstruation";
         onceAYearWireCheckReminderText.text="Do not forget about your Once A Year";
       }
       if(type=="Vaginal ring"){
         // appDataProvider.time=userDataProvider.timeOfDay.toString();
         appDataProvider.time=_time;
         appDataProvider.vRReminderTime=_time;
         vRingReminderText.text="Do not forget about the new ring";
         vRRingReminderText.text="Do not forget the ring";
       }
       if(type=="Injection"){
         // appDataProvider.time=userDataProvider.timeOfDay.toString();
         appDataProvider.time=_time;
         injectionReminderText.text="Do not forget to do your injection";
       }
       if(type=="Implant"){
         // appDataProvider.time=userDataProvider.timeOfDay.toString();
         appDataProvider.time=_time;
         implantReminderText.text="Do not forget to replace the implant";
       }
       // if(wireCheckType=="After menstruation"){
       //   afterMensWireCheckReminderText.text="Do not forget to check the wires";
       // }
       // if(wireCheckType=="Once a year"){
       //   onceAYearWireCheckReminderText.text="Do not forget to check the wires";
       // }
    });
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: accentColor,
        elevation: 0,
        title: Text(
          "Contraception",
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
          //            // isContraceptionOn
          //             //     ? Consumer<AppDataProvider>(
          //             //   builder: (context, appDataProvider, child) {
          //             //     return GestureDetector(
          //             //       onTap: () {
          //             //
          //             //       },
          //             //       child: const Padding(
          //             //         padding: EdgeInsets.only(top: 20, right: 15),
          //             //         child: Text(
          //             //           "Save",
          //             //           style: TextStyle(
          //             //             fontSize: 18,
          //             //             fontWeight: FontWeight.bold,
          //             //           ),
          //             //         ),
          //             //       ),
          //             //     );
          //             //   },
          //             // )
          //             //     : const SizedBox()        Navigator.pop(context);
        ],
      ),
      body: Consumer<AppDataProvider>(
        builder: (context, appDataProvider, child){
          SessionManager _sessionManager=SessionManager();
          return Consumer<UserDataProvider>(
            builder: (context, userDataProvider, child){
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Contraception",
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
                                isContraceptionOn=metricSystem;
                                userDataProvider.notContraception=value;
                              });
                              if(value==false){
                                userDataProvider.notLate=value;
                                SharedPreferences prefs = await SharedPreferences.getInstance();
                                prefs.remove("OralContraceptive");
                                setState(() {
                                    oCReminderText.text="Time to take a pill";
                                    pillInPack="28";
                                    // appDataProvider.time=userDataProvider.timeOfDay.toString();
                                    isRepeatUntilOc=false;
                                });
                              }
                            },
                            activeColor: accentColor,
                          ),
                        ],
                      ),
                      isContraceptionOn?
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 60,
                              child: DropdownButtonFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Type',
                                  hintText: 'Select item',
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.deepPurpleAccent, width: 2.0),
                                  ),
                                ),
                                value: type,
                                onChanged: (String? newValue) async{
                                  setState(() {
                                    type = newValue!;
                                    print("type$type");
                                  });
                                  // print("$iudType/$periodOfUseYear/${appDataProvider.startDate}"
                                  //     "/${wireCheckType}//${iudReminderText.text.toString()}"
                                  //     "/${appDataProvider.time}");


                                  if(type!="Oral contraceptives"){
                                    print("type!====$type");
                                    if(appDataProvider.time!=null&&
                                        oCReminderText.text.isNotEmpty&&
                                        pillInPack.isNotEmpty&&
                                        appDataProvider.startDate!=null&&
                                        isRepeatUntilOc!=false
                                    ){
                                      _sessionManager.storeData(
                                          "OralContraceptive",
                                          OralContraceptives(
                                              type: "Oral contraceptives",
                                              pillsIPack: pillInPack,
                                              pillStartDate: appDataProvider.startDate.toString(),
                                              reminderText: oCReminderText.text.toString(),
                                              repeatUntilOc: isRepeatUntilOc.toString(),
                                              time: appDataProvider.time
                                          )
                                      );
                                    }
                                  }
                                  if(type=="Oral contraceptives"){
                                    print("type=$type");
                                    SessionManager sessionManager=SessionManager();
                                    String? decodedData = await sessionManager.getData("OralContraceptive");
                                    print("decodedData$decodedData");
                                    if (decodedData != null) {
                                      final Map<String, dynamic> dataMap = jsonDecode(decodedData);
                                      if (dataMap['type'] == "Oral contraceptives") {
                                        setState(() {
                                          oCReminderText.text = dataMap['reminderText'];
                                          pillInPack = dataMap['pillsIPack'];
                                          appDataProvider.startDate = DateTime.parse(dataMap['pillStartDate']);
                                          isRepeatUntilOc = dataMap['repeatUntilOc'] == "true";
                                          if (dataMap['time'] != null) {
                                            appDataProvider.time = dataMap['time'];
                                          }
                                        });
                                      }
                                    }else{
                                      oCReminderText.text="Time to take a pill testing";
                                      pillInPack="28";
                                      DateTime currentTime = DateTime.now();
                                      String formattedTime = DateFormat('h:mm a').format(currentTime);
                                      appDataProvider.time=formattedTime;
                                      appDataProvider.startDate=currentTime;
                                      isRepeatUntilOc=false;
                                    }
                                  }
                                  if(type!="Patch"){
                                    print("type!====$type");
                                    if(appDataProvider.time==null&&
                                        patchReminderText.text.isEmpty&&
                                        appDataProvider.startDate==null
                                    ){
                                      toastMessage("Some fields required data");
                                    }else{
                                      _sessionManager.storeData(
                                          "Patch",
                                          Patch(
                                              type: "Patch",
                                              firstPatchDate: appDataProvider.startDate.toString(),
                                              reminderText: patchReminderText.text,
                                              time: appDataProvider.time
                                          )
                                      );
                                    }
                                  }
                                  if(type=="Patch"){
                                    print("type!====$type");
                                    SessionManager sessionManager=SessionManager();
                                    String? decodedData = await sessionManager.getData("Patch");
                                    if (decodedData != null) {
                                      print("decodedDataPatch$decodedData");
                                      final Map<String, dynamic> dataMap = jsonDecode(decodedData);
                                      if (dataMap['type'] == "Patch") {
                                        setState(() {
                                          patchReminderText.text = dataMap['reminderText'];
                                          appDataProvider.startDate = DateTime.parse(dataMap['firstPatchDate']);
                                          if (dataMap['time'] != null) {
                                            appDataProvider.time = dataMap['time'];
                                          }
                                        });
                                      }
                                    }
                                  }
                                  if(type!="IUD"){
                                    print("type!====$type");
                                    if(iudType.isEmpty&&
                                        periodOfUseYear.isEmpty&&
                                        appDataProvider.startDate!=null&&
                                        wireCheckType.isEmpty&&
                                        appDataProvider.time==null&&
                                        iudReminderText.text.isEmpty
                                    ){
                                      toastMessage("Some fields required data");
                                    }else{
                                      Map<String, dynamic> iudData = {
                                        'type': "IUD",
                                        'iudType': iudType,
                                        'periodOfUse': periodOfUseYear,
                                        'intrauterineInputDate': appDataProvider.startDate.toString(),
                                        'iudReminderText': iudReminderText.text.toString(),
                                        'iudReplacementTime': appDataProvider.time,
                                      };

                                      if (wireCheckType != "No checks" && wireCheckType != "Once a year") {
                                        iudData['wireCheck'] = AfterMenstruation(
                                          afterMenstruationReminderText: afterMenstruationReminderText.text,
                                          afterMenstruationReminderTime: appDataProvider.time,
                                        ).toJson();
                                      } else if (wireCheckType != "No checks" && wireCheckType != "After menstruation") {
                                        iudData['wireCheck'] = OnceAYear(
                                          onceAYearReminderText: onceAYearWireCheckReminderText.text,
                                          onceAYearReminderTime: appDataProvider.time,
                                        ).toJson();
                                      } else if (wireCheckType == "No check") {
                                        iudData['wireCheck'] = wireCheckType;
                                      }

                                      _sessionManager.storeData("IUD", iudData);
                                    }
                                  }
                                  if(type=="IUD"){
                                    print("type!====$type");
                                    SessionManager sessionManager=SessionManager();
                                    String? decodedData = await sessionManager.getData("IUD");
                                    if (decodedData != null) {
                                      final Map<String, dynamic> dataMap = jsonDecode(decodedData);
                                      if (dataMap['type'] == "IUD") {
                                        setState(() {
                                          print("iudDataMap$dataMap");
                                          IUD.fromJson(dataMap);
                                          // iudReminderText.text = dataMap['reminderText'];
                                          // periodOfUseYear = dataMap['periodOfUser'];
                                          // iudType=dataMap["iudType"];
                                          // appDataProvider.startDate = DateTime.parse(dataMap['intrauterineInput']);
                                          // wireCheckType=dataMap["wireCheck"];
                                          // if (dataMap['iudReplacementTime'] != null) {
                                          //   appDataProvider.time = dataMap['iudReplacementTime'];
                                          // }
                                        });
                                      }
                                    }
                                  }
                                  if(type!="Vaginal ring"){
                                    print("type!====$type");
                                    if(
                                    appDataProvider.startDate==null&&
                                        appDataProvider.time==null&&
                                        appDataProvider.time==null&&
                                        vRingReminderText.text.isEmpty&&
                                        vRRingReminderText.text.isEmpty
                                    ){
                                      toastMessage("Some fields required data");
                                    }else{
                                      _sessionManager.storeData(
                                          "VaginalRing",
                                          VaginalRing(
                                              type: "VaginalRing",
                                              packStartDate: appDataProvider.startDate.toString(),
                                              reminderTime: appDataProvider.time,
                                              reminderText: vRingReminderText.text,
                                              ringReminderTime: appDataProvider.vRReminderTime,
                                              ringReminderText: vRRingReminderText.text
                                          )
                                      );
                                    }
                                  }
                                  print("typ()()(()e$type");
                                  if(type=="Vaginal ring"){
                                    print("type!==______=$type");
                                    SessionManager sessionManager=SessionManager();
                                    String? decodedData = await sessionManager.getData("VaginalRing");
                                    print("decodedData!====$decodedData");
                                    if (decodedData != null) {
                                      final Map<String, dynamic> dataMap = jsonDecode(decodedData);
                                      if (dataMap['type'] == "VaginalRing") {
                                        print("map$dataMap");
                                        setState(() {
                                          VaginalRing.fromJson(dataMap);
                                          // iudReminderText.text = dataMap['iudReminderText'];
                                          // pillInPack = dataMap['pillsIPack'];
                                          // wireCheckType=dataMap[""];
                                          // appDataProvider.startDate = DateTime.parse(dataMap['intrauterineInputDate']);
                                          // isRepeatUntilOc = dataMap['repeatUntilOc'] == "true";
                                          // if (dataMap['ringReminderTime'] != null) {
                                          //   appDataProvider.vRReminderTime = dataMap['ringReminderTime'];
                                          // }
                                        });
                                      }
                                    }
                                  }
                                  if(type!="Injection"){
                                    print("type!====$type");
                                    if(
                                    appDataProvider.startDate!=null&&
                                        injectionPillsInPack.isEmpty&&
                                        appDataProvider.time==null&&//injectionTime
                                        injectionReminderText.text.isEmpty
                                    ){
                                      toastMessage("Some fields required data");
                                    }else{
                                      _sessionManager.storeData(
                                          "Injection",
                                          Injection(
                                              type: "Injection",
                                              pillInPack: injectionPillsInPack,
                                              injectionDate: appDataProvider.startDate.toString(),
                                              injectionReminderText: injectionReminderText.text.toString(),
                                              injectionTime:appDataProvider.time
                                          )
                                      );
                                    }
                                  }
                                  if(type=="Injection"){
                                    print("type!====$type");
                                    SessionManager sessionManager=SessionManager();
                                    String? decodedData = await sessionManager.getData("Injection");
                                    print("decodedDaya$decodedData");
                                    if (decodedData != null) {
                                      final Map<String, dynamic> dataMap = jsonDecode(decodedData);
                                      if (dataMap['type'] == "Injection") {
                                        setState(() {
                                          Injection.fromJson(dataMap);
                                          // injectionReminderText.text = dataMap['injectionReminderText'];
                                          // injectionPillsInPack = dataMap['pillInPack'];
                                          // appDataProvider.startDate = DateTime.parse(dataMap['injectionDate']);
                                          // if (dataMap['injectionTime'] != null) {
                                          //   appDataProvider.time = dataMap['injectionTime'];
                                          // }
                                        });
                                      }
                                    }
                                  }
                                  if(type!="Implant"){
                                    print("type!====$type");
                                    if(
                                    appDataProvider.startDate!=null&&
                                        frequencyOfInjectionYear.isEmpty&&
                                        appDataProvider.time==null&&//injectionTime
                                        implantReminderText.text.isEmpty
                                    ){
                                      toastMessage("Some fields required data");
                                    }else{
                                      _sessionManager.storeData(
                                          "Implant",
                                          Implant(
                                              type: "Implant",
                                              frequencyOfInjectionYear: frequencyOfInjectionYear,
                                              implantInsertionDate: appDataProvider.startDate.toString(),
                                              implantTime: implantReminderText.text.toString(),
                                              implantReminderText:appDataProvider.time
                                          )
                                      );
                                    }
                                  }
                                  if(type=="Implant"){
                                    print("type!====$type");
                                    SessionManager sessionManager=SessionManager();
                                    String? decodedData = await sessionManager.getData("Implant");
                                    if (decodedData != null) {
                                      final Map<String, dynamic> dataMap = jsonDecode(decodedData);
                                      if (dataMap['type'] == "Implant") {
                                        setState(() {
                                          Implant.fromJson(dataMap);
                                          // implantReminderText.text = dataMap['implantReminderText'];
                                          // frequencyOfInjectionYear = dataMap['frequencyOfInjection'];
                                          // appDataProvider.startDate = DateTime.parse(dataMap['pillStartDate']);
                                          // if (dataMap['ImplantTime'] != null) {
                                          //   appDataProvider.time = dataMap['ImplantTime'];
                                          // }
                                        });
                                      }
                                    }
                                  }


                                  if(type!="Oral contraceptives"||type=="Oral contraceptives"){
                                    print("typeOral$type");

                                  }
                                  if(type!="Patch"||type=="Patch"){
                                    print("type$type");

                                  }
                                  if(type!="IUD"||type=="IUD"){
                                    print("type$type");

                                  }
                                  if(type!="Vaginal ring"||type=="Vaginal ring"){
                                    print("type$type");

                                  }
                                  if(type!="Injection"||type=="Injection"){
                                    print("type$type");

                                  }
                                  if(type!="Implant"||type=="Implant"){
                                    print("type$type");

                                  }
                                },
                                items: [
                                  'Oral contraceptives',
                                  'Patch',
                                  'IUD',
                                  'Vaginal ring',
                                  'Injection',
                                  'Implant',
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                          GestureDetector(
                              onTap: () {
                                _sessionManager.storeData(
                                    "VaginalRing",
                                    VaginalRing(
                                        type: "VaginalRing",
                                        packStartDate: appDataProvider.startDate.toString(),
                                        reminderTime: appDataProvider.time,
                                        reminderText: vRingReminderText.text,
                                        ringReminderTime: appDataProvider.vRReminderTime,
                                        ringReminderText: vRRingReminderText.text
                                    )
                                );
                              },

                              child: Text("data", style: TextStyle(fontSize: 22),)),
                          SizedBox(height: 30),
                          type=="Oral contraceptives"?
                          Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                // height: 80,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Time',
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
                                  onTap: () async{
                                    await appDataProvider.selectTime(context, "oralContraceptives");
                                    print("time${appDataProvider.time}");
                                  },
                                  controller: TextEditingController(
                                    text: appDataProvider.time != null
                                        ? appDataProvider.time
                                        : '',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 30),
                                child: CustomTextField(
                                  reminderTextController: oCReminderText,
                                  hintText: "Reminder Text",
                                  textInputType: TextInputType.text,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 30),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 60,
                                  child: DropdownButtonFormField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Pills in Pack',
                                      hintText: 'Select item',
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.grey),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.deepPurpleAccent, width: 2.0),
                                      ),
                                    ),
                                    value: pillInPack,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        pillInPack = newValue!;
                                        print("type$pillInPack");
                                      });
                                    },
                                    items: [
                                      '21',
                                      '24',
                                      '28',
                                      '91'
                                    ].map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(top: 12),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Specify the number of tablets per pack of your oral\n"
                                            "contraceptives (OC). if there are 21, then app will\n"
                                            "take into account a 7-day period without taking pills.\n"
                                            "if 28 - notification will appear everyday",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: fontColor.withOpacity(0.5),
                                        ),
                                      )
                                    ],
                                  )
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 30),
                                child: GestureDetector(
                                  onTap: () {
                                    // selectTime(context);
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    // height: 80,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Pack start date',
                                        hintText: 'Select date',
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
                                      onTap: () async{
                                        await appDataProvider.selectDate(context);
                                        print("startDate${appDataProvider.startDate}");
                                      },
                                      controller: TextEditingController(
                                        text: appDataProvider.startDate != null
                                            ? appDataProvider.formatDate(appDataProvider.startDate!)
                                            : '',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(top: 12),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Indicate the date of the first pill from the package",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: fontColor.withOpacity(0.5),
                                        ),
                                      )
                                    ],
                                  )
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Repeat Until OC",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: fontColor,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Switch(
                                    value: isRepeatUntilOc,
                                    onChanged: (bool value) {
                                      setState(() {
                                        isRepeatUntilOc =value;
                                        print("isRepeatUntilOc$value");
                                        // isContraceptionOn=value;
                                      });
                                    },
                                    activeColor: accentColor,
                                  ),
                                ],
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(top: 4, bottom: 15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "If the setting is enabled, the application will send\n"
                                            "notification until you check the taking of the pills",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: fontColor.withOpacity(0.5),
                                        ),
                                      )
                                    ],
                                  )
                              ),
                            ],
                          ):const SizedBox(),
                          type=="Patch"?
                          Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  // selectTime(context);
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  // height: 80,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'First patch',
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
                                      appDataProvider.selectDate(context);
                                    },
                                    controller: TextEditingController(
                                      text: appDataProvider.startDate != null
                                          ? appDataProvider.formatDate(appDataProvider.startDate!)
                                          : '',
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(top: 12),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "In order for the application to select the correct dates\n"
                                            "to replace the patch. indicate when you started using\n"
                                            "the first patch from your current pack",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: fontColor.withOpacity(0.5),
                                        ),
                                      )
                                    ],
                                  )
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 30),
                                child: GestureDetector(
                                  onTap: () {
                                    // selectTime(context);
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    // height: 80,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Time',
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
                                        appDataProvider.selectTime(context, "patch");
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
                              Padding(
                                padding:const EdgeInsets.only(top: 30),
                                child: CustomTextField(
                                  reminderTextController: patchReminderText,
                                  hintText: "Reminder Text",
                                  textInputType: TextInputType.text,
                                ),
                              )
                            ],
                          ):const SizedBox(),
                          type=="IUD"?
                          Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 60,
                                child: DropdownButtonFormField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'IUD Type',
                                    hintText: 'Select type',
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.deepPurpleAccent, width: 2.0),
                                    ),
                                  ),
                                  value: iudType,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      iudType = newValue!;
                                      print("type$iudType");
                                    });
                                  },
                                  items: [
                                    'Not chosen',
                                    'Hormonal',
                                    'Copper-Containing'
                                  ].map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top:30),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 60,
                                  child: DropdownButtonFormField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Period of use',
                                      hintText: 'Select period',
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.grey),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.deepPurpleAccent, width: 2.0),
                                      ),
                                    ),
                                    value: periodOfUseYear,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        periodOfUseYear = newValue!;
                                        print("type$periodOfUseYear");
                                      });
                                    },
                                    items: [
                                      '1 year',
                                      '2 year',
                                      '3 year',
                                      '4 year',
                                      '5 year',
                                      '6 year',
                                      '7 year',
                                      '8 year',
                                      '9 year',
                                      '10 year'
                                    ].map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 30),
                                child: GestureDetector(
                                  onTap: () {
                                    // selectTime(context);
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    // height: 80,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Intrauterine input',
                                        hintText: 'Select intrauterine',
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
                                        appDataProvider.selectDate(context);
                                      },
                                      controller: TextEditingController(
                                        text: appDataProvider.startDate != null
                                            ? appDataProvider.formatDate(appDataProvider.startDate!)
                                            : '',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(top: 12),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "So that the application can select the correct dates\n"
                                            "for replacing the IUD and checking the antennae,\n"
                                            "indicate the date when you inserted the IUD",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: fontColor.withOpacity(0.5),
                                        ),
                                      )
                                    ],
                                  )
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top:30),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 60,
                                  child: DropdownButtonFormField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Wire Check',
                                      hintText: 'Select wire check',
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.grey),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.deepPurpleAccent, width: 2.0),
                                      ),
                                    ),
                                    value: wireCheckType,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        wireCheckType = newValue!;
                                        print("type$wireCheckType");
                                      });
                                    },
                                    items: [
                                      'No checks',
                                      'After menstruation',
                                      'Once a year'
                                    ].map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                              wireCheckType=="After menstruation"?
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 30),
                                    child: GestureDetector(
                                      onTap: () {
                                        // selectTime(context);
                                      },
                                      child: Container(
                                        width: MediaQuery.of(context).size.width,
                                        // height: 80,
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: 'Time',
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
                                            appDataProvider.selectTime(context, "iud");
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
                                  Padding(
                                    padding:const EdgeInsets.only(top: 30, bottom: 30),
                                    child: CustomTextField(
                                      reminderTextController: afterMensWireCheckReminderText,
                                      hintText: "Reminder Text",
                                      textInputType: TextInputType.text,
                                    ),
                                  )
                                ],
                              ):const SizedBox(),
                              wireCheckType=="Once a year"?
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 30),
                                    child: GestureDetector(
                                      onTap: () {
                                        // selectTime(context);
                                      },
                                      child: Container(
                                        width: MediaQuery.of(context).size.width,
                                        // height: 80,
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: 'Time',
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
                                  Padding(
                                    padding:const EdgeInsets.only(top: 30, bottom: 30),
                                    child: CustomTextField(
                                      reminderTextController: onceAYearWireCheckReminderText,
                                      hintText: "Reminder Text",
                                      textInputType: TextInputType.text,
                                    ),
                                  )
                                ],
                              ):const SizedBox(),
                              Padding(
                                  padding: const EdgeInsets.only(top: 12),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "IUD REPLACEMENT",
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: fontColor.withOpacity(0.5),
                                        ),
                                      )
                                    ],
                                  )
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 30),
                                child: GestureDetector(
                                  onTap: () {
                                    // selectTime(context);
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    // height: 80,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Time',
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
                                        appDataProvider.selectTime(context, "iudReplacementTime");
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
                              Padding(
                                padding:const EdgeInsets.only(top: 30, bottom: 50),
                                child: CustomTextField(
                                  reminderTextController: iudReminderText,
                                  hintText: "Reminder Text",
                                  textInputType: TextInputType.text,
                                ),
                              )
                            ],
                          ):const SizedBox(),
                          type=="Vaginal ring"?
                          Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                // height: 80,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Pack start date',
                                    hintText: 'Select date',
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
                                    appDataProvider.selectDate(context);
                                  },
                                  controller: TextEditingController(
                                    text: appDataProvider.startDate != null
                                        ? appDataProvider.formatDate(appDataProvider.startDate!)
                                        : '',
                                  ),
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(top: 12),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "So the application can select the correct dates\n"
                                            "for inserting and removing the ring, indicate when\n"
                                            "your inserted your last ring",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: fontColor.withOpacity(0.5),
                                        ),
                                      )
                                    ],
                                  )
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child:Divider(
                                  color: fontColor.withOpacity(0.3),
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(top: 12),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "REMINDER TO ENTER A NEW RING",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: fontColor.withOpacity(0.5),
                                        ),
                                      )
                                    ],
                                  )
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 30),
                                child: GestureDetector(
                                  onTap: () {
                                    // selectTime(context);
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    // height: 80,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Time',
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
                              Padding(
                                padding:const EdgeInsets.only(top: 30, bottom: 30),
                                child: CustomTextField(
                                  reminderTextController: vRingReminderText,
                                  hintText: "Reminder Text",
                                  textInputType: TextInputType.text,
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "RING REMINDER",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: fontColor.withOpacity(0.5),
                                        ),
                                      )
                                    ],
                                  )
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 30, bottom: 10),
                                child: GestureDetector(
                                  onTap: () {
                                    // selectTime(context);
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    // height: 80,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Time',
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
                                        appDataProvider.selectTime(context, "vRRingReminderTime");
                                      },
                                      controller: TextEditingController(
                                        text: appDataProvider.vRReminderTime != null
                                            ? appDataProvider.vRReminderTime
                                            : '',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:const EdgeInsets.only(top: 30, bottom: 30),
                                child: CustomTextField(
                                  reminderTextController: vRRingReminderText,
                                  hintText: "Reminder Text",
                                  textInputType: TextInputType.text,
                                ),
                              ),
                            ],
                          ):const SizedBox(),
                          type=="Injection"?
                          Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 60,
                                child: DropdownButtonFormField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Pills in Pack',
                                    hintText: 'Select item',
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.deepPurpleAccent, width: 2.0),
                                    ),
                                  ),
                                  value: injectionPillsInPack,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      injectionPillsInPack = newValue!;
                                      print("type$injectionPillsInPack");
                                    });
                                  },
                                  items: [
                                    '4 weeks',
                                    '5 weeks',
                                    '6 weeks',
                                    '7 weeks',
                                    '8 weeks',
                                    '9 weeks',
                                    '10 weeks',
                                    '11 weeks',
                                    '12 weeks',
                                    '13 weeks'
                                  ].map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(top: 12),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Indicate the number of weeks between injections",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: fontColor.withOpacity(0.5),
                                        ),
                                      )
                                    ],
                                  )
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 30),
                                child: GestureDetector(
                                  onTap: () {
                                    // selectTime(context);
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    // height: 80,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Injection date',
                                        hintText: 'Select date',
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
                                        appDataProvider.selectDate(context);
                                      },
                                      controller: TextEditingController(
                                        text: appDataProvider.startDate != null
                                            ? appDataProvider.formatDate(appDataProvider.startDate!)
                                            : '',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(top: 12),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "So that the application can choose the correct dates\n"
                                            "for the next generation, indicates when your last\ninjection was done",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: fontColor.withOpacity(0.5),
                                        ),
                                      )
                                    ],
                                  )
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 30),
                                child: GestureDetector(
                                  onTap: () {
                                    // selectTime(context);
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    // height: 80,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Time',
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
                                        appDataProvider.selectTime(context, "injection");
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
                              Padding(
                                padding:const EdgeInsets.only(top: 30,),
                                child: CustomTextField(
                                  reminderTextController: injectionReminderText,
                                  hintText: "Reminder Text",
                                  textInputType: TextInputType.text,
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(top: 12),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "A reminder will come a week before the injection, as\n"
                                            "well as on the day of the injection",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: fontColor.withOpacity(0.5),
                                        ),
                                      )
                                    ],
                                  )
                              ),
                            ],
                          ):const SizedBox(),
                          type=="Implant"?
                          Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 60,
                                child: DropdownButtonFormField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Frequency of injections',
                                    hintText: 'Select frequency',
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.deepPurpleAccent, width: 2.0),
                                    ),
                                  ),
                                  value: frequencyOfInjectionYear,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      frequencyOfInjectionYear = newValue!;
                                      print("type$frequencyOfInjectionYear");
                                    });
                                  },
                                  items: [
                                    '1 years',
                                    '2 years',
                                    '3 years',
                                    '4 years',
                                    '5 years',
                                    '6 years',
                                    '7 years',
                                    '8 years',
                                    '9 years',
                                    '10 years'
                                  ].map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 30),
                                child: GestureDetector(
                                  onTap: () {
                                    // selectTime(context);
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    // height: 80,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Implant insertion',
                                        hintText: 'Select date',
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
                                        appDataProvider.selectDate(context);
                                      },
                                      controller: TextEditingController(
                                        text: appDataProvider.startDate != null
                                            ? appDataProvider.formatDate(appDataProvider.startDate!)
                                            : '',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(top: 12),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "To enable the application to select teh correct dates\n"
                                            "for implant replacement, indicate the date of entry",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: fontColor.withOpacity(0.5),
                                        ),
                                      )
                                    ],
                                  )
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 30),
                                child: GestureDetector(
                                  onTap: () {
                                    // selectTime(context);
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    // height: 80,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Time',
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
                                        appDataProvider.selectTime(context, "implant");
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
                              Padding(
                                padding:const EdgeInsets.only(top: 30,),
                                child: CustomTextField(
                                  reminderTextController: implantReminderText,
                                  hintText: "Reminder Text",
                                  textInputType: TextInputType.text,
                                ),
                              ),
                            ],
                          ):const SizedBox(),
                        ],
                      ):const SizedBox(),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
