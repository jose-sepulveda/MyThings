import 'package:flutter/material.dart';
import 'package:mythings/views/home.dart';

class Ponderador extends StatefulWidget {
  const Ponderador({super.key});

  @override
  _PonderadorState createState() => _PonderadorState();
}

class _PonderadorState extends State<Ponderador> {
  final List<Row> _rows = [];
  final List<TextEditingController> _controllers = [];

  @override
  void initState() {
    super.initState();
    _addRow();
    _addRow();
  }

  void _addRow() {
    TextEditingController controller1 = TextEditingController();
    TextEditingController controller2 = TextEditingController();
    _controllers.add(controller1);
    _controllers.add(controller2);

    setState(() {
      _rows.add(Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: controller1,
                decoration: const InputDecoration(
                    hintText: 'Nota (Ej: 7.0)',
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 4, 100, 225)))),
                style: const TextStyle(
                    fontSize: 26, color: Color.fromARGB(255, 4, 100, 225)),
                textAlign: TextAlign.center,
                onChanged: (value) {
                  double? nota = double.tryParse(value);
                  if (nota == null || nota < 1.0 || nota > 7.0) {
                    AlertDialog(
                      title: const Text('Nota'),
                      content: const Text('Nota fuera de rango'),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('OK'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                    controller1.text = '';
                  }
                },
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: controller2,
                decoration: const InputDecoration(
                    hintText: 'Porcentaje',
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 4, 100, 225)))),
                style: const TextStyle(
                    fontSize: 26, color: Color.fromARGB(255, 4, 100, 225)),
                textAlign: TextAlign.center,
                onChanged: (value) {
                  int? porcentaje = int.tryParse(value);
                  if (porcentaje == null ||
                      porcentaje < 0 ||
                      porcentaje > 100) {
                    AlertDialog(
                      title: const Text('Porcentaje'),
                      content: const Text('Porcentaje fuera de rango'),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('OK'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                    controller2.text = '';
                  }
                },
              ),
            ),
          ),
        ],
      ));
    });
  }

  void _removeRow() {
    if (_rows.isNotEmpty) {
      _controllers.removeLast();
      _controllers.removeLast();

      setState(() {
        _rows.removeLast();
      });
    }
  }

  void _calculate() {
    for (int i = 0; i < _controllers.length; i += 2) {
      if (_controllers[i].text.isEmpty || _controllers[i + 1].text.isEmpty) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.red.shade400,
              title: const Text(
                '¡Atención!',
                style: TextStyle(color: Colors.black),
              ),
              content: const Text(
                'Faltan entradas por rellenar.',
                style: TextStyle(color: Colors.black),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text(
                    'OK',
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
        return;
      }
    }

    double total = 0;
    int totalPorcentaje = 0;

    for (int i = 0; i < _controllers.length; i += 2) {
      double nota = double.parse(_controllers[i].text);
      int porcentaje = int.parse(_controllers[i + 1].text);

      total += nota * porcentaje / 100;
      totalPorcentaje += porcentaje;
    }

    if (totalPorcentaje != 100) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.yellow.shade300,
            title: const Text(
              '¡Atención!',
              style: TextStyle(color: Colors.black),
            ),
            content: const Text(
              'El total de los porcentajes no suma 100. Por favor, revisa tus entradas.',
              style: TextStyle(color: Colors.black),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('OK', style: TextStyle(color: Colors.black)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else if (total < 4.0) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.red.shade400,
            title: const Text(
              '¡Lo siento!',
              style: TextStyle(color: Colors.black),
            ),
            content: Text(
              'No esta aprobando el ramo. La ponderación total es: ${total.toStringAsFixed(1)}',
              style: const TextStyle(color: Colors.black),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('OK', style: TextStyle(color: Colors.black)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else if (total >= 4.0) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.green.shade400,
            title: const Text('¡Felicidades! ',
                style: TextStyle(color: Colors.black)),
            content: Text(
                'Aprobo el ramo. La ponderación total es: ${total.toStringAsFixed(1)}',
                style: const TextStyle(color: Colors.black)),
            actions: <Widget>[
              TextButton(
                child: const Text('OK', style: TextStyle(color: Colors.black)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Theme',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepOrange,
          onSurface: Colors.blue,
        ),
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            color: Colors.red,
            fontSize: 32,
            fontWeight: FontWeight.w900,
          ),
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepOrange,
            brightness: Brightness.dark,
          ),
          useMaterial3: true),
      themeMode: ThemeMode.dark,
      home: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Ponderador',
              style: TextStyle(fontSize: 30),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Home()));
              },
            ),
          ),
          floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FloatingActionButton(
                backgroundColor: Color.fromARGB(255, 4, 100, 225),
                onPressed: _addRow,
                tooltip: 'Agregar fila',
                child: const Icon(Icons.add),
              ),
              const SizedBox(width: 10),
              FloatingActionButton(
                backgroundColor: Color.fromARGB(255, 4, 100, 225),
                onPressed: _removeRow,
                tooltip: 'Eliminar última fila',
                child: const Icon(Icons.remove),
              ),
              const SizedBox(width: 10),
              FloatingActionButton(
                backgroundColor: Color.fromARGB(255, 4, 100, 225),
                onPressed: _calculate,
                tooltip: 'Calcular ponderación',
                child: const Icon(Icons.calculate),
              ),
            ],
          ),
          body: ListView.builder(
            itemCount: _rows.length,
            itemBuilder: (BuildContext context, int index) {
              return _rows[index];
            },
          )),
      debugShowCheckedModeBanner: false,
    );
  }
}
