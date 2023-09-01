import 'package:flutter/material.dart';
import 'package:period_tracker/providers/app_data_provider.dart';
import 'package:provider/provider.dart';

import '../../../utils/constants.dart';
import '../../../widgets/custom_text_field.dart';
class NotificationLateScreen extends StatefulWidget {
  const NotificationLateScreen({Key? key}) : super(key: key);

  @override
  State<NotificationLateScreen> createState() => _NotificationLateScreenState();
}

class _NotificationLateScreenState extends State<NotificationLateScreen> {
  bool metricSystem = false;
  bool isLateOn=false;
  final reminderTextController=TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                  "Late",
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
                      isLateOn=value;
                    });
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
                              appDataProvider.selectTime(context);
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
