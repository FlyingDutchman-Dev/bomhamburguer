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
        price REAL NOT NULL
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
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    // Obter todos os produtos após a inserção e imprimir
    List<Product> allProducts = await getAllProducts();
    for (var prod in allProducts) {
      print('ID: ${prod.id}, Name: ${prod.sandwichName}, Price: ${prod.price}');
    }

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
}