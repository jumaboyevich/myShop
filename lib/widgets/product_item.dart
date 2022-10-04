

import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  ProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return GridTile(
        child: Image.network(imageUrl, fit: BoxFit.cover,),
        footer: GridTileBar(
        title: Text(title),
        backgroundColor: Colors.black54,
        trailing: IconButton(
          icon: const Icon(Icons.shopping_cart), onPressed: () {  },
        ),
        leading: IconButton(
        icon: const Icon(Icons.favorite), onPressed: () {  },
        ),
    ),
    );
  }
}
