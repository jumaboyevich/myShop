import 'package:flutter/material.dart';
import 'package:my_shop/providers/product.dart';
import 'package:my_shop/screens/product_detail_screen.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);

    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      child: GridTile(
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          title: Text(product.title),
          leading: IconButton(
            color: Colors.red,
            icon: Icon(
                product.isFavorite ? Icons.favorite : Icons.favorite_border),
            onPressed: () {
              product.toggleFavoriteStatus();
            },
          ),
          trailing: IconButton(
            color: Colors.red,
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              cart.addItem(product.id, product.price, product.title);
              ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                content: const Text("Added item to cart"),
                duration: const Duration(seconds: 2),
                action: SnackBarAction(
                  label: 'UNDO',
                  onPressed: () {
                    cart.removeSingleItem(product.id);
                  },
                ),
              ));
            },
          ),
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(ProductDetailScreen.routeName,
                arguments: product.id);
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

// child: GridTile(
// footer: GridTileBar(
// title: Text(title),
// backgroundColor: Colors.black87,
// trailing: IconButton(
// color: Theme.of(context).accentColor,
// icon: const Icon(Icons.shopping_cart),
// onPressed: () {},
// ),
// leading: IconButton(
// color: Theme.of(context).accentColor,
// icon: const Icon(Icons.favorite),
// onPressed: () {},
// ),
// ),
// child: Image.network(
// imageUrl,
// fit: BoxFit.cover,
// ),
// ),
