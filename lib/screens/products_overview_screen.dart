import 'package:flutter/material.dart';
import 'package:my_shop/widgets/app_drawer.dart';
import 'package:my_shop/screens/cart_screen.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import '../widgets/badge.dart';
import '../widgets/products_grid.dart';

enum FilterOptions { Favorites, All }

class ProductsOverviewScreen extends StatefulWidget {
  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showFavorite = false;

  @override
  Widget build(BuildContext context) {
    // final productsContainer = Provider.of<Products>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyShop'),
        actions: [
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (FilterOptions.Favorites == selectedValue) {
                  _showFavorite = true;
                } else if (FilterOptions.All == selectedValue) {
                  _showFavorite = false;
                }
              });
            },
            icon: const Icon(Icons.more_vert),
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: FilterOptions.Favorites,
                child: Text('Only Favorites'),
              ),
              const PopupMenuItem(
                value: FilterOptions.All,
                child: Text('Show all'),
              ),
            ],
          ),
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(

              value: cart.itemCount.toString(),
              color: Colors.red,
              child: ch!,
            ),
            child: IconButton(
              onPressed: () {Navigator.of(context).pushNamed(CartScreen.routeName);},
              icon: const Icon(Icons.shopping_cart),
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: ProductsGrid(_showFavorite),
    );
  }
}
