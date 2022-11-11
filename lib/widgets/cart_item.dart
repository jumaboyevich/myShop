import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String title;

  CartItem(this.id, this.productId, this.price, this.quantity, this.title);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      onDismissed: (directions) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      confirmDismiss: (direction) => showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text('Are you sure?'),
                content: const Text('Do you want remove this item?'),
                actions: [
                  TextButton(onPressed: () {
                    Navigator.of(context).pop(false);
                  }, child: const Text('No')),
                  TextButton(onPressed: () {
                    Navigator.of(context).pop(true);
                  }, child: const Text('Yes')),
                ],
              )),
      direction: DismissDirection.endToStart,
      background: Container(
        padding: const EdgeInsets.only(right: 8.0),
        alignment: Alignment.centerRight,
        color: Colors.red,
        margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 4),
        child: const Icon(
          Icons.delete,
          size: 40,
        ),
      ),
      key: Key(id),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 4),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: CircleAvatar(
              child: FittedBox(child: Text('\$$price')),
            ),
            title: Text(title),
            subtitle: Text('Total: \$${(quantity * price).toStringAsFixed(2)}'),
            trailing: Text('$quantity x'),
          ),
        ),
      ),
    );
  }
}
