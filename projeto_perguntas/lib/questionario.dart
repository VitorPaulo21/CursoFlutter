// ignore_for_file: file_names

import 'package:flutter/material.dart';

import 'Questao.dart';

class Questionario extends StatelessWidget {
  late final List<Widget> _respostas;
  late final List<Map<String, Object>> _perguntas;
  late final int _perguntaSelecionada;

  Questionario(
      {required respostas, required perguntas, required perguntaselecionada}) {
    _respostas = respostas;
    _perguntas = perguntas;
    _perguntaSelecionada = perguntaselecionada;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Pergunta(_perguntas[_perguntaSelecionada]["texto"].toString()),
        ..._respostas
      ],
    );
  }
}
