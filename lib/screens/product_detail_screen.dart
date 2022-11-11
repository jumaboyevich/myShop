import 'package:flutter/material.dart';
import 'package:my_shop/providers/products.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget {


  static const routeName='/product_detail';

  @override
  Widget build(BuildContext context) {
    final productId=ModalRoute.of(context)?.settings.arguments as String;
    final loadedProduct= Provider.of<Products>(context, listen: false).findById(productId);

    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                loadedProduct.imageUrl, fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10,),
            Text('\$${loadedProduct.price}', style: const TextStyle(color: Colors.grey),),
            const SizedBox(height: 10,),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                loadedProduct.description, textAlign: TextAlign.center, softWrap: true,
              ),
            )
          ],
        ),
      ),
    );
  }
}
