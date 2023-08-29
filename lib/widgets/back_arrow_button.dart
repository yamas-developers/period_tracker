import 'package:flutter/material.dart';

class BackArrowButton extends StatelessWidget {
  const BackArrowButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          padding: EdgeInsets.zero,
        ),
      ],
    );
  }
}
