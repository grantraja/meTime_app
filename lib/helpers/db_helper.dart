import 'package:sqflite/sqflite.dart';
import 'package:package_info/package_info.dart';
import 'dart:async';


class DBHelper {
  final List<String> tableInitComs;
  static Database _database;
  DBHelper(this.tableInitComs);

  Future<Database> initDB() async {
    //Create DB name and Find DB Path
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    final String dbName = packageInfo.appName + ".db";
    final String dbPath = await getDatabasesPath();
    print("Database Name: $dbName");
    print("Database Path: $dbPath");
    //Open/Create Database
    Database database =
        await openDatabase(dbPath, version: 1, onCreate: createDB);
    print("DATABASE INITIALIZED");
    return database;
  }

  //Create DataBase
  void createDB(Database db, int newVersion) async {
    this.tableInitComs.forEach((element) async {
      await db.execute(element);
      print("Table Created");
    });
    print("DATABASE Created");
  }

  //Access DataBase
  Future<Database> get database async {
    if (_database == null) {
      _database = await initDB();
    }
    return _database;
  }

  //Fetch Table Values from DataBase
  Future<List<Map<String, dynamic>>> fetchTableValues(String tableName) async {
    Database db = await this.database;
    List<Map<String, dynamic>> tableValues = await db.query(tableName);
    return tableValues;
  }

  //Insert Map
  Future<int> insertMap({Map<String, dynamic> newMap, String tableName}) async {
    Database db = await this.database;
    int result = await db.insert(tableName, newMap);
    return result;
  }

  //Delete Note
  Future<int> deleteNote(
      {Map<String, dynamic> newMap, int id, String tableName}) async {
    Database db = await this.database;
    int result = await db.rawDelete('DELETE FROM $tableName WHERE id = $id');
    return result;
  }

  // Get number of Note objects in database
  Future<int> getCount({String tableName}) async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $tableName');
    int result = Sqflite.firstIntValue(x);
    return result;
  }
}
