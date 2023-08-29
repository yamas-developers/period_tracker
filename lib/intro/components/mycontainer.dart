import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:period_tracker/utils/public_methods.dart';

import '../../utils/constants.dart';

class WeightData {
  final DateTime date;
  final int value;

  WeightData(this.date, this.value);
}

class WeightTable extends StatelessWidget {
  final List<WeightData> weightDataList = [
    WeightData(DateTime(2023, 8, 1), 68),
    WeightData(DateTime(2023, 8, 5), 67),
    WeightData(DateTime(2023, 8, 10), 69),
    // Add more data as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(0),
      child: Column(
        children: [
          ...List.generate(weightDataList.length + 1, (index) {
            if (index == 0) {
              return Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: TextTitle(title: 'Weight'),
                  ),
                  Expanded(
                    flex: 3,
                    child: TextTitle(title: 'Change'),
                  ),
                  Expanded(
                    flex: 3,
                    child: TextTitle(title: 'Date'),
                  ),
                  Expanded(
                    flex: 1,
                    child: TextTitle(title: ''),
                  ),
                ],
              );
            }
            final data = weightDataList[index - 1];
            final dataNext =
                index >= weightDataList.length ? null : weightDataList[index];
            return Row(
              children: [
                Expanded(
                  flex: 3,
                  child: TextContent(value: '${data.value} kg'),
                ),
                Expanded(
                    flex: 3,
                    child: TextContent(
                        value: dataNext != null
                            ? '${dataNext.value - data.value} kg'
                            : '')),
                Expanded(
                  flex: 3,
                  child: TextContent(
                    value: DateFormat('MMM dd').format(data.date),
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.more_vert,
                          color: Colors.grey,
                        ))),
              ],
            );
          }),
        ],
      ),
    );
  }
}

class TextContent extends StatelessWidget {
  const TextContent({
    super.key,
    required this.value,
  });

  final String value;

  @override
  Widget build(BuildContext context) {
    return Text(value,
        textAlign: TextAlign.start,
        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16));
  }
}

class TextTitle extends StatelessWidget {
  const TextTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.start,
      style: TextStyle(color: Colors.grey, fontSize: 16),
    );
  }
}
