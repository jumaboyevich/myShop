import 'package:flutter/material.dart';
import 'package:my_shop/providers/product.dart';
import 'package:my_shop/screens/product_detail_screen.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../providers/cart.dart';

class ProductItem extends StatelessWidget {
  // final String id;

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    final auth = Provider.of<Auth>(context, listen: false);
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      child: GridTile(
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          title: Text(product.title),
          leading: Consumer<Product>(
            builder: (ctx, product, _) => IconButton(
              color: Colors.red,
              icon: Icon(
                  product.isFavorite ? Icons.favorite : Icons.favorite_border),
              onPressed: () {
                product.toggleFavoriteStatus(auth.token, auth.userId);
              },
            ),
          ),
          trailing: IconButton(
            color: Colors.red,
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              cart.addItem(product.id.toString(), product.price, product.title);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: const Text("Added item to cart"),
                duration: const Duration(seconds: 2),
                action: SnackBarAction(
                  label: 'UNDO',
                  onPressed: () {
                    cart.removeSingleItem(product.id.toString());
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
            child: Hero(
              tag: product.id,
              child: FadeInImage(
                placeholder: const AssetImage('assets/product-placeholder.png'),
                image: NetworkImage(
                  product.imageUrl,
                ),
                fit: BoxFit.cover,
              ),
            )),
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
