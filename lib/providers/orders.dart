

import 'package:flutter/cupertino.dart';
import './cart.dart';

class OrderItem{
  late String id;
  late double totalAmount;
  late List<CartItemNote> items;
  late DateTime dateTime;

  OrderItem({required this.id, required this.totalAmount, required this.items, required this.dateTime});
}

class Orders extends ChangeNotifier{

  final List<OrderItem> _items=[];

  List<OrderItem> get orders{
    return [..._items];
  }
  
  void addOrder(List<CartItemNote> cartProducts, double totalPrice){
    _items.insert(0, OrderItem(id: DateTime.now().toString(), totalAmount: totalPrice, items: cartProducts, dateTime: DateTime.now()));
 notifyListeners();
  }
}