import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  ProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      child: GridTile(
        footer: GridTileBar(
          title: Text(title),
          backgroundColor: Colors.black87,
          trailing: IconButton(
            color: Theme.of(context).accentColor,
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {},
          ),
          leading: IconButton(
            color: Theme.of(context).accentColor,
            icon: const Icon(Icons.favorite),
            onPressed: () {},
          ),
        ),
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
