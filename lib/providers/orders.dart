import 'dart:convert';

import 'package:flutter/cupertino.dart';
import './cart.dart';
import 'package:http/http.dart' as http;

class OrderItem {
  late String id;
  late double totalAmount;
  late List<CartItemNote> items;
  late DateTime dateTime;

  OrderItem(
      {required this.id,
      required this.totalAmount,
      required this.items,
      required this.dateTime});
}

class Orders extends ChangeNotifier {
  List<OrderItem> _items = [];

  List<OrderItem> get orders {
    return [..._items];
  }

  String _token;
  String _userId;

  Orders(this._token, this._userId, this._items);

  Future<void> fetchAndSetOrders() async {
    final url =
        'https://flutter-update-99f2b-default-rtdb.firebaseio.com/orders/$_userId.json?auth=$_token';

    List<OrderItem> ordersList = [];
    final response = await http.get(Uri.parse(url));

    final responseData = jsonDecode(response.body) as Map<String, dynamic>;
    responseData.forEach((id, value) {
      ordersList.add(
        OrderItem(
          id: id,
          totalAmount: value['totalAmount'],
          items: (value['products'] as List<dynamic>)
              .map(
                  (item) => CartItemNote(
                  id: item['id'],
                  price: item['price'],
                  quantity: item['quantity'],
                  title: item['title']))
              .toList(),
          dateTime: DateTime.parse(
            value['dateTime'],
          ),
        ),
      );
    });
    _items=ordersList.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(
      List<CartItemNote> cartProducts, double totalPrice) async {
    final url =
        'https://flutter-update-99f2b-default-rtdb.firebaseio.com/orders/$_userId.json?auth=$_token';

    final response = await http.post(Uri.parse(url),
        body: json.encode({
          'totalAmount': totalPrice,
          'dateTime': DateTime.now().toIso8601String(),
          'products': cartProducts
              .map((cp) => {
                    'id': cp.id,
                    'title': cp.title,
                    'price': cp.price,
                    'quantity': cp.quantity,
                  })
              .toList(),
        }));
    _items.insert(
        0,
        OrderItem(
            id: json.decode(response.body)['name'],
            totalAmount: totalPrice,
            items: cartProducts,
            dateTime: DateTime.now()));
    notifyListeners();
  }
}
