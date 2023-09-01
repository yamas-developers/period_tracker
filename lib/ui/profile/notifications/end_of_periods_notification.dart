import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/app_data_provider.dart';
import '../../../utils/constants.dart';
import '../../../widgets/custom_text_field.dart';

class NotificationEndOfPeriodsScreen extends StatefulWidget {
  const NotificationEndOfPeriodsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationEndOfPeriodsScreen> createState() => _NotificationEndOfPeriodsScreenState();
}

class _NotificationEndOfPeriodsScreenState extends State<NotificationEndOfPeriodsScreen> {
  bool metricSystem = false;
  bool isEndOfPeriodsOn=false;
  final reminderTextController=TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                  onChanged: (bool value) {
                    setState(() {
                      metricSystem = !metricSystem;
                      isEndOfPeriodsOn=value;
                    });
                  },
                  activeColor: accentColor,
                ),
              ],
            ),
            isEndOfPeriodsOn?
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
