import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:period_tracker/providers/app_data_provider.dart';
import 'package:provider/provider.dart';

import '../../../utils/constants.dart';
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
  final injectionReminderText=TextEditingController();
  final implantReminderText=TextEditingController();
  bool isContraceptionOn=false;
  String type = 'Oral contraceptives';
  String iudType = 'Not chosen';
  String periodOfUseType = '1 year';
  String pillInPackType="21";
  String injectionType="4 weeks";
  String implantType="1 years";
  String wireCheckType="No checks";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final provider=Provider.of<AppDataProvider>(context, listen: false);
    DateTime currentTime = DateTime.now();
    String formattedTime = DateFormat('h:mm a').format(currentTime);
    provider.time=formattedTime;
    provider.startDate=currentTime;
  }
  @override
  Widget build(BuildContext context) {
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
      ),
      body: Consumer<AppDataProvider>(
        builder: (context, appDataProvider, child){
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
                        onChanged: (bool value) {
                          setState(() {
                            metricSystem = !metricSystem;
                            isContraceptionOn=value;
                          });
                        },
                        activeColor: accentColor,
                      ),
                    ],
                  ),
                  isContraceptionOn?Column(
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
                            onChanged: (String? newValue) {
                              setState(() {
                                type = newValue!;
                                print("type$type");
                              });
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
                      SizedBox(height: 30),
                      type=="Oral contraceptives"?
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
                                  appDataProvider.selectTime(context);
                                },
                                controller: TextEditingController(
                                  text: appDataProvider.time != null
                                      ? appDataProvider.time
                                      : '',
                                ),
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
                                value: pillInPackType,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    pillInPackType = newValue!;
                                    print("type$pillInPackType");
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
                                    isRepeatUntilOc = !isRepeatUntilOc;
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
                                    appDataProvider.selectTime(context);
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
                                value: periodOfUseType,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    periodOfUseType = newValue!;
                                    print("type$periodOfUseType");
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
                                    appDataProvider.selectTime(context);
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
                                    appDataProvider.selectTime(context);
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
                            padding: const EdgeInsets.only(top: 30, bottom: 30),
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
                                    appDataProvider.selectTime(context);
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
                              value: injectionType,
                              onChanged: (String? newValue) {
                                setState(() {
                                  injectionType = newValue!;
                                  print("type$injectionType");
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
                                    appDataProvider.selectTime(context);
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
                              value: implantType,
                              onChanged: (String? newValue) {
                                setState(() {
                                  implantType = newValue!;
                                  print("type$implantType");
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
                                    appDataProvider.selectTime(context);
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
      ),
    );
  }
}
