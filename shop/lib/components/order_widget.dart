import 'package:flutter/material.dart';
import 'package:shop/models/order.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class OrderWidget extends StatefulWidget {
  final Order order;
  const OrderWidget(this.order, {Key? key}) : super(key: key);

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  bool isOpened = false;
  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();
    return Column(
      children: [
        Card(
          elevation: isOpened ? 6 : 2,
          child: ListTile(
            onTap: () {
              setState(() {
                isOpened = !isOpened;
              });
            },
            title: Text("R\$ ${widget.order.total}"),
            subtitle: Text(DateFormat("dd/MM/yyyy HH:mm", "PT-BR")
                .format(widget.order.date)),
            trailing:
                isOpened ? Icon(Icons.expand_less) : Icon(Icons.expand_more),
          ),
        ),
        if (isOpened)
          Container(
            width: double.infinity,
            child: Card(
              color: Colors.grey[100],
              elevation: 2,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 15),
                alignment: Alignment.center,
                height: (widget.order.products.length * 25) + 10,
                child: ListView(
                  children: widget.order.products.map((e) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          e.name,
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                        Text(
                          "${e.quantity}x R\$${e.price}",
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        )
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          )
      ],
    );
  }
}
