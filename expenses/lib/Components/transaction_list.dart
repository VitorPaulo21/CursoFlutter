import 'package:expenses/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _transactions;
  final Function(String) _onRemove;
  final int _filterPosition;

  TransactionList(this._transactions, this._onRemove, this._filterPosition) {
    initializeDateFormatting();
    _voidSortList();
  }
  void _voidSortList() {
    if (_filterPosition == 0) {
      _transactions.sort((trA, trB) => trB.date.compareTo(trA.date));
    } else if (_filterPosition == 1) {
      _transactions.sort((trA, trB) => trA.date.compareTo(trB.date));
    } else if (_filterPosition == 2) {
      _transactions.sort((trA, trB) => trB.value.compareTo(trA.value));
    } else if (_filterPosition == 3) {
      _transactions.sort((trA, trB) => trA.value.compareTo(trB.value));
    }
  }
  @override
  Widget build(BuildContext context) {
    return _transactions.isEmpty
        ? LayoutBuilder(builder: (cntx, constrain) {
            return Column(
            children: [
              SizedBox(
                  height: constrain.maxHeight * 0.05,
              ),
              Container(
                  height: constrain.maxHeight * 0.065,
                  child: FittedBox(
                    child: Text(
                      "Nenhuma Tranzação cadrastrada",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                ),
              ),
                SizedBox(
                  height: constrain.maxHeight * 0.05,
                ),
                SizedBox(
                  height: constrain.maxHeight * 0.4,
                child: Image.asset(
                  "assets/images/waiting.png",
                  fit: BoxFit.cover,
                ),
              ),
            ],
          );
          })

        : ListView.builder(
            itemCount: _transactions.length,
            itemBuilder: (ctx, index) {
              Transaction e = _transactions.elementAt(index);
              return Card(
                elevation: 5,
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
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
        });
  }
}
