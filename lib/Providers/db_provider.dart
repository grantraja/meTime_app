import '../helpers/db_helper.dart';
import '../Models/block.dart';

class DBProvider {
  DBHelper dbHelper;
  void innitializeDBHelper() {
    print("DBProvider: Init Begins");
    final List<String> dbTableInitComs = [
      Block.dbTableForm,
    ];
    dbHelper = DBHelper();
    dbHelper.passTableInitComs(dbTableInitComs);
    //dbHelper.tableInitComs = dbTableInitComs;
    //await dbHelper.initDB();
  }
}
