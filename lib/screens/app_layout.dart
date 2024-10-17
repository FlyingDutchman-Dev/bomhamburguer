import 'package:flutter/material.dart';

class AppLayout extends StatelessWidget {
  final Widget body;
  final String title;

  const AppLayout({required this.body, required this.title, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: body,
    );
  }
}