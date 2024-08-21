import 'package:sqflite/sqflite.dart';
import 'database.dart';

class ProductTable {
  static Future<void> createTable(Database db) async {
    await db.execute('''
      CREATE TABLE Product(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        sandwichName TEXT NOT NULL,
        price REAL NOT NULL
      )
    ''');
    print('Tabela Product criada');
  }
  // Método para verificar se a tabela Product existe
  static Future<bool> checkIfTableExists() async {
    Database db = await DatabaseHelper().database;

    var result = await db.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='table' AND name='Product';"
    );

    print('Resultado da verificação da tabela: $result');

    return result.isNotEmpty;
  }
}