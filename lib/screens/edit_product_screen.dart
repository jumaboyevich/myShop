import 'package:flutter/material.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName='/edit-product';

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
      ),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(label: Text('Title')),
                textInputAction: TextInputAction.next,
              )
            ],
          ),
        ),
      ),
    );
  }
}
