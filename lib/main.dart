import 'package:flutter/material.dart';
import 'package:smthree/Pages/notes_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Sqflite Notes',
    themeMode: ThemeMode.light,
    theme: ThemeData(
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
      ),
    ),
    home: const NotesPage(),
  );
}
