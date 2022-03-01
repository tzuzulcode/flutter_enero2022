import 'package:path/path.dart';
import 'package:shopping/models/list_item.dart';
import 'package:shopping/models/shopping_list.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper{
  final int version = 1;
  Database? db;

  //Si ya existe una instancia de la clase, devuelve la misa
  static final DbHelper _dbHelper = DbHelper._internal();
  DbHelper._internal();
  factory DbHelper(){
    return _dbHelper;
  }

  Future openDb() async{
    db ??= await openDatabase(
        join( await getDatabasesPath(),"shopping.db"),
        onCreate: (database,version){
          database.execute("CREATE TABLE lists(id INTEGER PRIMARY KEY, name TEXT,priority INTEGER)");
          database.execute("CREATE TABLE items(id INTEGER PRIMARY KEY,idList INTEGER, name TEXT,quantity TEXT, note TEXT, FOREIGN KEY(idList) REFERENCES lists(id))");
        }, version: version);
  }

  Future testDb() async{
    await openDb();
    await db?.execute('INSERT INTO lists VALUES(0,"Fruit",2)');
    await db?.execute('INSERT INTO items VALUES(0,0,"Apples","2 unidades","Comprar frescas")');

    List? lists = await db?.rawQuery("SELECT * FROM lists");
    List? items = await db?.rawQuery("SELECT * FROM items");

    print(lists![0].toString());
    print(items![0].toString());

  }

  Future<List<ShoppingList>> getLists()async{
    List<Map<String,dynamic>>? maps = await db?.query("lists");

    return List.generate(maps!.length, 
      (i) => ShoppingList(
        maps[i]['id'], 
        maps[i]['name'], 
        maps[i]['priority'])
      );

  }

  Future<List<ListItem>> getItems(int idList)async{
    List<Map<String,dynamic>>? maps = await db?.query("items",where: "idList=?",whereArgs: [idList]);

    return List.generate(maps!.length, 
      (i) => ListItem(
        maps[i]['id'],
        maps[i]['idList'],
        maps[i]['name'], 
        maps[i]['quantity'],
        maps[i]['note']
        )
      );

  }

  Future insertList(ShoppingList list)async{
    int? id = await db?.insert("lists", list.toMap(),conflictAlgorithm: ConflictAlgorithm.replace);
    
    return id!;
  } 
  Future insertItem(ListItem item)async{
    int? id = await db?.insert("items", item.toMap(),conflictAlgorithm: ConflictAlgorithm.replace);
    
    return id!;
  } 

  Future deleteList(ShoppingList list) async{
    int? result = await db?.delete("items",where: "idList = ?",whereArgs:[list.id]);

    result = await db?.delete("lists",where: "id= ?",whereArgs: [list.id]);

    return result;
  }

}