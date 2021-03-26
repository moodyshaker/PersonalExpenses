import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:personal_expenses/model/transaction.dart';
import 'package:sqflite/sqflite.dart';

class ExpensesDatabase {
  static final ExpensesDatabase instance = ExpensesDatabase._instance();
  static const String TABLE_NAME = 'expenses_review';
  static const String ID = '_id';
  static const String TITLE = 'title';
  static const String DATE = 'date';
  static const String AMOUNT = 'amount';
  static const String USER_ID = 'user_id';
  static const int VERSION = 1;
  static Database _db;

  ExpensesDatabase._instance();

  Future<Database> get db async {
    if (_db == null) {
      _db = await _initDatabase();
    }
    return _db;
  }

  Future<Database> _initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, TABLE_NAME);
    Database db =
        await openDatabase(path, onCreate: _createDB, version: VERSION);
    return db;
  }

  Future<void> _createDB(Database db, int version) {
    db.execute(
      """
      CREATE TABLE $TABLE_NAME(
      $ID INTEGER PRIMARY KEY AUTOINCREMENT,
      $TITLE TEXT NOT NULL,
      $DATE TEXT NOT NULL,
      $AMOUNT REAL NOT NULL,
      $USER_ID TEXT NOT NULL)
    """,
    );
  }

  Future<void> insert(TransactionModel item) async {
    Database database = await db;
    await database.insert(
      TABLE_NAME,
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> update(TransactionModel item) async {
    Database database = await db;
    await database.update(
      TABLE_NAME,
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
      where: "_id = ?",
      whereArgs: [item.id],
    );
  }

  Future<void> deleteAll() async {
    Database database = await db;
    database.rawDelete('DELETE FROM $TABLE_NAME');
  }

  Future<void> delete(TransactionModel item) async {
    Database database = await db;
    await database.delete(
      TABLE_NAME,
      where: '_id = ?',
      whereArgs: [item.id],
    );
  }

  Future<List<TransactionModel>> getData(String userId) async {
    Database database = await db;
    List<Map<String, dynamic>> data = await database.query(
      TABLE_NAME,
      where: 'user_id = ?',
      whereArgs: [userId],
    );
    List<TransactionModel> models = [];
    data.forEach((i) => models.add(TransactionModel.fromMap(i)));
    return models;
  }

  Future<void> closeDB() async {
    Database database = await db;
    await database.close();
    _db = null;
  }
}
