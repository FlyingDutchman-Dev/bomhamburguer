import 'package:bomhamburguer/data/database.dart';
import 'package:bomhamburguer/data/product_table.dart';
import 'package:bomhamburguer/model/product.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _dbStatus = "Clique para inicializar o banco de dados";
  String _tableStatus = "Clique para verificar a tabela 'Product'";
  String _statusMessage = "Inicializando...";

  @override
  void initState() {
    super.initState();
    //_addSampleProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Teste banco de dados"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_statusMessage),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _addSampleProducts,
              child: const Text("Criar produtos na tabela product"),
            ),
            const SizedBox(height: 80),
            Text(_dbStatus),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _initializeDatabase,
                child: const Text("Iniciar banco de dados"),
            ),
            const SizedBox(height: 80),
            Text(_tableStatus),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _checkProductTable,
              child: const Text("Verificar tabela Product"),
            ),
          ],
        ),
      ),
    );
  }

  // Função para testar o banco de dados
  Future<void> _initializeDatabase() async {
    try {
      DatabaseHelper dbHelper = DatabaseHelper();
      await dbHelper.database;

      setState(() {
        _dbStatus = "Banco de dados inicializado com sucesso";
      });
    } catch (e) {
      setState(() {
        _dbStatus = "Erro ao inicializar o banco de dados: $e";
      });
    }
  }

  // Função para testar a criação da tabela de produto
  Future<void> _checkProductTable() async {
    bool exists = await ProductTable.checkIfTableExists();

    setState(() {
      _tableStatus = exists ? "Tabela 'Product' foi criada!" : "Tabela 'Product' NÃO existe!";
    });
  }

  // Função para adicionar produtos na tabela Product
  Future<void> _addSampleProducts() async {
    try {
      await ProductTable.insertProduct(Product(sandwichName:"Cheeseburger", price:5.99));
      await ProductTable.insertProduct(Product(sandwichName:"Double Burger", price:7.99));
      await ProductTable.insertProduct(Product(sandwichName:"Chicken Sandwich", price:6.49));

      setState(() {
        _statusMessage = "Produtos adicionados com sucesso!";
      });
    } catch (e) {
      setState(() {
        _statusMessage = "Erro ao adicionar produtos: $e";
      });
    }
  }
}
