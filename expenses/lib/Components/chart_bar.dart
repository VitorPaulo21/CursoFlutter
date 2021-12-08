import 'package:flutter/material.dart';

@immutable
class ChartBar extends StatelessWidget {
  final String weekDay;
  final double value;
  final double percent;
  const ChartBar(
      {required this.weekDay, required this.value, required this.percent});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value.toStringAsFixed(2)),
        const SizedBox(
          height: 5,
        ),
        Container(
          height: 60,
          width: 10,
          child: null,
        ),
        const SizedBox(
          height: 5,
        ),
        Text(weekDay)
      ],
    );
  }
}
