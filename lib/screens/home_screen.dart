import 'package:flutter/material.dart';

import '/data_handling/type_validators.dart';
import '/functions/imc_calcutator.dart';

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

  void _imcPresent() {
    String descriptionIMC;
    double valueIMC;
    (descriptionIMC, valueIMC) = imcCalculator(
      double.parse(_heightController.text),
      double.parse(_weightController.text),
    );

    setState(() {
      result = "$descriptionIMC\n\nIMC = $valueIMC";
    });
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
                        // obscureText: true,
                        controller: _heightController,
                        validator: (value) {
                          return validateDouble(
                              value: value, limLower: 0.3, limUpper: 4);
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
                          return validateDouble(
                              value: value, limLower: 0.3, limUpper: 500);
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
                        _imcPresent();
                      }
                    },
                    icon: const Icon(
                      Icons.calculate_sharp,
                      size: 48,
                      color: Colors.deepOrange,
                    ),
                    style: const ButtonStyle(
                      backgroundColor:
                          WidgetStatePropertyAll(Colors.tealAccent),
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.elliptical(1, 2)),
                        ),
                      ),
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
}
