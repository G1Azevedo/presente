// lib/main.dart
import 'package:flutter/material.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const LinhaDoTempoAmorApp());
}

class LinhaDoTempoAmorApp extends StatelessWidget {
  const LinhaDoTempoAmorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nosso Amor',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        scaffoldBackgroundColor: Colors.pink.shade50, // Um rosa bem clarinho para o fundo
        fontFamily: 'Sans', // Fonte padrão

        // AppBar Theme
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.pinkAccent, // Um rosa mais vibrante para AppBars
          foregroundColor: Colors.white, // Cor do texto e ícones na AppBar
          elevation: 4.0, // Sombra sutil
          titleTextStyle: const TextStyle(
            fontFamily: 'DancingScript', // Fonte charmosa para títulos
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          centerTitle: true,
        ),

        // Card Theme
        cardTheme: CardTheme(
          elevation: 5, // Sombra padrão para cards
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0), // Bordas arredondadas
          ),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),

        // ElevatedButton Theme (para replicar o estilo da HomePage)
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.pinkAccent.shade100,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 4,
            textStyle: const TextStyle(fontSize: 18, fontFamily: 'Sans', fontWeight: FontWeight.w600),
          ),
        ),

        // Text Theme (para consistência tipográfica)
        textTheme: TextTheme(
          displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, fontFamily: 'DancingScript', color: Colors.pink.shade700),
          headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, fontFamily: 'Georgia', color: Colors.pink.shade600),
          bodyMedium: TextStyle(fontSize: 16, fontFamily: 'Sans', color: Colors.grey.shade800),
          labelLarge: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Sans'), // Para botões
        ),

        // FloatingActionButton Theme
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.pinkAccent,
          foregroundColor: Colors.white,
          elevation: 6.0,
        ),

        // Input Decoration Theme (para TextFields)
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(color: Colors.pink.shade200),
          ),
          enabledBorder: OutlineInputBorder( // Adicionado para estado normal
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(color: Colors.pink.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(color: Colors.pinkAccent, width: 2.0),
          ),
          labelStyle: TextStyle(color: Colors.pink.shade700),
          hintStyle: TextStyle(color: Colors.grey.shade500),
          filled: true, // Adicionar um fundo sutil
          fillColor: Colors.white.withOpacity(0.7),
        ),

        // IconTheme
        iconTheme: const IconThemeData(
          color: Colors.pinkAccent, // Cor padrão para ícones
          size: 24.0,
        ),
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}