// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:manage_calendar_events/manage_calendar_events.dart';
import 'package:mythings/provider/calendar_state.dart';
import 'package:mythings/views/recordatorios/recordatoriosList.dart';
import 'package:provider/provider.dart';

class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({super.key});

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  DateTime startDate = DateTime.now();
  Duration duration = Duration(hours: 1);
  List<Duration> durations = [
    Duration(hours: 1),
    Duration(hours: 2),
    Duration(hours: 3),
  ];
  final CalendarPlugin _myPlugin = CalendarPlugin();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Nuevo Evento de Prueba'),
          backgroundColor: Colors.black,
        ),
        body: Card(
          color: Colors.black,
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                TextFormField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    labelText: 'Título',
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Descripción',
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: locationController,
                  decoration: const InputDecoration(
                    labelText: 'Ubicación',
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: startDate,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2101),
                    );
                    if (picked != null && picked != startDate) {
                      setState(() {
                        startDate = picked;
                      });
                    }
                  },
                  child: Text('Fecha de inicio: ${startDate.toLocal()}'),
                ),
                const SizedBox(height: 10),
                DropdownButton<Duration>(
                    value: duration,
                    items: durations
                        .map<DropdownMenuItem<Duration>>((Duration value) {
                      return DropdownMenuItem<Duration>(
                        value: value,
                        child: Text('${value.inHours} horas'),
                      );
                    }).toList(),
                    onChanged: (Duration? newValue) {
                      setState(() {
                        duration = newValue!;
                      });
                    }),
                ElevatedButton(
                  onPressed: () {
                    _submitForm();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Recordatorioslist()));
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all(Colors.deepOrangeAccent),
                      foregroundColor: WidgetStateProperty.all(Colors.black)),
                  child: const Text('Crear Prueba'),
                ),
              ],
            ),
          ),
        ));
  }

  Future<String> _getCalendar() async {
    Calendar? calendarAux;
    String idCalendario = '';

    final calendars = await _myPlugin.getCalendars();
    calendarAux = calendars?.firstWhere(
      (calendar) => calendar.name!.contains('@gmail.com'),
    );

    if (calendarAux != null) {
      idCalendario = calendarAux.id!;
    }
    return idCalendario;
  }

  void _submitForm() async {
    final String? calendarId =
        Provider.of<CalendarState>(context, listen: false).chosenCalendarId;

    if (calendarId == null) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Advertencia'),
              content: const Text('No se ha seleccionado un calendario'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Aceptar'),
                ),
              ],
            );
          });
      return;
    }

    final CalendarEvent event = CalendarEvent(
      title: "PB ${titleController.text}",
      description: descriptionController.text,
      location: locationController.text,
      startDate: startDate,
      endDate: startDate.add(const Duration(hours: 1)),
    );

    await _myPlugin.createEvent(calendarId: calendarId, event: event);
    if (mounted) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Exito'),
            content: const Text('Prueba se creo correctamente'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Aceptar'),
              ),
            ],
          );
        },
      );
    }
  }
}
