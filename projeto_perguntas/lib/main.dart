
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:projeto_perguntas/Resultado.dart';
import 'package:projeto_perguntas/questao.dart';
import 'package:projeto_perguntas/questionario.dart';
import 'package:projeto_perguntas/resposta.dart';

void main(List<String> args) {
  runApp(new PerguntaApp());
}
int _perguntaSelecionada = 0;



class PerguntasAppState extends State<PerguntaApp> {

int _pontuacaoTotal = 0;
  
  
  final List<Map<String, Object>> _perguntas = const [
    {
      "texto": "Qual é a sua cor favorita?",
      "respostas": [
        {"texto": "Preto", "nota": 10},
        {"texto": "Vermelho", "nota": 5},
        {"texto": "Verde", "nota": 3},
        {"texto": "Azul", "nota": 1},
      ]
    },
    {
      "texto": "Qual seu animal favorito?",
      "respostas": [
        {"texto": "Coelho", "nota": 10},
        {"texto": "Cobra", "nota": 5},
        {"texto": "Elefante", "nota": 3},
        {"texto": "Leitão", "nota": 1},
      ]
    },
    {
      "texto": "Qual Instrutor favorito?",
      "respostas": [
        {"texto": "Leo", "nota": 10},
        {"texto": "Marcia", "nota": 5},
        {"texto": "João", "nota": 3},
        {"texto": "pedro", "nota": 1},
      ]
    }
    ];
    List<Resposta> questList = [];

  void _AlterarPergunta(int pontuacao) {
    if (temPerguntasSelecionadas()) {
      setState(() {
     _perguntaSelecionada++;
     _pontuacaoTotal += pontuacao;
      });
    }
  }

  bool temPerguntasSelecionadas() {
    return _perguntaSelecionada < _perguntas.length;
  }

  static String cor = "";

  @override
  Widget build(BuildContext context) {
  
  final List<Widget> _respostas = temPerguntasSelecionadas()
        ? _retornarRespostas()
            .map((resposta) => Resposta(
                resposta["texto"].toString(),
                () => _AlterarPergunta(resposta["nota"] as int),
                cor == "" ? "Vermelho" : cor))
            .toList()
        : [];
          final Questionario questionario = Questionario(
      perguntas: _perguntas,
      respostas: _respostas,
      perguntaselecionada: _perguntaSelecionada,
    );
    _respostas.forEach((element) => questList.add(element as Resposta));
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.transparent,
        shape: const ContinuousRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(60),
                bottomRight: Radius.circular(60))),
        elevation: 15,
        title: Container(
          child: const Text("Perguntas"),
          width: double.infinity,
          height: kToolbarHeight,
          alignment: Alignment.center,
          //color: Colors.blue,
        ),
      ),
      body: temPerguntasSelecionadas()
          ? questionario
          : Resultado(reset, cor == "" ? "Vermelho" : cor, _pontuacaoTotal),
    ));
  }
 
 List<Map<String, Object>> _retornarRespostas() {
    return (_perguntas[_perguntaSelecionada]["respostas"]
        as List<Map<String, Object>>);
  }

  void reset() {
    setState(() {
      _perguntaSelecionada = 0;
      _pontuacaoTotal = 0;
    });
  }
  static void setColor(Resposta resposta) {
    cor = resposta.cor;
  }
}

class PerguntaApp extends StatefulWidget {
  @override
  PerguntasAppState createState() {
    return new PerguntasAppState();
  }

}
