import 'package:flutter/cupertino.dart';

class CartItemNote {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItemNote(
      {required this.id,
      required this.title,
      required this.quantity,
      required this.price});
}

class Cart with ChangeNotifier {
  Map<String, CartItemNote> _items = {};

  Map<String, CartItemNote> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, value) {
      total += value.price * value.quantity;
    });
    return total;
  }

  void addItem(String productId, double price, String title) {
    if (_items.containsKey(productId)) {
      //...change quantity
      _items.update(
          productId,
          (existingCartItem) => CartItemNote(
              id: existingCartItem.id,
              title: existingCartItem.title,
              quantity: existingCartItem.quantity + 1,
              price: existingCartItem.price));
    } else {
      _items.putIfAbsent(
          productId,
          () => CartItemNote(
              id: DateTime.now().toString(),
              title: title,
              quantity: 1,
              price: price));
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(String productId){
    if(!_items.containsKey(productId))
    {  return;}

    if(_items[productId]!.quantity > 1){
      _items.update(productId, (existProduct) => CartItemNote(id: existProduct.id, title: existProduct.title, quantity: existProduct.quantity-1, price: existProduct.price));
    }else{
      _items.remove(productId);
    }
    notifyListeners();
  }

  void clear(){
    _items={};
    notifyListeners();
  }
}
