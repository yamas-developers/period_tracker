import 'package:flutter/material.dart';
import 'package:period_tracker/dates_provider.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../utils/constants.dart';
import '../utils/public_methods.dart';
import 'calendar_controller.dart';
import 'day_values_model.dart';

class DaysWidget extends StatelessWidget {
  final CleanCalendarController cleanCalendarController;
  final DateTime month;
  final double calendarCrossAxisSpacing;
  final double calendarMainAxisSpacing;
  final Layout? layout;
  final Widget Function(
    BuildContext context,
    DayValues values,
  )? dayBuilder;
  final Color? selectedBackgroundColor;
  final Color? backgroundColor;
  final Color? disableBackgroundColor;
  final Color? dayDisableColor;
  final double radius;
  final TextStyle? textStyle;

  const DaysWidget({
    Key? key,
    required this.month,
    required this.cleanCalendarController,
    required this.calendarCrossAxisSpacing,
    required this.calendarMainAxisSpacing,
    required this.layout,
    required this.dayBuilder,
    required this.selectedBackgroundColor,
    required this.backgroundColor,
    required this.disableBackgroundColor,
    required this.dayDisableColor,
    required this.radius,
    required this.textStyle,
  }) : super(key: key);
  final bool inputMode = true;

  @override
  Widget build(BuildContext context) {
    // Start weekday - Days per week - The first weekday of this month
    // 7 - 7 - 1 = -1 = 1
    // 6 - 7 - 1 = -2 = 2

    // What it means? The first weekday does not change, but the start weekday have changed,
    // so in the layout we need to change where the calendar first day is going to start.
    int monthPositionStartDay = (cleanCalendarController.weekdayStart -
            DateTime.daysPerWeek -
            DateTime(month.year, month.month).weekday)
        .abs();
    monthPositionStartDay = monthPositionStartDay > DateTime.daysPerWeek
        ? monthPositionStartDay - DateTime.daysPerWeek
        : monthPositionStartDay;

    final start = monthPositionStartDay == 7 ? 0 : monthPositionStartDay;

    // If the monthPositionStartDay is equal to 7, then in this layout logic will cause a trouble, beacause it will
    // have a line in blank and in this case 7 is the same as 0.

    return Consumer<DatesProvider>(builder: (context, datesProvider, _) {
      return GridView.count(
        crossAxisCount: DateTime.daysPerWeek,
        physics: const NeverScrollableScrollPhysics(),
        addRepaintBoundaries: false,
        padding: EdgeInsets.zero,
        crossAxisSpacing: calendarCrossAxisSpacing,
        mainAxisSpacing: calendarMainAxisSpacing,
        shrinkWrap: true,
        children: List.generate(
            DateTime(month.year, month.month + 1, 0).day + start, (index) {
          if (index < start) return const SizedBox.shrink();
          final day = DateTime(month.year, month.month, (index + 1 - start));
          final text = (index + 1 - start).toString();

          bool isSelected = false;
          bool isFuturePeriod = false;
          bool isFutureOvulation = false;

          if (datesProvider.periods.contains(day)) {
            isSelected = true;
          } else if (datesProvider.futurePeriods.contains(day)) {
            isFuturePeriod = true;
          } else if (datesProvider.futureOvulations.contains(day)) {
            isFutureOvulation = true;
          }
          bool isLastPeriodDay = false;
          bool isFirstPeriodDay = false;

          if (isSelected && (!datesProvider.periods.contains(day.nextDay)) ||
              isFuturePeriod &&
                  (!datesProvider.futurePeriods.contains(day.nextDay)) ||
              (isFutureOvulation &&
                  !datesProvider.futureOvulations.contains(day.nextDay))) {
            isLastPeriodDay = true;
          }

          if ((isSelected &&
                  !datesProvider.periods
                      .contains(day.subtract(Duration(days: 1)))) ||
              (isFuturePeriod &&
                  !datesProvider.futurePeriods
                      .contains(day.subtract(Duration(days: 1)))) ||
              (isFutureOvulation &&
                  !datesProvider.futureOvulations
                      .contains(day.subtract(Duration(days: 1))))) {
            isFirstPeriodDay = true;
          }

          final dayValues = DayValues(
            day: day,
            isFirstDayOfWeek:
                day.weekday == cleanCalendarController.weekdayStart,
            isLastDayOfWeek: day.weekday == cleanCalendarController.weekdayEnd,
            isSelected: isSelected,
            isFuturePeriod: isFuturePeriod,
            isFutureOvulation: isFutureOvulation,
            isOvulationDay: datesProvider.ovulations
                .contains(day.subtract(Duration(days: 4))),
            maxDate: cleanCalendarController.maxDate,
            minDate: cleanCalendarController.minDate,
            text: text,
            isFirstPeriodDay: isFirstPeriodDay,
            isLastPeriodDay: isLastPeriodDay,
          );

          return _beauty(context, dayValues, datesProvider);
        }),
      );
    });
  }

  Widget _beauty(
      BuildContext context, DayValues values, DatesProvider datesProvider) {
    BorderRadiusGeometry? borderRadius;
    Color bgColor = Colors.transparent;
    Color fgColor = mainColorLight;
    Color fontColor = Theme.of(context).brightness != Brightness.light
        ? Colors.white
        : Colors.black;

    bool isDayInFuture = false;
    if (datesProvider.editMode) {
      isDayInFuture =
          values.day.isAfter(datesProvider.maxPeriodDay.add(Duration(days: 1)));
    }

    TextStyle txtStyle = Theme.of(context).textTheme.bodyLarge!.copyWith(
          color: values.isSelected ||
                  values.isFuturePeriod ||
                  values.isFutureOvulation
              ? (datesProvider.editMode || values.isFuturePeriod) &&
                      !values.isFutureOvulation
                  ? mainColor
                  : values.isFutureOvulation
                      ? values.isOvulationDay
                          ? datesProvider.editMode
                              ? Colors.blue
                              : Colors.white
                          : ovulationDayColor
                      : Colors.white
              : fontColor,
        );

    if (values.isSelected ||
        (!datesProvider.editMode && values.isFuturePeriod ||
            values.isFutureOvulation)) {
      if (values.isFutureOvulation) {
        fgColor = ovulationColor;
      } else {
        bgColor = mainColorLight;
        fgColor = Colors.white;
      }

      borderRadius = getBorderRadius(values, datesProvider);
    }
    /*else if (values.day.isSameDay(values.minDate)) {
    } else if (values.day.isBefore(values.minDate) ||
        values.day.isAfter(values.maxDate)) {
      txtStyle = (textStyle ?? Theme.of(context).textTheme.bodyLarge)!.copyWith(
        color: dayDisableColor ??
            Theme.of(context).colorScheme.onSurface.withOpacity(.5),
        decoration: TextDecoration.lineThrough,
        fontWeight: values.isFirstDayOfWeek || values.isLastDayOfWeek
            ? FontWeight.bold
            : null,
      );
    }*/
    BoxDecoration decoration = BoxDecoration(
      color: bgColor,
      borderRadius: borderRadius,
    );
    // if (values.isFuturePeriod) {
    //   decoration = BoxDecoration(
    //     // color: Colors.transparent,
    //     borderRadius: BorderRadius.circular(radius),
    //     // shape: BoxShape.rectangle,
    //     border: Border(
    //       right: BorderSide(
    //         color: Colors.black,
    //         width: 1.0,
    //       ),
    //     ),
    //     // border: getBorder(values, bgColor),
    //   );
    // }

    return
        // Padding(
        // padding: EdgeInsets.symmetric(
        //     vertical:
        //     !datesProvider.editMode && (values.isFuturePeriod || values.isFutureOvulation) ? 8.0 : 0),
        // child: Material(
        //   shape: datesProvider.editMode ? null : RoundedRectangleBorder(
        //       borderRadius: borderRadius ?? BorderRadius.zero,
        //       side: BorderSide(
        //         color: values.isOvulationDay ? Colors.orange : values.isFutureOvulation
        //             ? ovulationColor
        //             : values.isFuturePeriod
        //                 ? mainColor
        //                 : Colors.white,
        //         width: 0.5,
        //       )),
        //   child:
        GestureDetector(
      onTap: datesProvider.editMode
          ? null
          : () {
              showModalSheet(context: context, day: values.day);
            },
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(
            vertical: datesProvider.editMode || values.isFuturePeriod ? 1 : 6),
        decoration:
            datesProvider.editMode || values.isFuturePeriod ? null : decoration,
        child: Container(
          alignment: Alignment.center,
          // margin: EdgeInsets.symmetric(vertical: 0),
          decoration: values.isOvulationDay && !datesProvider.editMode
              ? BoxDecoration(
                  shape: BoxShape.circle,
                  // border: Border.all(color: accentColor)
                  color: ovulationBgColor)
              : null /*datesProvider.editMode || !values.isFuturePeriod
                ? null
                : decoration.copyWith(color: Theme.of(context).scaffoldBackgroundColor)*/
          ,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                values.text,
                textAlign: TextAlign.center,
                style: txtStyle,
              ),
              if (datesProvider.editMode) ...[
                if (isDayInFuture)
                  SizedBox(
                    height: 26,
                  )
                else
                  GestureDetector(
                    onTap: () {
                      datesProvider.addOrRemoveDays(values.day);
                    },
                    child: Container(
                      height: 26,
                      padding: EdgeInsets.symmetric(vertical: 6),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: borderRadius,
                      ),
                      child: Container(
                        // height: 10,
                        // width: 10,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: fgColor),
                        ),
                        child: values.isSelected
                            ? Icon(
                                Icons.check,
                                size: 12,
                                color: fgColor,
                              )
                            : null,
                      ),
                    ),
                  )
              ]
            ],
          ),
        ),
      ),
    )
        // ,
        // ),
        // )
        ;
  }

  BorderRadius getBorderRadius(DayValues values, DatesProvider datesProvider) {
    BorderRadius borderRadius = BorderRadius.zero;
    if (values.isOvulationDay) {
      borderRadius = BorderRadius.circular(100);
      return borderRadius;
    }
    if (values.isFirstDayOfWeek) {
      borderRadius = BorderRadius.only(
        topLeft: Radius.circular(radius),
        bottomLeft: Radius.circular(radius),
      );
    } else if (values.isLastDayOfWeek) {
      borderRadius = BorderRadius.only(
        topRight: Radius.circular(radius),
        bottomRight: Radius.circular(radius),
      );
    }

    if ((values.isFirstPeriodDay) || (values.isLastPeriodDay)) {
      if (values.isFirstPeriodDay && values.isLastPeriodDay) {
        borderRadius = BorderRadius.circular(radius);
      } else if (values.isFirstPeriodDay && !values.isLastDayOfWeek) {
        borderRadius = BorderRadius.only(
          topLeft: Radius.circular(radius),
          bottomLeft: Radius.circular(radius),
        );
      } else if (values.isFirstPeriodDay && values.isLastDayOfWeek) {
        borderRadius = BorderRadius.circular(radius);
      } else if (values.isLastPeriodDay && !values.isFirstDayOfWeek) {
        borderRadius = BorderRadius.only(
          topRight: Radius.circular(radius),
          bottomRight: Radius.circular(radius),
          // topLeft: Radius.circular(radius),
          // bottomLeft: Radius.circular(radius),
        );
      } else if (values.isLastPeriodDay && values.isFirstDayOfWeek) {
        borderRadius = BorderRadius.only(
          topRight: Radius.circular(radius),
          bottomRight: Radius.circular(radius),
          topLeft: Radius.circular(radius),
          bottomLeft: Radius.circular(radius),
        );
      }
    } else {
      // txtStyle =
      //     (textStyle ?? Theme.of(context).textTheme.bodyLarge)!.copyWith(
      //   // color: Colors.white,
      //   // fontWeight: values.isFirstDayOfWeek || values.isLastDayOfWeek
      //   //     ? FontWeight.bold
      //   //     : null,
      // );
    }
    return borderRadius;
  }

  Border? getBorder(values, Color color) {
    Border? border;
    if (values.isFirstDayOfWeek) {
      border = Border(
        left: BorderSide(
          color: color,
          width: 1.0,
        ),
      );
    } else if (values.isLastDayOfWeek) {
      border = Border(
        right: BorderSide(
          color: color,
          width: 1.0,
        ),
      );
    }

    if ((values.isFirstPeriodDay) || (values.isLastPeriodDay)) {
      if (values.isFirstPeriodDay && values.isLastPeriodDay) {
        border = Border.all(
          color: color,
          width: 1.0,
        );
      } else if (values.isFirstPeriodDay && !values.isLastDayOfWeek) {
        border = Border(
          left: BorderSide(
            color: color,
            width: 1.0,
          ),
        );
      } else if (values.isFirstPeriodDay && values.isLastDayOfWeek) {
        border = Border.all(
          color: color,
          width: 1.0,
        );
      } else if (values.isLastPeriodDay && !values.isFirstDayOfWeek) {
        border = Border(
          right: BorderSide(
            color: color,
            width: 1.0,
          ),
        );
      } else if (values.isLastPeriodDay && values.isFirstDayOfWeek) {
        border = Border.all(
          color: color,
          width: 1.0,
        );
      }
    }
    return border;
  }
}
