import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class DBHelper {
  //In order to modularize database access, parameters are stored here for quick access
  //This is the name of the database being made
  static String dbName = "myTime.db";
  //here are the titles of each of the tables being made
  static List<String> tableNames = [
    "blocks_Table",
    "groups_Table",
    "tasks_Table",
    "appointments_Table",
  ];
  //this is the format of each table being made, this is called upon to initialize the database
  static List<String> tableCreate = [
    "CREATE TABLE ${tableNames[0]}(id INT PRIMARY KEY, title TEXT, strtH INT, strtM INT, endH INT, endM INT, d1 INT, d2 INT, d3 INT, d4 INT, d5 INT, d6 INT, d7 INT, group INT)",
    "CREATE TABLE ${tableNames[1]}(id INT PRIMARY KEY, title TEXT)",
    "CREATE TABLE ${tableNames[2]}(id INT PRIMARY KEY, title TEXT, goalD INT, goalM INT, group INT)",
    "CREATE TABLE ${tableNames[3]}(id INT PRIMARY KEY, title TEXT, strtH INT, strtM INT, endH INT, endM INT, dateD INT, dateM INT)",
  ];
  //This returns a future that resolves into a handle for the database. If this is the first use, this initializes the database
  static Future<Database> database() async {
    print("database access");
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, DBHelper.dbName),
      onCreate: (db, version) {
        print("database Initialize");
        // return db.execute("CREATE TABLE blocks_Table(id INT PRIMARY KEY, title TEXT, strtH INT, strtM INT, endH INT, endM INT, d1 INT, d2 INT, d3 INT, d4 INT, d5 INT, d6 INT, d7 INT, group INT)");
        DBHelper.tableCreate.forEach((element) {
          return db.execute(element);
        });
      },
      version: 1,
    );
  }

  //initialize
  static Future<void> initialize() async {
    print("initialize");
    final db = await DBHelper.database();
    //
    print("delete");
    DBHelper.tableNames.forEach((element) {
      try {
      db.delete(element);
      } catch (e) {
      }
    });
    //
    print("add");
    DBHelper.tableCreate.forEach((element) {
      db.execute(element);
    });
  }

  //This adds new data to the database table of choice.
  static Future<void> insert(String table, Map<String, Object> data) async {
    print("insert to table $table");
    final db = await DBHelper.database();
    db.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  //This fetches the data from an entire Table
  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.database();
    return db.query(table);
  }

  //This updates the information stored in a row of a table, functionally the same as insert, (I believe)
  static Future<void> update(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();
    db.update(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }
}
