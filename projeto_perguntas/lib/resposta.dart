import 'package:flutter/material.dart';
import 'main.dart';

class Resposta extends StatelessWidget {
  String _texto;
  final void Function() _onClick;
  String _default = "Vermleho";

  Resposta(this._texto, this._onClick, this._default);
  
  @override
  Widget build(BuildContext context) {
  // ignore: prefer_function_declarations_over_variables
    void Function() click = () {
      PerguntasAppState.setColor(this);
      _onClick();
    };
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
      margin: EdgeInsets.only(top: 5, bottom: 5),
      child: ElevatedButton(
        child: Text(
          _texto,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        onPressed: click,
        style: ElevatedButton.styleFrom(
            alignment: Alignment.center,
            elevation: 8,
            primary: _cor(),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(13))),
      ),
    );
  }

  Color _cor() {
    if (_texto == "Preto") {
      return Colors.black;
    } else if (_texto == "Vermelho") {
      return Colors.red;
    } else if (_texto == "Verde") {
      return Colors.green;
    } else if (_texto == "Azul") {
      return Colors.blue;
    } else {
      _texto = _default;
      return _cor();
    }
  }

  void setDefault(String value) {
    _default = value;
  }

  String get cor {
    return _texto;
  }
}
