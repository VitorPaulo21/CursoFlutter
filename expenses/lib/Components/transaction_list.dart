import 'package:expenses/transaction.dart';
import 'package:flutter/material.dart';

import 'componente_lista.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _transactions;
  final Function(String) _onRemove;
  final int _filterPosition;

  TransactionList(this._transactions, this._onRemove, this._filterPosition) {
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
                child:  TransactionListComponent(e: e, onRemove: _onRemove),
              );
        });
  }
}

