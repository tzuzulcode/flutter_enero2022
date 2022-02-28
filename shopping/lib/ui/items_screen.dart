import 'package:flutter/material.dart';

import "../models/list_item.dart";
import "../models/shopping_list.dart";
import '../util/dbhelper.dart';


class ItemsScreen extends StatefulWidget {
  const ItemsScreen(this.shoppingList);

  final ShoppingList shoppingList;

  @override
  _ItemsScreenState createState() => _ItemsScreenState(shoppingList);
}

class _ItemsScreenState extends State<ItemsScreen> {
  final ShoppingList shoppingList;

  _ItemsScreenState(this.shoppingList);

  late DbHelper helper;
  List<ListItem> items = [];

  @override
  Widget build(BuildContext context) {

    helper = DbHelper();
    showData();

    return Scaffold(
      appBar: AppBar(title: Text(shoppingList.name),),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index){
          return ListTile(
            title: Text(items[index].name),
            subtitle: Text("Quantity: ${items[index].quantity} - Note: ${items[index].note}"),
            trailing: IconButton(icon: 
              Icon(Icons.edit),
              onPressed: (){},
            ),
          );
        },
      ),
    );
  }

  Future showData()async{
    await helper.openDb();
    items = await helper.getItems(shoppingList.id);

    setState(() {
      items = items;
    });
  }
}