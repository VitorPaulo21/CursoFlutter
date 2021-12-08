import 'package:expenses/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _transactions;
  final Function(String) _onRemove;

  TransactionList(this._transactions, this._onRemove) {
    initializeDateFormatting();
    _voidSortList();
  }
  void _voidSortList() {
    _transactions.sort((trA, trB) => trB.date.day.compareTo(trA.date.day));
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 430,
        child: _transactions.isEmpty
            ? Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Nenhuma Tranzação cadrastrada",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 200,
                    child: Image.asset(
                      "assets/images/waiting.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              )
            : ListView.builder(
            itemCount: _transactions.length,
            itemBuilder: (ctx, index) {
              Transaction e = _transactions.elementAt(index);
              return Card(
                elevation: 5,
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Colors.white,
                        radius: 30,
                        child: Padding(
                          padding: const EdgeInsets.all(6),
                          child: FittedBox(
                            child: Text(
                              "R\$${e.value.toStringAsFixed(2)}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      title: Text(e.title),
                      subtitle:
                          Text(DateFormat("d/MMM/yy", "PT-BR").format(e.date)),
                          trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          _onRemove(e.id);
                        },
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  );
            })
      
    );
  }
}
