import 'package:flutter/material.dart';

import '../utils/constants.dart';

class CustomAppButton extends StatelessWidget {
  const CustomAppButton({
    super.key,
    required this.onTap,
    this.height=50,
    this.image="",
    required this.title,
    this.fontSize=14,
    this.color=bgColor
  });

  final dynamic onTap;
  final double height;
  final String image;
  final String title;
  final double fontSize;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: height,
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                    color: color,
                  fontSize: fontSize
                ),
              ),
              SizedBox(width: 5,),
              image.isEmpty?SizedBox():
              Image.asset(
                image,height: 20,width: 20,
                fit: BoxFit.contain,
                color: bgColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
