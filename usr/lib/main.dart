import 'package:flutter/material.dart';
import 'package:couldai_user_app/screens/main_scaffold.dart';

void main() {
  runApp(const StudyApp());
}

class StudyApp extends StatelessWidget {
  const StudyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Study Companion',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6C63FF), // A nice study-focused purple/blue
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        fontFamily: 'Roboto', // Default, but good to be explicit if we add fonts later
      ),
      // Define the initial route and the routes table
      initialRoute: '/',
      routes: {
        '/': (context) => const MainScaffold(),
      },
    );
  }
}
