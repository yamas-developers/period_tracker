import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:period_tracker/dates_provider.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import 'package:intl/intl.dart';

import '../ui/self_care/statuses.dart';
import '../utils/constants.dart';
import '../utils/public_methods.dart';

class MonthWidget extends StatelessWidget {
  final DateTime month;
  final String locale;
  final Layout? layout;
  final TextStyle? textStyle;
  final TextAlign? textAlign;
  final Widget Function(BuildContext context, String month)? monthBuilder;

  const MonthWidget({
    Key? key,
    required this.month,
    required this.locale,
    required this.layout,
    required this.monthBuilder,
    required this.textStyle,
    required this.textAlign,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final text =
        '${DateFormat('MMMM', locale).format(DateTime(month.year, month.month)).capitalize()} ${month.year == DateTime.now().year ? '' : DateFormat('yyyy', locale).format(DateTime(month.year, month.month))}';

    if (monthBuilder != null) {
      return monthBuilder!(context, text);
    }

    return _beauty(context, text);
  }

  Widget _beauty(BuildContext context, String text) {
    return Row(
      children: [
        Text(
          text.capitalize(),
          textAlign: textAlign ?? TextAlign.center,
          style: textStyle ?? Theme.of(context).textTheme.titleLarge!,
        ),
      ],
    );
  }
}

class CustomAnimatedIcon extends StatefulWidget {
  CustomAnimatedIcon(
      {Key? key,
      required this.firstIcon,
      required this.secondIcon,
      this.firstCallback,
      this.secondCallback,
      this.color, this.currentIcon = 0})
      : super(key: key);
  final IconData firstIcon;
  final IconData secondIcon;
  final firstCallback;
  final secondCallback;
  final Color? color;
  int currentIcon;

  @override
  State<CustomAnimatedIcon> createState() => _CustomAnimatedIconState();
}

class _CustomAnimatedIconState extends State<CustomAnimatedIcon> {
  // int _currIndex = 0;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: AnimatedSwitcher(
          duration: const Duration(milliseconds: 100),
          transitionBuilder: (child, anim) => RotationTransition(
                turns: child.key == ValueKey('icon1')
                    ? Tween<double>(begin: 1, end: 0).animate(anim)
                    : Tween<double>(begin: 0, end: 1).animate(anim),
                child: FadeTransition(opacity: anim, child: child),
              ),
          child: widget.currentIcon == 0
              ? Icon(
                  widget.firstIcon,
                  key: const ValueKey('icon1'),
                  color: widget.color,
                )
              : Icon(widget.secondIcon,
                  key: const ValueKey('icon2'), color: widget.color)),
      onPressed: () {
        if (widget.currentIcon == 0 && widget.firstCallback != null) {
          widget.firstCallback();
        } else if (widget.currentIcon == 1 && widget.secondCallback != null) {
          widget.secondCallback();
        }
        setState(() {
          widget.currentIcon = widget.currentIcon == 0 ? 1 : 0;
        });
      },
    );
  }
}
