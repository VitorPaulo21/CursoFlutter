import 'package:flutter/material.dart';
import 'package:shop/components/drawer.dart';
import 'package:shop/components/order_widget.dart';
import 'package:shop/models/order_list.dart';
import 'package:shop/utils/app_routes.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OrderList orderList = Provider.of(context);
    return WillPopScope(
      onWillPop: () => Navigator.of(context)
              .pushReplacementNamed(AppRoutes.HOME, arguments: true)
          as Future<bool>,
      child: Scaffold(
        drawer: const DrawerWidget(),
        appBar: AppBar(
          title: const Text("Meus Pedidos"),
        ),
        body: ListView.builder(
            itemCount: orderList.itemsCount,
            itemBuilder: (ctx, i) {
              return OrderWidget(orderList.orders[i]);
            }),
      ),
    );
  }
}
