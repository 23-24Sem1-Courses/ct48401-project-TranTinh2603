import 'package:flutter/foundation.dart';

import '../../models/cart_item.dart';
import '../../models/product.dart';

class CartManager with ChangeNotifier {
  late Map<String, CartItem> _items = {};

  List<CartItem> get products {
    return _items.values.toList();
  }

  int get productCount {
    return _items.length;
  }

  Iterable<MapEntry<String, CartItem>> get productEntries {
    return {..._items}.entries;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(Product product) {
    if (_items.containsKey(product.id)) {
      _items.update(
        product.id!,
        (existingCartItem) => existingCartItem.copyWith(
          quantity: existingCartItem.quantity + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
        product.id!,
        () => CartItem(
          id: 'c${DateTime.now().toIso8601String()}',
          name: product.name,
          price: product.price,
          imageUrl: product.imageUrl,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId]?.quantity as num > 1) {
      _items.update(
        productId,
        (existingCartItem) => existingCartItem.copyWith(
          quantity: existingCartItem.quantity - 1,
        ),
      );
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  void clearItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clearAllItems() {
    _items = {};
    notifyListeners();
  }
}
