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
  }

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      title: "Adicionais",
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Adicionais para o ${widget.product.sandwichName}"), // Exibir o nome do hambúrguer
            // Aqui você pode adicionar a lógica para mostrar os adicionais
          ],
        ),
      ),
    );
  }
}