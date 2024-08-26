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
  List<Product> _products = []; // Lista para armazenar os produtos

  String _dbStatus = "Clique para inicializar o banco de dados";
  String _tableStatus = "Clique para verificar a tabela 'Product'";
  String _statusMessage = "Inicializando...";

  @override
  void initState() {
    super.initState();
    _initializeDatabase();
    _checkProductTable();
    _addSampleProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bom Hamburguer"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: ListView.builder(
                    itemCount: _products.length,
                    itemBuilder: (context, index){
                      final product = _products[index];
                      return ListTile(
                        leading: Image.asset(
                          product.imagePath,
                          width: 50,
                          height: 50,
                        ),
                        title: Text(product.sandwichName),
                        subtitle: Text("\$${product.price.toStringAsFixed(2)}",
                        style: const TextStyle(
                            color: Colors.green
                          ),
                        ),
                      );
                    }
                ),
            ),
            const SizedBox(height: 60),
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

      print("Banco de dados inicializado com sucesso");

    } catch (e) {
      print("Erro ao inicializar o banco de dados: $e");
    }
  }

  // Função para testar a criação da tabela de produto
  Future<void> _checkProductTable() async {
    bool exists = await ProductTable.checkIfTableExists();

    exists ? "Tabela 'Product' foi criada!" : "Tabela 'Product' NÃO existe!";
  }

  // Função para adicionar produtos na tabela Product
  Future<void> _addSampleProducts() async {
    try {
      await ProductTable.clearProductTable(); // Limpar tabela antes de adicionar

      await ProductTable.insertProduct(
          Product(sandwichName:"X Burger", price:5.00, imagePath: "lib/assets/images/x-burguer.png")
      );
      await ProductTable.insertProduct(
          Product(sandwichName:"X Egg", price:4.50, imagePath: "lib/assets/images/x-egg.png")
      );
      await ProductTable.insertProduct(
          Product(sandwichName:"X Bacon", price:7.00, imagePath: "lib/assets/images/x-bacon.png")
      );

      await _fetchProducts(); // Buscar produtos após a inserção

      print("Produtos adicionados com sucesso!");
    } catch (e) {
      print("Produtos adicionados com sucesso!");
    }
  }

  // Função para carregar os produtos
  Future<void> _fetchProducts() async {
    try {
      List<Product> products = await ProductTable.getAllProducts();
      setState(() {
        _products = products;
        //_statusMessage = "${_products.length} produtos encontrados!";
      });
    } catch (e) {
      print("Erro ao buscar produtos: $e");
    }
  }
}
