import 'dart:math';

import 'package:expenses/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  void Function({
    required String title,
    required double value,
    required DateTime date,
  }) onSubmit;

  TransactionForm(this.onSubmit);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _valueController = TextEditingController();
  DateTime? _pickedDate = null;

  _submitForm() {
    final String title = _titleController.text;
    final String value = _valueController.text;
    late final DateTime date;
    if (_pickedDate == null) {
      date = DateTime.now();
    } else {
      date = _pickedDate!;
    }

    if (title.isEmpty || value.isEmpty) {
      return;
    }

    widget.onSubmit(
      title: _titleController.text,
      value: double.tryParse(_valueController.text) ?? 0.0,
      date: date
    );
  }

  void _showDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate:
          DateTime(DateTime.now().subtract(const Duration(days: 365 * 2)).year),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        _pickedDate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    return Card(
      child: LayoutBuilder(builder: (cntx, constrain) {
      return Padding(
        padding: const EdgeInsets.only(
          left: 10,
          right: 10,
          // bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: constrain.maxHeight * 0.5,
              child: Column(
                children: [
                  Flexible(
                    flex: 1,
                    child: TextField(
                      autofocus: true,
                      textInputAction: TextInputAction.next,
                      controller: _titleController,
                      decoration: const InputDecoration(labelText: "Titulo"),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: TextField(
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
                  ),
                ],
              ),
            ),
            Container(
              height: constrain.maxHeight * 0.2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FittedBox(
                    child: Text(_pickedDate == null
                        ? "Nenhuma data Selecionada!"
                        : "Data Selecionada: ${DateFormat("dd/MM/yy", "PT-BR").format(_pickedDate!)}"),
                  ),
                  TextButton(
                      onPressed: _showDate,
                      child: const FittedBox(
                        child: Text(
                          "Selecionar Data",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ))
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: constrain.maxHeight * 0.1,
                  child: ElevatedButton(
                    autofocus: true,
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(90))),
                    child: const FittedBox(
                      child: Text(
                        "Nova Trnsação",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    })
    );
  }
}
