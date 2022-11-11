import 'package:flutter/material.dart';
import 'package:my_shop/providers/products.dart';
import 'package:my_shop/screens/edit_product_screen.dart';
import 'package:my_shop/widgets/app_drawer.dart';
import 'package:my_shop/widgets/user_product_item.dart';
import 'package:provider/provider.dart';

class UserProductsScreen extends StatelessWidget {

  static const routeName='/userProductsScreen';

  @override
  Widget build(BuildContext context) {
    final productsData=Provider.of<Products>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: [
          IconButton(onPressed: (){
            Navigator.of(context).pushNamed(EditProductScreen.routeName);
          }, icon: const Icon(Icons.add),),
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(itemCount: productsData.items.length, itemBuilder: (ctx, i) => Column(
          children: [
            UserProductItem(
              productsData.items[i].title, productsData.items[i].imageUrl
            ),
            const Divider(),
          ],
        ))
      ),
    );
  }
}
