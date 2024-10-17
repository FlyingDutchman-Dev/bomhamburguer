import 'package:bomhamburguer/data/database.dart';
import 'package:bomhamburguer/screens/product.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    _initializeDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 60),
            const Center(
              child: Text("Olá, bem vindo ao Bom Hamburguer!", style: TextStyle(
                color: Colors.red
              ),),
            ),
            const SizedBox(height: 60),
            ElevatedButton(
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProductScreen(),
                    ),
                  );
                },
                child: const Text("Login"),
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

      print("Banco de dados inicializado com sucesso");

    } catch (e) {
      print("Erro ao inicializar o banco de dados: $e");
    }
  }
}
