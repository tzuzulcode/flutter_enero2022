import 'package:flutter/material.dart';
import 'package:shopping/ui/items_screen.dart';
import 'package:shopping/util/dbhelper.dart';
import 'package:shopping/models/list_item.dart';
import 'package:shopping/models/shopping_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(title: Text("Shopping List"),),
        body:ShList()
      )
    );
  }
}


class ShList extends StatefulWidget {
  const ShList({ Key? key }) : super(key: key);

  @override
  _ShListState createState() => _ShListState();
}

class _ShListState extends State<ShList> {

  DbHelper helper = DbHelper();

  List<ShoppingList> shoppingList = [];


  @override
  Widget build(BuildContext context) {
    showData();
    return ListView.builder(
      itemCount: (shoppingList!= null)?shoppingList.length:0,
      itemBuilder: (BuildContext context, int index){
        return ListTile(
          title: Text(shoppingList[index].name),
          leading: CircleAvatar(child: Text(shoppingList[index].priority.toString()),),
          trailing: IconButton(icon: 
            Icon(Icons.edit),
            onPressed: (){},
          ),
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>ItemsScreen(shoppingList[index])));
          },
        );
      },
    );
  }


  Future showData()async{
    await helper.openDb();
    shoppingList = await helper.getLists();

    setState(() {
      shoppingList = shoppingList;
    });
    // ShoppingList list = ShoppingList(0,"Panaderia",2);
    // int listId = await helper.insertList(list);

    // ListItem item= ListItem(0, listId, "Pan dulce", "5 unidades", "Pan recien horneado");
    // int itemId = await helper.insertItem(item);

    // print("List Id ${listId.toString()}");
    // print("Item Id ${itemId.toString()}");
  }
}
