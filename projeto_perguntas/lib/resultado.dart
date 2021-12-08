// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:projeto_perguntas/resposta.dart';

class Resultado extends StatelessWidget {
  void Function() _reset;
  String cor;
  final int _resultado;

  Resultado(void Function() this._reset, this.cor, this._resultado);

  String get fraseResultado {
    if (_resultado < 8) {
      return "Parabéns!";
    } else if (_resultado < 12) {
      return "Você é bom!";
    } else if (_resultado < 16) {
      return "Impressionante!";
    } else {
      return "Nível jedi";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          fraseResultado,
          style: TextStyle(fontSize: 28),
        ),
        Resposta("Restart", _reset, cor),
      ],
    );
  }
}
