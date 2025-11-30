import 'package:flutter/material.dart';
import 'home_screen.dart';

void main() {
  runApp(const DazzlingApp());
}

class DazzlingApp extends StatelessWidget {
  const DazzlingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DAZZLING7UAE',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFFD4AF37), // Gold color
        scaffoldBackgroundColor: Colors.grey[100],
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Color(0xFFD4AF37), // Gold text
          elevation: 2,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFD4AF37), // Gold button
            foregroundColor: Colors.black, // Black text
          ),
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
