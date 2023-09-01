import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:period_tracker/providers/app_data_provider.dart';
import 'package:provider/provider.dart';

import '../../../utils/constants.dart';
import '../../../widgets/custom_text_field.dart';
class NotificationOvulationScreen extends StatefulWidget {
  const NotificationOvulationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationOvulationScreen> createState() =>
      _NotificationOvulationScreenState();
}

class _NotificationOvulationScreenState extends State<NotificationOvulationScreen> {
  String reminderDays = '1 day before';
  TimeOfDay? reminderTime;
  bool metricSystem = false;
  bool isOvulationOn=false;
  final reminderTextController=TextEditingController();
  String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  String? time;
  String _endTime = DateFormat("hh:mm a").format(
      DateTime.now().add(const Duration(hours: 2))).toString();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final provider=Provider.of<AppDataProvider>(context, listen: false);
    DateTime currentTime = DateTime.now();
    String formattedTime = DateFormat('h:mm a').format(currentTime);
    provider.time=formattedTime;
  }

  @override
  Widget build(BuildContext context) {

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
                  onChanged: (bool value) {
                    setState(() {
                      metricSystem = !metricSystem;
                      isOvulationOn=value;
                    });
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
