import 'package:bomhamburguer/data/product_table.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  // Factory constructor para garantir apenas uma instância de DatabaseHelper
  factory DatabaseHelper() {
    return _instance;
  }

  // Construtor nomeado interno
  DatabaseHelper._internal();

  // Método para inicializar o banco de dados
  Future<Database> initDatabase() async {
    if (_database != null) return _database!;

    // Caminho para o banco de dados
    String path = join(await getDatabasesPath(), 'bomhamburguer.db');

    // Abre o banco de dados
    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // Aqui criamos as tabelas
        await ProductTable.createTable(db);
      },
    );

    return _database!;
  }

  // Método para acessar o banco de dados
  Future<Database> get database async {
    return _database ??= await initDatabase();
  }
}
