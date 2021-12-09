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
    return LayoutBuilder(builder: (cntx, constrain) {
      return Column(
        children: [
          Container(
            height: constrain.maxHeight * 0.1,
            child: FittedBox(
              child: Text(value.toStringAsFixed(2)),
            ),
          ),
           SizedBox(
            height: constrain.maxHeight * 0.05,
          ),
          Container(
            height: constrain.maxHeight * 0.6,
            width: 10,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                      color: Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(5)),
                ),
                FractionallySizedBox(
                  heightFactor: percent,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                )
              ],
            ),
          ),
           SizedBox(
            height: constrain.maxHeight * 0.05,
          ),
          FittedBox(child: Text(weekDay))
        ],
      );
    });
    
    
  }
}
