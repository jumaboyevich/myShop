import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_shop/providers/orders.dart' as ord;

class OrderItem extends StatefulWidget {

  late ord.OrderItem orderItem;

  OrderItem(this.orderItem);

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _expanded=false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          ListTile(
            title: Text('\$${widget.orderItem.totalAmount}'),
            subtitle: Text(DateFormat('dd.MM.yyyy hh:mm').format(widget.orderItem.dateTime)),
            trailing: IconButton(
              icon: Icon(_expanded ? Icons.expand_less:Icons.expand_more), onPressed: () {
                setState(() {
                  _expanded=!_expanded;
                });
            },
            ),
          ),
          if(_expanded)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              height: min(widget.orderItem.items.length *20.0 +100, 180),
              child: ListView(
                children: widget.orderItem.items.map((prod) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(prod.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                    Text('${prod.quantity} x \$${prod.price}', style: const TextStyle(fontSize: 18, color: Colors.grey),)

                  ],
                )).toList(),
              ),

            )
        ],
      ),

    );
  }
}
