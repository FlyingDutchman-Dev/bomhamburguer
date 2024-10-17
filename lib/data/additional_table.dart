import 'package:bomhamburguer/model/additional.dart';
import 'package:sqflite/sqflite.dart';
import 'database.dart';

class AdditionalTable {
  // Método para criar a tabela de adicional
  static Future<void> createTable(Database db) async {
    await db.execute('''
      CREATE TABLE Additional(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        addName TEXT NOT NULL,
        price REAL NOT NULL,
        imagePath TEXT NOT NULL
      )
    ''');
    print('Tabela Additional criada');
  }

  // Método para adicionar um adicional de produto ao banco de dados
  static Future<int> insertAdditional(Additional add) async {
    Database db = await DatabaseHelper().database;

    int result = await db.insert(
      'Additional',
      {
        'addName': add.addName,
        'price': add.price,
        'imagePath': add.imagePath,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    print("Insert Additional");

    return result;
  }

  // Método para recuperar os produtos
  static Future<List<Additional>> getAllAdditional() async {
    Database db = await DatabaseHelper().database;
    final List<Map<String, dynamic>> maps = await db.query('Additional');

    return List.generate(maps.length, (i) {
      return Additional(
        id: maps[i]['id'],
        addName: maps[i]['sandwichName'],
        price: maps[i]['price'],
        imagePath: maps[i]['imagePath'],
      );
    });
  }

  // Método para verificar se a tabela Additional existe
  static Future<bool> checkIfTableExists() async {
    Database db = await DatabaseHelper().database;

    var result = await db.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='table' AND name='Additional';"
    );

    print('Resultado da verificação da tabela: $result');

    return result.isNotEmpty;
  }

  // Função para deletar todos os adicionais da tabela Additional
  static Future<void> clearAdditionalTable() async {
    Database db = await DatabaseHelper().database;
    await db.delete('Additional');
  }
}