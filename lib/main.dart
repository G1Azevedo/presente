// lib/main.dart
import 'package:flutter/material.dart';
import 'package:linha_do_tempo_amor/controllers/music_controller.dart'; // Importe o controlador
import 'pages/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // Necessário para inicializações antes do runApp
  // Inicialize o player de música aqui
  // Certifique-se que o caminho do asset está correto
  MusicController().initializePlayer(assetPath: 'assets/audio/background_music.mp3').then((_) {
     // Após inicializar, tentamos tocar.
     // Navegadores modernos podem bloquear autoplay sem interação do usuário.
     // Uma boa prática é começar a tocar após a primeira interação ou na HomePage.
     // Por enquanto, vamos tentar iniciar aqui, mas pode ser necessário ajustar.
    MusicController().play();
  });
  runApp(const LinhaDoTempoAmorApp());
}

class LinhaDoTempoAmorApp extends StatefulWidget {
  const LinhaDoTempoAmorApp({super.key});

  @override
  State<LinhaDoTempoAmorApp> createState() => _LinhaDoTempoAmorAppState();
}

class _LinhaDoTempoAmorAppState extends State<LinhaDoTempoAmorApp> with WidgetsBindingObserver {
  final MusicController _musicController = MusicController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _musicController.dispose(); // Libera recursos do player de música
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (!_musicController.isMutedNotifier.value) { // Só interfere se não estiver mudo
      if (state == AppLifecycleState.paused || state == AppLifecycleState.detached) {
        _musicController.pause();
      } else if (state == AppLifecycleState.resumed) {
        _musicController.play();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nosso Amor',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        scaffoldBackgroundColor: Colors.pink.shade50,
        fontFamily: 'Sans',
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.pinkAccent,
          foregroundColor: Colors.white,
          elevation: 4.0,
          titleTextStyle: const TextStyle(
            fontFamily: 'DancingScript',
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          centerTitle: true,
        ),
        cardTheme: CardTheme(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
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
        textTheme: TextTheme(
          displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, fontFamily: 'DancingScript', color: Colors.pink.shade700),
          headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, fontFamily: 'Georgia', color: Colors.pink.shade600),
          bodyMedium: TextStyle(fontSize: 16, fontFamily: 'Sans', color: Colors.grey.shade800),
          labelLarge: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Sans'),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.pinkAccent,
          foregroundColor: Colors.white,
          elevation: 6.0,
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(color: Colors.pink.shade200),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(color: Colors.pink.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(color: Colors.pinkAccent, width: 2.0),
          ),
          labelStyle: TextStyle(color: Colors.pink.shade700),
          hintStyle: TextStyle(color: Colors.grey.shade500),
          filled: true,
          fillColor: Colors.white.withOpacity(0.7),
        ),
        iconTheme: const IconThemeData(
          color: Colors.pinkAccent,
          size: 24.0,
        ),
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}