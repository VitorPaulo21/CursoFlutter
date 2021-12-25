import 'package:flutter/material.dart';
import 'package:shop/components/drawer.dart';
import 'package:shop/components/product_item.dart';
import 'package:shop/models/product.dart';
import 'package:shop/models/product_list.dart';
import 'package:shop/utils/app_routes.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProductList productList = Provider.of(context);
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pushReplacementNamed(AppRoutes.HOME);
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Gerenciar Produtos"),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.PRODUCT_FORM);
                },
                icon: const Icon(Icons.add))
          ],
        ),
        drawer: const DrawerWidget(),
        body: Padding(
          padding: EdgeInsets.all(8),
          child: ListView.builder(
            itemCount: productList.itemCount,
            itemBuilder: (ctx, i) {
              return ProductItem(productList.products[i]);
            },
          ),
        ),
      ),
    );
  }
}
