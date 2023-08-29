import 'package:flutter/material.dart';
import 'package:period_tracker/utils/constants.dart';

class WeightNotificationScreen extends StatefulWidget {
  @override
  _WeightNotificationScreenState createState() =>
      _WeightNotificationScreenState();
}

class _WeightNotificationScreenState extends State<WeightNotificationScreen> {
  bool isSwitched = true;
  List<bool> selectedDays = [false, false, false, false, false, false, false];
  TimeOfDay? selectedTime;
  TextEditingController controller =
      TextEditingController(text: 'Time to measure your weight');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.close)),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SwitchListTile(
              title: Text('Weight Monitor'),
              activeColor: accentColor,
              value: isSwitched,
              onChanged: (value) {
                setState(() {
                  isSwitched = value;
                });
              },
            ),
            SizedBox(height: 16.0),
            Text(
              'How often',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(7, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedDays[index] = !selectedDays[index];
                    });
                  },
                  child: Container(
                    width: 40.0,
                    height: 40.0,
                    decoration: BoxDecoration(
                      color: selectedDays[index] ? accentColor : greyBgColor,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        ['M', 'T', 'W', 'T', 'F', 'S', 'S'][index],
                        style: TextStyle(
                          color:
                              selectedDays[index] ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
            SizedBox(height: 20),
            Text(
              'Reminder',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      _selectTime(context);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Reminder Time',
                          hintText: 'Select Reminder Time',
                          suffixIcon: Icon(
                            Icons.arrow_drop_down_outlined,
                            color: Colors.black,
                          ),
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
                          _selectTime(context);
                        },
                        controller: TextEditingController(
                          text: selectedTime != null
                              ? '${selectedTime!.format(context)}'
                              : '',
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Reminder Text',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        selectedTime = pickedTime;
      });
    }
  }
}
