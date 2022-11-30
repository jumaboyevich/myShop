import 'package:flutter/material.dart';
import 'package:my_shop/providers/orders.dart' show Orders;
import 'package:provider/provider.dart';
import '../widgets/app_drawer.dart';
import '../widgets/order_item.dart';
class OrdersScreen extends StatelessWidget {

  static const routeName='/orders';


  var _isLoading = false;

  @override
  Widget build(BuildContext context) {

    // final ordersData=Provider.of<Orders>(context);

    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: const Text('Your Orders'),
      ),
      body: FutureBuilder(future: Provider.of<Orders>(context, listen: false).fetchAndSetOrders(), builder: (ctx, dataSnapshot) {
        if(dataSnapshot.connectionState == ConnectionState.waiting){
          return const Center(child: CircularProgressIndicator(),);
        }else{
          if(dataSnapshot.error!=null){
            return const Center(child: Text('An error occurred'));
          }else{
            return Consumer<Orders>(builder: (ctx, ordersData, child)=> ListView.builder(itemCount: ordersData.orders.length, itemBuilder: (ctx, i) => OrderItem(ordersData.orders[i])));
          }
        }
      })
    );
  }
}
