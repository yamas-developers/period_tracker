import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:period_tracker/routes/session_manager.dart';

// import 'package:flutter_picker/picker.dart';
import 'package:period_tracker/utils/constants.dart';
import 'package:period_tracker/utils/public_methods.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/profile/cycles.dart';
import '../../providers/user_data_provider.dart';
import '../../widgets/picker.dart';

class CycleInputScreen extends StatefulWidget {
  const CycleInputScreen({Key? key}) : super(key: key);

  @override
  State<CycleInputScreen> createState() => _CycleInputScreenState();
}

class _CycleInputScreenState extends State<CycleInputScreen> {
  String? periods;
  String? cycles;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{
      getCycles();
      setState(() {
      });
    });
  }
  Future<void> getCycles() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    SessionManager _sessionManager=SessionManager();
    final provider = Provider.of<UserDataProvider>(context, listen: false);
    String? cyclesJson =await  _sessionManager.getDataFromSP("profileCyclesData");
    if (cyclesJson != null) {
      Map<String, dynamic> cyclesData = jsonDecode(cyclesJson);
      print("cycles$cyclesData");
      Cycles cycles = Cycles.fromJson(cyclesData);
      print("cycles$cycles");
      provider.cycles=cycles;
    }
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    periods="7";
    cycles="28";
    setState(() {

    });
    // final Map<String, dynamic>? data =
    // ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    // if (data != null) {
    //   type=data["type"];
    // }
  }
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
        actions: [
          GestureDetector(
            onTap: () {
              if(cycles==null){
                toastMessage("Please select cycles");
              }
              if(periods==null){
                toastMessage("Please select periods");
              }
              if(cycles!.isNotEmpty&&periods!.isNotEmpty){
                SessionManager _sessionManager=SessionManager();
                _sessionManager.storeProfileCycles(
                    Cycles(
                        cycles: cycles,
                        periods: periods,
                        hasData: "true"
                    )
                );
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
          ),
        ],
      ),
      body: Consumer<UserDataProvider>(
        builder: (context, userDataProvider, child){
          return Column(
            children: [
              ListTile(
                title: Text('Cycle length'),
                subtitle: Text(
                  '${userDataProvider.cycles.cycles??cycles} days',
                  style: TextStyle(color: Colors.black54),
                ),
                onTap: () {
                  showPickerNumber(context, 21, 56, "cycles");
                  // setState(() {
                    userDataProvider.cycles.cycles=cycles;
                  // });
                },
              ),
              ListTile(
                title: Text('Periods length'),
                subtitle: Text(
                  "${userDataProvider.cycles.periods??periods} days",
                  style: TextStyle(color: Colors.black54),
                ),
                onTap: () async{
                  await showPickerNumber(context, 1, 12, "periods");
                  // setState(() {
                    userDataProvider.cycles.periods=periods;
                    print("period${userDataProvider.cycles.periods}");
                  // });
                },
              ),
            ],
          );
        },
      ),
    );
  }

  showPickerNumber(BuildContext context, int begin, int end, String type) {
    List<int> selectedValues = [0];
    if(type=="cycles"){
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
          title: new Text("cycles length"),
          onConfirm: (Picker picker, List value) {
            // int selectedValue = picker.getSelectedValues()[0];
            print("cycles${value.toString()}");
            setState(() {
              cycles=picker.getSelectedValues()[0].toString();
            });
            print(picker.getSelectedValues());
          },
          confirmText: 'OK',
          cancelText: 'Cancel', containerColor: Colors.white).showDialog(context, backgroundColor: Colors.white);
    }if(type=="periods"){
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
            int selectedValue = value[0]+1;
            print("periods${value.toString()}");
            setState(() {
              periods=selectedValue.toString();
            });
            print(picker.getSelectedValues());
          },
          confirmText: 'OK',
          cancelText: 'Cancel', containerColor: Colors.white).showDialog(context, backgroundColor: Colors.white);
    }
  }
}
