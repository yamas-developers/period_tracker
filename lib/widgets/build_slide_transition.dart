import 'package:flutter/material.dart';

class BuildSlideTransition extends StatelessWidget {
  const BuildSlideTransition(
      {Key? key,
      required this.child,
      this.animationDuration = 600,
      this.startPos = 1.0,
      this.endPos = 0.0,
      this.curve = Curves.elasticInOut})
      : super(key: key);
  final Widget child;
  final int animationDuration;
  final double startPos;
  final double endPos;
  final Curve curve;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<Offset>(begin: Offset(startPos, 0), end: Offset(endPos, 0)),
      duration: Duration(milliseconds: animationDuration),
      curve: curve,
      builder: (context, Offset offset, child) {
        return FractionalTranslation(
          translation: offset,
          child: child,
        );
      },
      child: child,
    );
  }
}
