import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper{
  final int version = 1;
  Database? db;

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
}