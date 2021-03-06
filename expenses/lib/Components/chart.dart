import 'dart:collection';

import 'package:expenses/Components/chart_bar.dart';
import 'package:expenses/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> _recentTransactions;

  //Constructor
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
    bool isTablet = Device.get().isTablet;
    _groupedTransactions;
    return LayoutBuilder(builder: (ctx, cont) {
      return Card(
        elevation: 6,
        margin: EdgeInsets.only(
            bottom: cont.maxHeight * 0.05,
            left: 20,
            right: 20,
            top: cont.maxHeight * 0.1),
        child: Padding(
          padding:
              const EdgeInsets.only(bottom: 5, left: 10, right: 10, top: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MediaQuery.of(context).orientation == Orientation.landscape &&
                      !isTablet
                  ? Container()
                  : FittedBox(
                      child: Container(
                        height: cont.maxHeight * 0.12,
                        margin: const EdgeInsets.only(bottom: 8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 0),
                        child: FittedBox(
                          child: Text(
                            "R\$${_weekTotalValue.toStringAsFixed(2)}",
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary,
                                fontFamily: "OpenSans",
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(100),
                            bottomRight: Radius.circular(100),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey[400]!,
                              offset: const Offset(0.0, 4.0), //(x,y)
                              blurRadius: 4.0,
                            ),
                          ],
                        ),
                      ),
                    ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MediaQuery.of(context).orientation ==
                          Orientation.landscape
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.spaceAround,
                  children: _groupedTransactions.reversed.map((e) {
                    return Expanded(
                      child: Padding(
                        padding: MediaQuery.of(context).orientation ==
                                Orientation.landscape
                            ? EdgeInsets.only(left: 10, right: 10, top: 5)
                            : EdgeInsets.all(0),
                        child: ChartBar(
                            weekDay: e["day"].toString(),
                            value: (e["value"] as double),
                            percent: _weekTotalValue == 0
                                ? 0
                                : (e["value"] as double) / _weekTotalValue),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
