// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:mythings/views/home.dart';
import 'package:mythings/views/otros/otro_list.dart';
import 'package:mythings/views/presentacion/presentacion_list.dart';
import 'package:mythings/views/pruebas/prueba_list.dart';
import 'package:mythings/views/tareas/tarea_list.dart';

class Recordatorios extends StatefulWidget {
  const Recordatorios({super.key});

  @override
  State<Recordatorios> createState() => _RecordatoriosState();
}

class _RecordatoriosState extends State<Recordatorios> {
  @override
  void initState() {
    super.initState();
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
      home: const MyWidget(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  int screen = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Recordatorios',
          style: TextStyle(fontSize: 30),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => const Home()));
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 16.0),
              SizedBox(
                width: double.infinity,
                height: 80.0,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PruebaList()));
                    print('Botón Pruebas presionado');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 181, 58, 9),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(
                        Icons.pending_actions,
                        size: 30,
                        color: Colors.white,
                      ),
                      SizedBox(width: 8.0),
                      Text(
                        'Pruebas',
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              SizedBox(
                width: double.infinity,
                height: 80.0,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const TareaList()));
                      print('Botón Tareas presionado');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 238, 145, 5),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          Icons.note_alt_outlined,
                          size: 30,
                          color: Colors.white,
                        ),
                        SizedBox(width: 8.0),
                        Text(
                          'Tareas',
                          style: TextStyle(fontSize: 25, color: Colors.white),
                        ),
                      ],
                    )),
              ),
              const SizedBox(height: 16.0),
              SizedBox(
                width: double.infinity,
                height: 80.0,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PresentacionList()));
                    print('Botón Presentaciones presionado');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 225, 67, 4),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(Icons.personal_video, size: 30, color: Colors.white),
                      SizedBox(
                        width: 8.0,
                      ),
                      Text(
                        'Presentaciones',
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              SizedBox(
                width: double.infinity,
                height: 80.0,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const OtroList()));
                      print('Botón Otros presionado');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 207, 114, 7),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.school, size: 30, color: Colors.white),
                        SizedBox(
                          width: 8.0,
                        ),
                        Text(
                          'Otros',
                          style: TextStyle(fontSize: 25, color: Colors.white),
                        ),
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
