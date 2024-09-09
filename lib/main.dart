import 'package:flutter/material.dart';

import 'screens/home_screen.dart';
// import 'screens/home_screen.dart';

void main() {
  runApp(const ImcCalculatorApp());
}

class ImcCalculatorApp extends StatelessWidget {
  const ImcCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IMC Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(title: 'IMC Calculator'),
    );
  }
}
