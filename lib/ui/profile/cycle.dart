import 'package:flutter/material.dart';

// import 'package:flutter_picker/picker.dart';
import 'package:period_tracker/utils/constants.dart';

import '../../widgets/picker.dart';

class CycleInputScreen extends StatefulWidget {
  const CycleInputScreen({Key? key}) : super(key: key);

  @override
  State<CycleInputScreen> createState() => _CycleInputScreenState();
}

class _CycleInputScreenState extends State<CycleInputScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cycle',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: accentColor,
        foregroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.close),
        ),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text('Cycle length'),
            subtitle: Text(
              '29 days',
              style: TextStyle(color: Colors.black54),
            ),
            onTap: () {
              showPickerNumber(context, 21, 56);
            },
          ),
          ListTile(
            title: Text('Periods length'),
            subtitle: Text(
              '5 days',
              style: TextStyle(color: Colors.black54),
            ),
            onTap: () {
              showPickerNumber(context, 1, 12);
            },
          ),
        ],
      ),
    );
  }

  showPickerNumber(BuildContext context, int begin, int end) {
    new Picker(
        adapter: NumberPickerAdapter(data: [
          NumberPickerColumn(
            begin: begin,
            end: end,
          ),
        ]),
        delimiter: [
          // PickerDelimiter(child: Container(
          //   width: 30.0,
          //   alignment: Alignment.center,
          //   child: Icon(Icons.more_vert),
          // ))
        ],
        textStyle: TextStyle(fontSize: 28, color: Colors.black),
        hideHeader: true,
        title: new Text("Periods length"),
        onConfirm: (Picker picker, List value) {
          print(value.toString());
          print(picker.getSelectedValues());
        },
        confirmText: 'OK',
        cancelText: 'Cancel', containerColor: Colors.white)
    .
    showDialog
    (
    context, backgroundColor: Colors.white
    );
  }
}
