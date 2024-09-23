import 'package:dio_imc/models/bmi_notes.dart';
import 'package:dio_imc/repository/bmi_notes_repository.dart';
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

  BmiNotesRepository bmiNotesRepository = BmiNotesRepository();
  List<BmiNote> _bmiNotes = [];

  Future<void> getBmiNotes() async {
    _bmiNotes = await bmiNotesRepository.getBmiNotes();
    setState(() {});
  }

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

  Future<void> _imcPresent() async {
    String descriptionIMC;
    double valueIMC;
    (descriptionIMC, valueIMC) = bmiCalculator(
      double.parse(_heightController.text),
      double.parse(_weightController.text),
    );

    bmiNotesRepository.addBmiNotes(BmiNote(DateTime.now(), valueIMC));
    await getBmiNotes();

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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext bc) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 40, horizontal: 8),
                  child: SizedBox(
                    height: 600,
                    child: bmiForm(),
                  ),
                );
              });
        },
      ),
      body: bmiDisplay(),
    ));
  }

  Widget bmiDisplay() {
    if (_bmiNotes.isNotEmpty) {
      return Container(
        padding: const EdgeInsets.fromLTRB(8.0, 60.0, 8.0, 8.0),
        child: ListView.builder(
            itemCount: _bmiNotes.length,
            itemBuilder: (BuildContext bc, int index) {
              BmiNote bmiNote = _bmiNotes[index];
              return Dismissible(
                key: Key(bmiNote.id),
                onDismissed: (DismissDirection direction) async {
                  await bmiNotesRepository.removeBmiNotes(bmiNote.id);
                  await getBmiNotes();
                },
                child: Container(
                  height: 75,
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(bmiNote.date),
                      Row(
                        children: [
                          Text("IMC: ${bmiNote.bmiValue.toString()}"),
                          Text(" | ${bmiDescription(bmiNote.bmiValue)}"),
                        ],
                      ),
                      const Divider(),
                    ],
                  ),
                ),
              );
            }),
      );
    } else {
      return const Center(
        child: Text("Inclua uma medição."),
      );
    }
  }

  Form bmiForm() {
    return Form(
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
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _imcPresent();
                  Navigator.pop(context);
                }
                // Navigator.pop(context);
              },
              icon: const Icon(
                Icons.calculate_sharp,
                size: 48,
                color: Colors.deepOrange,
              ),
              style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.tealAccent),
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
    );
  }
}
