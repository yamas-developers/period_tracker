import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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