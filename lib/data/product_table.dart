import 'package:bomhamburguer/model/product.dart';
import 'package:sqflite/sqflite.dart';
import 'database.dart';

class ProductTable {
  // Método para criar a tabela de produto
  static Future<void> createTable(Database db) async {
    await db.execute('''
      CREATE TABLE Product(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        sandwichName TEXT NOT NULL,
        price REAL NOT NULL,
        imagePath TEXT NOT NULL
      )
    ''');
    print('Tabela Product criada');
  }

  // Método para adicionar um produto ao banco de dados
  static Future<int> insertProduct(Product product) async {
    Database db = await DatabaseHelper().database;

    int result = await db.insert(
      'Product',
      {
        'sandwichName': product.sandwichName,
        'price': product.price,
        'imagePath': product.imagePath,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    print("Insert Prod");

    return result;
  }

  // Método para recuperar os produtos
  static Future<List<Product>> getAllProducts() async {
    Database db = await DatabaseHelper().database;
    final List<Map<String, dynamic>> maps = await db.query('Product');

    return List.generate(maps.length, (i) {
      return Product(
        id: maps[i]['id'],
        sandwichName: maps[i]['sandwichName'],
        price: maps[i]['price'],
        imagePath: maps[i]['imagePath'],
      );
    });
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

  // Função para deletar todos os produtos da tabela Product
  static Future<void> clearProductTable() async {
    Database db = await DatabaseHelper().database;
    await db.delete('Product');
  }
}