import 'dart:math';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  late String result;

  @override
  void initState() {
    super.initState();
    _resetFields();
  }

  final Map<double, String> tracks = {
    40: "Obesidade Grau III (mórbida)",
    35: 'Obesidade Grau II (severa)',
    30: 'Obesidade Grau I',
    25: 'Sobrepeso',
    18.5: 'Saudável',
    17: 'Magreza leve',
    16: 'Magreza moderada',
    0: "Magreza grava",
  };

  void _resetFields() {
    _formKey.currentState?.reset();
    _heightController.text = "";
    _weightController.text = "";

    setState(
      () {
        result = 'Informe seus dados';
      },
    );
  }

  void _calculateIMC() {
    double imcCalculated = double.parse(_weightController.text) /
        pow(double.parse(_heightController.text), 2);
    for (var imcValues in tracks.keys) {
      if (imcCalculated >= imcValues) {
        setState(() {
          result = "${tracks[imcValues]!}\n\nIMC = $imcCalculated";
        });
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
          actions: [
            IconButton(
                onPressed: _resetFields, icon: const Icon(Icons.refresh)),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(8.0, 60.0, 8.0, 8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _heightController,
                        validator: (value) {
                          return valueValidate(value, 4, 0.3, 3.0);
                        },
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          label: Text('Altura (m)'),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                            ),
                          ),
                          suffix: Text(
                            '(m)',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                      height: 100,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: _weightController,
                        validator: (value) {
                          return valueValidate(value, 6, 0.5, 300.0);
                        },
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          label: Text('Peso (Kg)'),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                            ),
                          ),
                          suffix: Text(
                            '(Kg)',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 16.0),
                  child: TextButton.icon(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _calculateIMC();
                      }
                    },
                    icon: const Icon(
                      Icons.calculate_sharp,
                      size: 48,
                      color: Colors.deepOrange,
                    ),
                    label: const Text(
                      'Calcular IMC',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.deepOrange,
                      ),
                    ),
                  ),
                ),
                Text(result),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? valueValidate(valueInput, lengthLimit, lowerLimit, upperLimit) {
    if (valueInput!.isEmpty) {
      return 'Insira um valor';
    }
    if (valueInput!.toString().length > lengthLimit) {
      return "Dever ter no máximo: \n - $lengthLimit caracteres";
    }
    try {
      double value = double.parse(valueInput);
      if (value < lowerLimit) {
        return "Deve ser maior que: $lowerLimit";
      }
      if (value > upperLimit) {
        return "Deve ser menor que: $upperLimit";
      }
    } on Exception {
      return "Insira um número.";
    }
    return null;
  }
}
