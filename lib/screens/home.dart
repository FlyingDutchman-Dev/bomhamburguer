import 'package:bomhamburguer/data/database.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _dbStatus = "Clique para inicializar o banco de dados";

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
            Text(_dbStatus),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _initializeDatabase,
                child: const Text("Iniciar banco de dados"),
            ),
          ],
        ),
      ),
    );
  }

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
}
