import 'package:flutter/material.dart';

import 'set_code.dart';

class LodingScreen extends StatefulWidget {
  @override
  _LodingScreenState createState() => _LodingScreenState();
}

class _LodingScreenState extends State<LodingScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..addListener(() {
        setState(() {});
        if (_animationController!.value == 1.0) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SetCode()),
          );
        }
      });
    _animationController!.forward();
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double progress = _animationController!.value * 100;

    return Scaffold(
      appBar: AppBar(
        title: Text('My Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 200.0,
                  height: 200.0,
                  child: CircularProgressIndicator(
                    strokeWidth: 20.0,
                    value: _animationController!.value,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                    backgroundColor: Colors.white,
                  ),
                ),
                Text(
                  '${progress.toStringAsFixed(0)}%',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Text(
              'Calculating your future cycles',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
