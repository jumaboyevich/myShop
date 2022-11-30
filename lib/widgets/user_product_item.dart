import 'package:flutter/material.dart';
import 'package:my_shop/providers/products.dart';
import 'package:my_shop/screens/edit_product_screen.dart';
import 'package:provider/provider.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imgUrl;


  UserProductItem(this.id, this.title, this.imgUrl);

  @override
  Widget build(BuildContext context) {
    final scaffold=ScaffoldMessenger.of(context);
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imgUrl),
      ),
      title: Text(title),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: [
            IconButton(onPressed: (){
              Navigator.of(context).pushNamed(EditProductScreen.routeName, arguments: id);
            }, icon: Icon(Icons.edit, color: Theme.of(context).primaryColor,)),
            IconButton(onPressed: () async {
              try {
               await Provider.of<Products>(context, listen: false).deleteProduct(id);
              }catch(error){
                scaffold.showSnackBar(SnackBar(content: Text('Deleting failed', textAlign: TextAlign.center,), ));
              }
              }, icon: Icon(Icons.delete, color: Theme.of(context).errorColor,))
          ],
        ),
      ),
    );
  }
}
