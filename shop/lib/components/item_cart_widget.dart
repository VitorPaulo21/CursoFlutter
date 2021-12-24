import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/cart_item.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/product.dart';
import 'package:shop/models/product_list.dart';

class ItemCartWidget extends StatelessWidget {
  final CartItem item;
  const ItemCartWidget(this.item, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      onDismissed: (_) {
        Provider.of<Cart>(context, listen: false).removeItem(item.productId);
      },
      key: ValueKey(item.id),
      direction: DismissDirection.endToStart,
      confirmDismiss: (dir) => showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text("Deseja mesmo excluir esta compra?"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                      child: const Text("Sim")),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                      child: const Text("Não")),
                ],
              )),
      background: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.red[900]!, Colors.red],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight)),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 15),
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: FittedBox(
                  child: Text(
                    item.price.toStringAsFixed(2),
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary),
                  ),
                ),
              ),
            ),
            title: Text(item.name),
            subtitle: Text("Total: R\$ " +
                (item.price * item.quantity).toStringAsFixed(2)),
            trailing: FittedBox(
              child: Consumer<Cart>(
                builder: (ctx, cart, _) => Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    metalButton(
                        () => cart.addItem(cartItemToProduct(item, context)),
                        Icons.add),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      item.quantity.toString(),
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    metalButton(
                        () => cart.reduceItem(cartItemToProduct(item, context)),
                        Icons.remove)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget metalButton(Function() onTap, IconData icon) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 20,
        height: 20,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(90),
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white,
                const Color.fromRGBO(204, 204, 204, 1),
                Colors.grey[700]!
              ]),
        ),
        child: Icon(
          icon,
          size: 18,
          color: Colors.black,
        ),
      ),
    );
  }

  Product? cartItemToProduct(CartItem item, BuildContext context) {
    ProductList products = Provider.of(context, listen: false);
    List<Product> productResult =
        products.products.where((prod) => prod.id == item.productId).toList();
    return productResult.isEmpty ? null : productResult[0];
  }
}
