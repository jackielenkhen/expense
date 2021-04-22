import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class DBHelper {
  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'expense.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE expense (id TEXT PRIMARY KEY ,title TEXT NOT NULL,amount DOUBLE NOT NULL,date DATETIME NOT NULL)');
    }, version: 1);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();
    db.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.database();
    return db.query(table);
  }

   static Future<int> db_execute(String sql) async {
    final db = await DBHelper.database();
    int result = await db.rawInsert(sql);
    return result;
  }

   static Future<int> db_delete(String sql) async {
    final db = await DBHelper.database();
    int result = await db.rawDelete(sql);
    return result;
  }

   static Future<List<Map<String, dynamic>>> db_get(String sql) async {
    final db = await DBHelper.database();
    var result =  await db.rawQuery(sql);
    return result;
  }

  
}
