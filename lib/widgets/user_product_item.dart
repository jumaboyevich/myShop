import 'package:flutter/material.dart';

class UserProductItem extends StatelessWidget {

  String title;
  String imgUrl;


  UserProductItem(this.title, this.imgUrl);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imgUrl),
      ),
      title: Text(title),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(onPressed: (){}, icon: Icon(Icons.edit, color: Theme.of(context).primaryColor,)),
            IconButton(onPressed: (){}, icon: Icon(Icons.delete, color: Theme.of(context).errorColor,))
          ],
        ),
      ),
    );
  }
}
