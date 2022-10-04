import 'package:flutter/material.dart';
import 'package:my_shop/screens/products_overview_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyShop',
      theme: ThemeData(
        accentColor: Colors.deepOrange,
        primarySwatch: Colors.blue,
        fontFamily: 'Lato'
      ),
      home: ProductsOverviewScreen(),
    );
  }
}
