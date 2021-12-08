import 'dart:math';

import 'package:expenses/Components/chart.dart';
import 'package:expenses/Components/transaction_form.dart';
import 'package:expenses/Components/transaction_list.dart';
import 'package:expenses/transaction.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(ExpensesApp());
}

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      theme: ThemeData(
          fontFamily: "BalooBhaijaan2",
          textTheme: ThemeData.light().textTheme.copyWith(
              headline6: const TextStyle(
                  fontFamily: "OpenSans",
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          appBarTheme: const AppBarTheme(
              titleTextStyle: TextStyle(
            fontFamily: "BalooBhaijaan2 ",
            fontSize: 22,
            fontWeight: FontWeight.bold,
          )),
          colorScheme: ColorScheme(
            primary: Colors.purple,
            primaryVariant: Colors.purple,
            secondary: Colors.amber,
            secondaryVariant: Colors.amber,
            surface: Theme.of(context).colorScheme.surface,
            background: Theme.of(context).colorScheme.background,
            error: Theme.of(context).colorScheme.error,
            onPrimary: Theme.of(context).colorScheme.onPrimary,
            onSecondary: Colors.black,
            onSurface: Theme.of(context).colorScheme.onSurface,
            onBackground: Theme.of(context).colorScheme.onBackground,
            onError: Theme.of(context).colorScheme.onError,
            brightness: Theme.of(context).colorScheme.brightness,
          )),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [
    Transaction(
        title: 'Conta antiga',
        id: "t1",
        value: 21.90,
        date: DateTime.now().subtract(Duration(days: 33))),
    Transaction(
        title: 'Tênis de corrida',
        id: "t1",
        value: 310.76,
        date: DateTime.now().subtract(Duration(days: 3))),
    Transaction(
        title: 'TConta de Luz',
        id: "t1",
        value: 211.30,
        date: DateTime.now().subtract(Duration(days: 4)))
  ];
  List<Transaction> get _recentTransaction {
    return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }
  void _addTransaction({required String title, required double value}) {
    setState(() {
      _transactions.add(Transaction(
          id: Random().nextDouble().toString(),
          title: title,
          value: value,
          date: DateTime.now()));
    });

    Navigator.of(context).pop();
  }

  void _opentransactionForModal(BuildContext context) {
    showModalBottomSheet(
        elevation: 15,
        // isScrollControlled: true,
        context: context,
        builder: (_) => TransactionForm(_addTransaction));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Despesas Pessoais",
        ),
        actions: [
          IconButton(
              onPressed: () {
                _opentransactionForModal(context);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              child: Card(
                child: Chart(_recentTransaction),
              ),
            ),
            TransactionList(_recentTransaction),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _opentransactionForModal(context);
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
