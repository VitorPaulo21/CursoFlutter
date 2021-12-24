import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:shop/models/cart_item.dart';
import 'package:shop/models/product.dart';

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  int get itemsCount {
    return _items.length;
  }

  void addItem(Product? product) {
    if (product == null) {
      return;
    }
    if (_items.containsKey(product.id)) {
      _items.update(product.id,
          (existent) => existent.copyWith(quantity: existent.quantity + 1));
    } else {
      _items.putIfAbsent(
        product.id,
        () => CartItem(
          id: Random().nextDouble().toString(),
          productId: product.id,
          name: product.title,
          quantity: 1,
          price: product.price,
        ),
      );
    }
    notifyListeners();
  }

  void reduceItem(Product? product) {
    if (product == null) {
      notifyListeners();
      return;
    }
    if (_items.containsKey(product.id)) {
      if (_items[product.id]!.quantity == 1) {
        removeItem(product.id);
        notifyListeners();
        return;
      }
      _items.update(product.id, (existent) {
        return existent.copyWith(quantity: existent.quantity - 1);
      });
    }
    notifyListeners();
  }

  Map<String, CartItem> get items {
    return {..._items};
  }
  double get totalAmount {
    double total = 0;
    _items.forEach((key, value) {
      total += value.price * value.quantity;
    });
    return total;
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
