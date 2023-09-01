
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:period_tracker/utils/constants.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.reminderTextController,
    required this.hintText,
    this.maxLines=1,
    required this.textInputType,
  });

  final TextEditingController reminderTextController;
  final String hintText;
  final TextInputType textInputType;
  final int maxLines;
  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late FocusNode focus;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.reminderTextController,
      keyboardType: widget.textInputType,
      maxLines: widget.maxLines,
      decoration: InputDecoration(
        labelText: widget.hintText,
        // suffix: Padding(
        //   padding:
        //   const EdgeInsets.only(top: 12, bottom: 14, left: 12, right: 12),
        //   child: Image.asset(
        //     widget.image,
        //     height: widget.height,
        //     width: widget.width,
        //     color: mainColor,
        //   ),
        // ),
        contentPadding:
        const EdgeInsetsDirectional.symmetric(horizontal: 8, vertical: 12),
        // labelStyle: TextStyle(
        //   color: Colors.deepPurpleAccent,
        // ),
        // hintStyle: TextStyle(
        //  height: 1
        // ),
        // filled: true,
        border: const OutlineInputBorder(),
        enabledBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(width: 0.6, color: fontColor.withOpacity(0.6))),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(width: 1.6, color: Colors.deepPurpleAccent)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(width: 1.6, color: Colors.deepPurpleAccent)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(width: 1.6, color: Colors.deepPurpleAccent)),
      ),
    );
  }
}