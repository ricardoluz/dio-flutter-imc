import 'package:flutter/material.dart';

class HomeScreenOld extends StatefulWidget {
  const HomeScreenOld({super.key, required this.title});

  final String title;

  @override
  State<HomeScreenOld> createState() => _HomeScreenOldState();
}

class _HomeScreenOldState extends State<HomeScreenOld> {
  late TextEditingController _height;
  late TextEditingController _weight;

  @override
  void initState() {
    super.initState();
    _height = TextEditingController();
    _weight = TextEditingController();
  }

  void _incrementCounter() {
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(
                height: 110,
              ),
              const Text(
                'Informe os seus dados:',
                style: TextStyle(
                  fontSize: 24,
                  backgroundColor: Colors.amber,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextField(
                      controller: _height,
                      keyboardType: TextInputType.number,
                      // onSubmitted: ,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Altura (m)',
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  Expanded(
                    child: TextField(
                      controller: _weight,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Peso (Kg)',
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 120,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
