import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import '../transaction.dart';

@immutable
class TransactionListComponent extends StatelessWidget {
  const TransactionListComponent({
    required this.e,
    required Function(String) onRemove,
  }) : _onRemove = onRemove;

  final Transaction e;
  final Function(String p1) _onRemove;

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();
    return ListTile(
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
      subtitle: Text(DateFormat("d/MMM/yy", "PT-BR").format(e.date)),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () {
          _onRemove(e.id);
        },
        color: Theme.of(context).colorScheme.error,
      ),
    );
  }
}
