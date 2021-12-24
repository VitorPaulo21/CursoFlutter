import 'package:flutter/material.dart';
import 'package:shop/components/item_cart_widget.dart';
import 'package:shop/models/cart.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/cart_item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Cart cart = Provider.of(context);
    final List<CartItem> item = cart.items.values.toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Carrinho"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total:",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Chip(
                    label: Text(
                      "R\$ ${cart.totalAmount.toStringAsFixed(2)}",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  const Spacer(),
                  TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Comprar",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      )),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: item.length,
              itemBuilder: (ctx, i) => ItemCartWidget(item[i]),
            ),
          )
        ],
      ),
    );
  }
}
