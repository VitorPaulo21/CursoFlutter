import 'dart:math';

import 'package:expenses/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TransactionForm extends StatefulWidget {
  void Function({required String title, required double value}) onSubmit;

  TransactionForm(this.onSubmit);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _valueController = TextEditingController();

  _submitForm() {
    final String title = _titleController.text;
    final String value = _valueController.text;

    if (title.isEmpty || value.isEmpty) {
      return;
    }

    widget.onSubmit(
      title: _titleController.text,
      value: double.tryParse(_valueController.text) ?? 0.0,
    );
  }

  @override
  Widget build(BuildContext context) {

     
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 10,
          right: 10,
          // bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              autofocus: true,
              textInputAction: TextInputAction.next,
              controller: _titleController,
              decoration: const InputDecoration(labelText: "Titulo"),
            ),
            TextField(
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^[\.\d]+')),
                FilteringTextInputFormatter.deny(RegExp(r'\..*\.'),
                    replacementString: "."),
              ],
              controller: _valueController,
              autofocus: true,
              onSubmitted: (text) => _submitForm(),
              decoration: const InputDecoration(labelText: "Valor R\$"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  autofocus: true,
                  onPressed: _submitForm,
                  child: const Text(
                    "Nova Trnsação",
                    style: TextStyle(color: Colors.purple),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
