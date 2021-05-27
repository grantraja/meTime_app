import 'package:sqflite/sqflite.dart';
import 'package:package_info/package_info.dart';
import 'dart:async';

class DBHelper {
  static DBHelper _dBHelper;
  static Database _database;

  List<String> tableInitComs;

  DBHelper._createInstance();

  factory DBHelper() {
    print("DBHelper Constructor: Init Called");
    if (_dBHelper == null) {
      _dBHelper = DBHelper._createInstance();
      print("First Run");
    } else {
      print("Not First Run");
    }
    return _dBHelper;
  }

  void passTableInitComs(List<String> coms) {
    print("DBHelper passTIC: recieves coms");
    this.tableInitComs = coms;
  }

  Future<Database> initDB() async {
    //Create DB name and Find DB Path
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    final String dbName = packageInfo.appName + ".db";
    final String dbPath = await getDatabasesPath() + dbName;
    print("Database Name: $dbName");
    print("Database Path: $dbPath");
    //Open/Create Database
    var database = await openDatabase(dbPath, version: 2, onCreate: createDB);

    print("DBHelper initDB: Finished");
    return database;
  }

  //Create DataBase
  void createDB(Database db, int newVersion) async {
    print("DBHelper CreaeteDB: onCreate Called");
    this.tableInitComs.forEach((element) async {
      await db.execute(element);
      print("DBHelper CreaeteDB: Table Created");
    });
    print("DBHelper CreaeteDB: DATABASE Created");
  }

  //Access DataBase
  Future<Database> get database async {
    print("database access");
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

  //Delete Map
  Future<int> deleteMap(
      {Map<String, dynamic> newMap, int id, String tableName}) async {
    Database db = await this.database;
    int result = await db.rawDelete('DELETE FROM $tableName WHERE id = $id');
    return result;
  }

  // Get number of Map objects in database
  Future<int> getCount({String tableName}) async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $tableName');
    int result = Sqflite.firstIntValue(x);
    return result;
  }
}
