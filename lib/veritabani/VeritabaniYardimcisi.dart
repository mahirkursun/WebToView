import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:webviewapp/link.dart';

class DatabaseHelper {
  static final _databaseName = "rehber.sqlite";
  static final _databaseVersion = 1;

  static final table = 'webview';

  static final columnId = 'id';
  static final columnTitle = 'link';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnTitle FLOAT NOT NULL
          )
          ''');
  }

  Future<int> insert(Link link) async {
    Database db = await instance.database;
    var res = await db.insert(table, link.toMap());
    return res;
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    var res = await db.query(table, orderBy: "$columnTitle DESC");
    return res;
  }

  Future<dynamic> delete() async {
    Database db = await instance.database;

    return await db.rawQuery("DELETE FROM webview ");
  }

  Future<dynamic> kayitKontrol() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> maps =
        await db.rawQuery("SELECT link FROM webview ");

    return maps[0]["link"];
  }
}
