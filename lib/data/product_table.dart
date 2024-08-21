import 'package:sqflite/sqflite.dart';

class ProductTable {
  static Future<void> createTable(Database db) async {
    await db.execute('''
      CREATE TABLE Product(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        sandwichName TEXT NOT NULL,
        price REAL NOT NULL
      )
    ''');
  }
}