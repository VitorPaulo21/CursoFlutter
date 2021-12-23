import 'package:flutter/material.dart';
import 'package:shop/models/product.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:shop/utils/app_routes.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Product product = Provider.of<Product>(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
          onTap: () => Navigator.of(context).pushNamed(
            AppRoutes.PRODUCT_ITEM,
            arguments: product,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          leading: IconButton(
            onPressed: () => product.toggleFavorite(),
            icon: Icon(
              !product.isFavorite ? Icons.favorite_border : Icons.favorite,
 
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          title: AutoSizeText(
            product.title,
            maxFontSize: 16,
            maxLines: 1,
            textAlign: TextAlign.center,
            minFontSize: 10,
            presetFontSizes: const [16, 15, 14, 13, 12, 10],
          ),
          trailing: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.shopping_cart,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
      ),
    );
  }
}
