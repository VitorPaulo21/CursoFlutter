import 'package:flutter/material.dart';
import 'package:shop/components/badge.dart';
import 'package:shop/components/product_grid.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/product_list.dart';
import 'package:shop/utils/app_routes.dart';

enum FilterOptions { favorites, all }

class ProductOverviewPage extends StatefulWidget {
  const ProductOverviewPage({Key? key}) : super(key: key);

  @override
  State<ProductOverviewPage> createState() => _ProductOverviewPageState();
}

bool _showOnlyFavorites = false;

class _ProductOverviewPageState extends State<ProductOverviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Minha Loja"),
        actions: [
          Consumer<ProductList>(
            builder: (ctx, productList, _) => PopupMenuButton(
              itemBuilder: (_) => const [
                PopupMenuItem(
                  child: Text("Mostrar somente Favoritos"),
                  value: FilterOptions.favorites,
                ),
                PopupMenuItem(
                  child: Text("Mostrar Todos"),
                  value: FilterOptions.all,
                )
              ],
              onSelected: (selected) {
                if (selected == FilterOptions.favorites) {
                  setState(() {
                    _showOnlyFavorites = true;
                  });
                } else {
                  setState(() {
                    _showOnlyFavorites = false;
                  });
                }
              },
            ),
          ),
          Consumer<Cart>(
            builder: (ctx, cart, _) => Badge(
              onPressed: () => Navigator.of(context).pushNamed(AppRoutes.CART),
              child: const Icon(Icons.shopping_cart),
              num: cart.itemsCount.toString(),
            ),
          )
        ],
        centerTitle: true,
      ),
      body: ProductGrid(_showOnlyFavorites),
    );
  }
}

