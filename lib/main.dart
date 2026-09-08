import 'package:flutter/material.dart';
import 'package:gestor_ahorro_app/gestor_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gestor de Ahorro',
      theme: ThemeData.dark(),
      home: GestorScreen(),
    );
  }
}
