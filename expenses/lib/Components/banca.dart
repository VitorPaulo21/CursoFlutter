import 'package:flutter/material.dart';

class Banca extends StatelessWidget {
  int position;
  final void Function(int) posChange;
  final double banca;
  final Function setBanca;
  Banca(
      {required this.position,
      required this.posChange,
      required this.banca,
      required this.setBanca});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: SizedBox(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  setBanca();
                },
                child: Row(
                  children: [
                   const Text("Conta: ",
                        style: TextStyle(
                            fontFamily: "OpenSans",
                            fontWeight: FontWeight.bold,
                            fontSize: 16)),
                          FittedBox(
                      child: Text("R\$${banca.toStringAsFixed(2)}",
                          style: TextStyle(
                            fontFamily: "OpenSans",
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: banca < 0
                                ? Colors.red
                                : Theme.of(context).colorScheme.primary,
                          )),
                          ),
                    Icon(
                      Icons.edit,
                      color: Theme.of(context).colorScheme.primary,
                      size: 16,
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      "Organizar por:",
                      style: TextStyle(
                        fontFamily: "OpenSans",
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  DropdownButton<int>(
                    items: [
                      dropItem(
                          value: 0, text: "Data", icon: 1, context: context),
                      dropItem(
                          value: 1, text: "Data", icon: 0, context: context),
                      dropItem(
                          value: 2, text: "Valor", icon: 1, context: context),
                      dropItem(
                          value: 3, text: "Valor", icon: 0, context: context),
                    ],
                    value: position,
                    icon: const Icon(Icons.arrow_drop_down),
                    elevation: 5,
                    onChanged: (pos) {
                      posChange(pos!);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class dropItem extends DropdownMenuItem<int> {
  final int value;
  final String text;
  final int icon;
  final dynamic context;

  dropItem(
      {required this.context,
      required this.value,
      required this.text,
      required this.icon})
      : super(
          value: value,
          child: Row(
            children: [
              Text(
                text,
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              Icon(
                icon == 0
                    ? Icons.arrow_upward_outlined
                    : Icons.arrow_downward_outlined,
                color: Theme.of(context).colorScheme.primary,
              )
            ],
          ),
        );
}
