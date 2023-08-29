import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:period_tracker/ui/self_care/weight_notification_screen.dart';
import 'package:period_tracker/utils/constants.dart';
import 'package:period_tracker/widgets/custom_app_button.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../utils/public_methods.dart';
import 'components/mycontainer.dart';

class WightGraphScreen extends StatefulWidget {
  @override
  State<WightGraphScreen> createState() => _WightGraphScreenState();
}

class _WightGraphScreenState extends State<WightGraphScreen> {
  DateTime? selectedDate;
  FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double chartHeight = screenHeight * 0.3;
    double chartWidth = screenWidth * 0.8;

    return Scaffold(
      appBar: buildAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              children: [
                sbh(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    WeightNotificationScreen()));
                      },
                      child: Container(
                        width: 34,
                        height: 34,
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset(
                          'assets/icons/alarm.png',
                          height: 23,
                          width: 23,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Text(
                      'Weight monitor',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.cancel,
                        size: 35,
                        color: Colors.grey[300],
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 120,
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    margin: EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      color: greyBgColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(bottom: 8.0),
                                child: Text(
                                  'Current Weight',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: fontLightColor,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 6.0),
                                    child: Text(
                                      '56 Kg',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 6.0),
                                    child: Text(
                                      '+4Kg',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Image.asset(
                          'assets/icons/weight_monitor.png',
                          height: 100.0,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 0, bottom: 10),
                      child: Text(
                        "Measurement per cycle",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 0, bottom: 16.0, top: 7),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Aug1 -  ',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: fontLightColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: 'Sep1',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: fontLightColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(18),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                DecoratedBox(
                                  decoration: BoxDecoration(
                                      color: fontLightColor,
                                      borderRadius: BorderRadius.circular(3.0)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4),
                                    child: InkWell(
                                      onTap: () {
                                        // Button 1 onPressed function
                                      },
                                      child: Icon(
                                        Icons.arrow_back_ios_rounded,
                                        size: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 12,
                                ),
                                DecoratedBox(
                                  decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(3.0)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4),
                                    child: InkWell(
                                      onTap: () {
                                        // Button 2 onPressed function
                                      },
                                      child: Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        size: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                /*Container(
                  height: chartHeight,
                  width: chartWidth,
                  child: SfCartesianChart(
                    primaryXAxis: CategoryAxis(
                      labelPlacement: LabelPlacement.onTicks,
                      labelStyle: TextStyle(fontSize: 12),
                    ),
                    primaryYAxis: NumericAxis(
                      labelStyle: TextStyle(fontSize: 12),
                      minimum: 52.5,
                      maximum: 55.5,
                      interval: 0.5,
                    ),
                    series: [
                      ColumnSeries(
                        dataSource: [
                          Entity(x: '8/4', y: 5.0),
                          Entity(x: '8/11', y: 0.0),
                          Entity(x: '8/18', y: 3.0),
                          Entity(x: '8/25', y: 0.0),
                        ],
                        xValueMapper: (Entity entity, _) => entity.x,
                        yValueMapper: (Entity entity, _) => entity.y,
                        pointColorMapper: (Entity entity, _) {
                          if (entity.x == '8/4') {
                            return Colors.red;
                          } else if (entity.x == '8/11') {
                            return Colors.blue;
                          } else {
                            return Colors.transparent;
                          }
                        },
                      ),
                    ],
                  ),
                )*/
                Container(
                  height: chartHeight,
                  width: chartWidth,
                  child: SfCartesianChart(
                    primaryXAxis: CategoryAxis(
                      labelPlacement: LabelPlacement.onTicks,
                      labelStyle: TextStyle(fontSize: 12),
                    ),
                    primaryYAxis: NumericAxis(
                      labelStyle: TextStyle(fontSize: 12),
                      minimum: 52.5,
                      maximum: 55.5,
                      interval: 0.5,
                    ),
                    series: [
                      ColumnSeries(
                        dataSource: [
                          Entity(x: '8/4', y: 53.2),
                          Entity(x: '8/11', y: 0),
                          Entity(x: '8/18', y: 53),
                          Entity(x: '8/25', y: 0),
                        ],
                        xValueMapper: (Entity entity, _) => entity.x,
                        yValueMapper: (Entity entity, _) => entity.y,
                        pointColorMapper: (Entity entity, _) {
                          if (entity.x == '8/4') {
                            return Colors.red;
                          } else if (entity.x == '8/18') {
                            return ovulationColor;
                          } else {
                            return Colors.transparent;
                          }
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    left: 110.0,
                  ),
                  child: Row(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 15,
                            height: 15,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.red,
                            ),
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            'Period',
                            style: TextStyle(
                              fontSize: 13,
                              color: fontColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Row(
                        children: [
                          Container(
                            width: 15,
                            height: 15,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: ovulationColor,
                            ),
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            'Ovulation',
                            style: TextStyle(
                              fontSize: 13,
                              color: fontColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "History",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                SizedBox(
                  height: 18,
                ),
                WeightTable(),
                sbh(100),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddWeightBottomSheet(context);
        },
        backgroundColor: accentColor,
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddWeightBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    Text(
                      'Add Weight',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                GestureDetector(
                  onTap: () {
                    if (_focusNode.hasFocus) {
                      _focusNode.unfocus();
                    }
                  },
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Select Date',
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: accentColor, width: 2.0)),
                      suffixIcon: Icon(Icons.arrow_drop_down_outlined),
                      border: OutlineInputBorder(),
                    ),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime.now(),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          selectedDate = pickedDate;
                        });
                      }
                    },
                    controller: TextEditingController(
                      text: DateFormat('MMMM dd')
                          .format(selectedDate ??= DateTime.now()),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Reminder Text',
                    hintText: '56',
                    suffixText: 'kg',
                  ),
                ),
                SizedBox(height: 16.0),
                CustomAppButton(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    title: 'Add')
              ],
            ),
          ),
        );
      },
    );
  }
}

class Entity {
  final String x;
  final double y;

  Entity({required this.x, required this.y});
}
