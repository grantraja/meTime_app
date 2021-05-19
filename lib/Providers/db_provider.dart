import '../helpers/db_helper.dart';
import '../Models/block.dart';

class DBProvider {
  DBHelper dbHelper;

  DBProvider() {
    final List<String> dbTableInitComs = [
      Block.dbTableForm,
    ];
    dbHelper = DBHelper(dbTableInitComs);
    dbHelper.initDB();
  }
}
