import 'package:flutter/material.dart';
import 'package:shopping/models/shopping_list.dart';
import 'package:shopping/util/dbhelper.dart';

class ShoppingListDialog{
  final textName = TextEditingController();
  final textPriority = TextEditingController();

  Widget buildDialog(BuildContext context, ShoppingList list,bool isNew){
    DbHelper helper = DbHelper();
    if(!isNew){
      textName.text = list.name;
      textPriority.text = list.priority.toString();
    }
    return AlertDialog(
      title: Text(isNew?"New shopping list":"Edit shoppinhg list"),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      content: SingleChildScrollView(
        child: Column(children: [
          TextField(controller: textName,
            decoration:InputDecoration(
              hintText: "Shopping list name..."
            )
          ),
          TextField(controller: textPriority,
            keyboardType: TextInputType.number,
            decoration:InputDecoration(
              hintText: "Shopping list priority..."
            )
          ),
          ElevatedButton(onPressed: (){
            list.name = textName.text;
            list.priority = int.parse(textPriority.text);
            helper.insertList(list);
            Navigator.pop(context);
          }, child: Text("Save"))
        ],),
        
      ),
    );
  }
}