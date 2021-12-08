import 'dart:collection';

import 'package:expenses/Components/chart_bar.dart';
import 'package:expenses/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> _recentTransactions;
  Chart(this._recentTransactions) {
    initializeDateFormatting();
  }

  List<Map<String, Object>> get _groupedTransactions {
    return List.generate(7, (index) {
      final DateTime weekDay = DateTime.now().subtract(Duration(days: index));
      final List<Transaction> filteredList =
          _recentTransactions.where((element) {
        bool sameDay = element.date.day == weekDay.day;
        bool sameMonth = element.date.month == weekDay.month;
        bool sameyear = element.date.year == weekDay.year;
        return sameDay && sameMonth && sameyear;
      }).toList();
      double totalSum = filteredList.isEmpty
          ? 0.0
          : filteredList
              .map((e) => e.value)
              .reduce((value, element) => value + element);

      return {
        "day": DateFormat.E("PT-BR").format(weekDay)[0],
        "value": totalSum
      };
    });
  }

  double get _weekTotalValue {
    return _groupedTransactions.fold(
        0.0,
        (previousValue, element) =>
            previousValue + (element["value"] as double));
  }
  @override
  Widget build(BuildContext context) {
    _groupedTransactions;
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: _groupedTransactions.reversed.map((e) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                  weekDay: e["day"].toString(),
                  value: (e["value"] as double),
                  percent: _weekTotalValue == 0
                      ? 0
                      : (e["value"] as double) / _weekTotalValue),
            );
          }).toList(),
        ),
      ),
    );
  }
}
