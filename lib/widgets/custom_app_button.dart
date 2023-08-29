import 'package:flutter/material.dart';

import '../utils/constants.dart';

class CustomAppButton extends StatelessWidget {
  const CustomAppButton({
    super.key,
    required this.onTap,
    required this.title,
  });

  final dynamic onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 50,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: accentColor,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(3.0), // Set the desired border radius
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Text(
            title,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
