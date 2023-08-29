import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart' as cupertino;

// import 'package:flutter_picker/picker.dart';
import 'package:period_tracker/utils/constants.dart';

import '../../widgets/picker.dart';

class BirthInputScreen extends StatefulWidget {
  const BirthInputScreen({Key? key}) : super(key: key);


  @override
  State<BirthInputScreen> createState() => _BirthInputScreenState();
}

class _BirthInputScreenState extends State<BirthInputScreen> {
  final birth = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Year of Birth',
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
            title: Text('Year of Birth', style: TextStyle(
              fontSize: 18,fontWeight: FontWeight.w600
            ),),
            subtitle: SizedBox(
              height: 300,
              child: cupertino.CupertinoPicker(
                magnification: 1.5,
                backgroundColor: Colors.transparent,
                squeeze: 1,
                children: <Widget>[
                  ...List.generate(
                    70,
                    (index) => Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Text(
                        "${1953 + index}",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ),
                  )
                ],
                itemExtent: 50,
                //height of each item
                looping: true,
                onSelectedItemChanged: (int index) {
                  // selectitem = index;
                },
              ),
            ),
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
            cancelText: 'Cancel',
            containerColor: Colors.white)
        .showDialog(context, backgroundColor: Colors.white);
  }
}
