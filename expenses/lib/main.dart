import 'dart:math';

import 'package:expenses/Components/banca.dart';
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
  double _banca = 0;
  final List<Transaction> _transactions = [];
  List<Transaction> get _recentTransaction {
    return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }
  int _filterPosition = 0;
  void _addTransaction(
      {required String title, required double value, required DateTime date}) {
    setState(() {
      _transactions.add(Transaction(
          id: Random().nextDouble().toString(),
          title: title,
          value: value,
          date: date));
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

  void _removeTranzaction(String id) {
    setState(() {
      _transactions.removeWhere((element) => element.id == id);
    });
  }

  void _changeFilter(int pos) {
    setState(() {
      _filterPosition = pos;
    });
  }

  void _submitBanca(double valor) {
    setState(() {
      _banca = valor;
    });
  }

  double _deltaBanca() {
    return _banca -
        _recentTransaction.map((e) => e.value).fold(0.0, (a, b) => a + b);
  }

  void _openBancaModal(BuildContext context) {
    TextEditingController banca = TextEditingController();
    showModalBottomSheet(
        context: context,
        builder: (_) => Card(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextField(
                      onSubmitted: (text) {
                        double valor = 0;
                        if (!text.isEmpty) {
                          valor = double.tryParse(text) ?? 0;
                        }
                        _submitBanca(valor);
                        Navigator.of(context).pop();
                      },
                      textInputAction: TextInputAction.done,
                      controller: banca,
                      keyboardType:
                         const TextInputType.numberWithOptions(decimal: true),
                      decoration: const InputDecoration(
                        hintText: "Novo valor em conta",
                      ),
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      double valor = 0;
                      if (!banca.text.isEmpty) {
                        valor = double.tryParse(banca.text) ?? 0;
                      }
                      _submitBanca(valor);
                      Navigator.of(context).pop();
                    },
                    child: Text("Selecionar"),
                  )
                ],
              ),
            ),
        elevation: 5);
  }

  @override
  Widget build(BuildContext context) {
    final AppBar appbar = AppBar(
      elevation: 8,
      shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(90),
        bottomRight: Radius.circular(90),
      )),
        title: const Text(
          "Gastos Semanais",
        ),
        actions: [
          IconButton(
              onPressed: () {
                _opentransactionForModal(context);
              },
              icon: const Icon(Icons.add))
        ],
      );

    final double avaliableSpace = MediaQuery.of(context).size.height -
        appbar.preferredSize.height -
        MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: appbar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              height: avaliableSpace * 0.29,
              child: Chart(_recentTransaction),
            ),
            Container(
              height: avaliableSpace * 0.065,
              child: Banca(
                position: _filterPosition,
                posChange: _changeFilter,
                banca: _deltaBanca(),
                setBanca: () {
                  _openBancaModal(context);
                },
              ),
            ),
            Container(
              height: avaliableSpace * 0.635,
              child: TransactionList(
                  _recentTransaction, _removeTranzaction, _filterPosition),
            ),
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
