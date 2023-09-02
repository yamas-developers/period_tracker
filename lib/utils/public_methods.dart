import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:period_tracker/dates_provider.dart';
import 'package:provider/provider.dart';

import '../providers/feeling_provider.dart';
import '../ui/feeling/feeling_sheet.dart';
import '../widgets/misc_widgets.dart';
import 'constants.dart';
double getWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double getHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}
void toastMessage(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      backgroundColor: fontLightColor,
      textColor: bgColor,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1);
}
showModalSheet({required BuildContext context, required DateTime day}) {
  showModalBottomSheet(
    enableDrag: true,
    isScrollControlled: true,
    isDismissible: true,
    useSafeArea: true,
    context: context,
    builder: (context) {
      return BottomSheetWidget(
        day: day,
      );
    },
  );
}

Widget sbw(double w) {
  return SizedBox(
    width: w,
  );
}

Widget sbh(double h) {
  return SizedBox(
    height: h,
  );
}

AppBar buildAppBar() {
  return AppBar(
    backgroundColor: Colors.grey.withOpacity(0.2),
    elevation: 0,
    toolbarHeight: 0,
  );
}