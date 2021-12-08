import 'dart:collection';

import 'package:expenses/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> _recentTransactions;
  Chart(this._recentTransactions) {
    initializeDateFormatting();
  }

  List<Map<String, Object>> get groupedTransactions {
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
      print(DateFormat.E("PT-BR").format(weekDay)[0]);
      print(totalSum);

      return {
        "day": DateFormat.E("PT-BR").format(weekDay)[0],
        "value": totalSum
      };
    });
  }
  @override
  Widget build(BuildContext context) {
    groupedTransactions;
    return Card(
      margin: const EdgeInsets.all(20),
      child: Row(
        children: [],
      ),
    );
  }
}
