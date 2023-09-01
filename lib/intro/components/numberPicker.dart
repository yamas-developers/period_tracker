import 'package:flutter/cupertino.dart';

class NumberPicker extends StatefulWidget {
  NumberPicker(
      {Key? key,
      this.onSelectionChange,
      this.startNumber = 1,
      this.min = 1,
      this.max = 10})
      : super(key: key);
  final dynamic onSelectionChange;
  final int startNumber;
  final int min;
  final int max;

  @override
  _NumberPickerState createState() => _NumberPickerState();
}

class _NumberPickerState extends State<NumberPicker> {
  int selectedNumber = 1;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        selectedNumber = widget.startNumber;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: CupertinoPicker(
        scrollController:
            FixedExtentScrollController(initialItem: widget.startNumber - 1),
        itemExtent: 48,
        looping: true,
        onSelectedItemChanged: (int index) {
          setState(() {
            selectedNumber = index + 1;
          });
          if (widget.onSelectionChange != null) {
            widget.onSelectionChange(selectedNumber);
          }
        },
        children: [
          for (int i = widget.min; i <= widget.max; i++)
            Center(
              child: Text(
                i.toString(),
                style: TextStyle(fontSize: 32),
              ),
            ),
        ],
      ),
    );
  }
}

class DobPicker extends StatefulWidget {
  DobPicker({
    Key? key,
    this.onSelectionChange,
    this.startNumber = 1,
  }) : super(key: key);
  final dynamic onSelectionChange;
  final int startNumber;

  @override
  _DobPickerState createState() => _DobPickerState();
}

class _DobPickerState extends State<DobPicker> {
  int selectedNumber = 1;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        selectedNumber = widget.startNumber;
      });
    });
    super.initState();
  }

  int min = 1953;
  int max = 2010;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: CupertinoPicker(
        scrollController: FixedExtentScrollController(
            initialItem: (max - min) - widget.startNumber - 1),
        itemExtent: 48,
        onSelectedItemChanged: (int index) {
          setState(() {
            selectedNumber = index + 1;
          });
          if (widget.onSelectionChange != null) {
            widget.onSelectionChange(selectedNumber+min-1);
          }
        },
        children: [
          for (int i = min; i <= max; i++)
            Center(
              child: Text(
                i.toString(),
                style: TextStyle(fontSize: 32),
              ),
            ),
        ],
      ),
    );
  }
}
