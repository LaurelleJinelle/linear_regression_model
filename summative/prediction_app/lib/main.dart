import 'package:flutter/material.dart';
import 'screens/input_screen.dart'; 

void main() {
  runApp(const StartupPredictorApp());
}

class StartupPredictorApp extends StatelessWidget {
  const StartupPredictorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup Predictor',
      theme: ThemeData.dark().copyWith(
        primaryColor: const Color(0xFF4F46E5),
        scaffoldBackgroundColor: const Color(0xFF111827),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF4F46E5),
          secondary: Color(0xFF6366F1),
          background: Color(0xFF111827),
          surface: Color(0xFF1F2937),
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onBackground: Colors.white,
          onSurface: Colors.white,
        ),
      ),
      home: const InputScreen(),
    );
  }
}