import 'package:flutter/material.dart';
import 'package:mythings/provider/calendar_state.dart';
import 'package:mythings/views/home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CalendarState(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'MyThings',
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}
