import 'package:flutter/cupertino.dart';
import 'package:shop/data/dummy_data.dart';
import 'package:shop/models/product.dart';

class ProductList with ChangeNotifier {
  List<Product> _products = DUMMY_PRODUCTS;

  List<Product> get products => [..._products];
  List<Product> get favoriteProducts =>
      _products.where((element) => element.isFavorite).toList();
int get itemCount {
    return _products.length;
  }
  void addProduct(Product product) {
    _products.add(product);
    notifyListeners();
  }
}
