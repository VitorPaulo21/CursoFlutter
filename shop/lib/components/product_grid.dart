import 'package:flutter/material.dart';
import 'package:shop/components/product_item.dart';
import 'package:shop/models/product.dart';
import 'package:shop/models/product_list.dart';
import 'package:provider/provider.dart';

class ProductGrid extends StatelessWidget {
  final bool _showOnlyfavorites;
  const ProductGrid(
    this._showOnlyfavorites, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Product> loadedProducts = _showOnlyfavorites
        ? Provider.of<ProductList>(context).favoriteProducts
        : Provider.of<ProductList>(context).products;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: loadedProducts.length,
      itemBuilder: (ctx, i) {
        return ChangeNotifierProvider.value(
          value: loadedProducts[i],
          child: const ProductItem(),
        );
      },
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
