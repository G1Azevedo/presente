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
        scaffoldBackgroundColor: Colors.pink.shade50,
        fontFamily: 'Sans',
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
