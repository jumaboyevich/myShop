import 'package:flutter/material.dart';
import 'package:my_shop/providers/orders.dart' show Orders;
import 'package:provider/provider.dart';
import '../widgets/app_drawer.dart';
import '../widgets/order_item.dart';
class OrdersScreen extends StatelessWidget {

  static const routeName='/orders';
  @override
  Widget build(BuildContext context) {

    final ordersData=Provider.of<Orders>(context);

    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: const Text('Your Orders'),
      ),
      body: ListView.builder(itemCount: ordersData.orders.length, itemBuilder: (ctx, i) => OrderItem(ordersData.orders[i])),
    );
  }
}
