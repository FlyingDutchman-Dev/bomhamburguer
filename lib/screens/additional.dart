import 'package:bomhamburguer/data/additional_table.dart';
import 'package:bomhamburguer/model/additional.dart';
import 'package:bomhamburguer/model/product.dart';
import 'package:bomhamburguer/screens/app_layout.dart';
import 'package:flutter/material.dart';

class AdditionalScreen extends StatefulWidget {
  final Product product; // Produto selecionado

  const AdditionalScreen({super.key, required this.product});

  @override
  State<AdditionalScreen> createState() => _AdditionalScreenState();
}

class _AdditionalScreenState extends State<AdditionalScreen> {
  List<Additional> _additional = []; // Lista para armazenar os adicionais

  @override
  void initState() {
    super.initState();
    _checkAdditionalTable();
    _addSampleAdditional();
  }

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      title: "Adicionais",
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            Text("Por favor, escolha os adicionais para ${widget.product.sandwichName}"), // Exibir o nome do hambúrguer
            const Text("Máximo 2 itens!", style: TextStyle(color: Colors.red),), // Exibir o nome do hambúrguer
            const SizedBox(height: 30),
            Expanded(
              child: ListView.builder(
                  itemCount: _additional.length,
                  itemBuilder: (context, index){
                    final additional = _additional[index];
                    return ListTile(
                      leading: Image.asset(
                        additional.imagePath,
                        width: 50,
                        height: 50,
                      ),
                      title: Text(additional.addName),
                      subtitle: Text("\$${additional.price.toStringAsFixed(2)}",
                        style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      /*onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AdditionalScreen(product: product), // Passa o produto para a nova tela
                          ),
                        );
                      },*/
                    );
                  }
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Função para testar a criação da tabela de produto
  Future<void> _checkAdditionalTable() async {
    bool exists = await AdditionalTable.checkIfTableExists();

    exists ? "Tabela 'Product' foi criada!" : "Tabela 'Product' NÃO existe!";
  }

  // Função para adicionar adicionais na tabela Additional
  Future<void> _addSampleAdditional() async {
    try {
      await AdditionalTable.clearAdditionalTable(); // Limpar tabela antes de adicionar

      await AdditionalTable.insertAdditional(
          Additional(addName:"Fries", price:2.00, imagePath: "lib/assets/images/fries.png")
      );
      await AdditionalTable.insertAdditional(
          Additional(addName:"Soft Drink", price:2.50, imagePath: "lib/assets/images/softdrink.png")
      );

      await _fetchAdditional(); // Buscar adicionais após a inserção

      print("Adicionais inseridos com sucesso!");
    } catch (e) {
      print("Erro ao inserir os Adicionais: $e");
    }
  }

  // Função para carregar os adicionais
  Future<void> _fetchAdditional() async {
    try {
      List<Additional> add = await AdditionalTable.getAllAdditional();
      setState(() {
        _additional = add;
        //_statusMessage = "${_products.length} produtos encontrados!";
      });
    } catch (e) {
      print("Erro ao buscar adicionais: $e");
    }
  }
}