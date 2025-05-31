import 'package:flutter/material.dart';
import 'package:linha_do_tempo_amor/pages/caracteristicas_casal_page.dart';
import 'linha_do_tempo_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              // Banner com imagem romântica
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
                child: Image.asset(
                  'assets/images/banner.png',
                  width: double.infinity,
                  height: 220,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(height: 24),

              const Text(
                'Bem-vinda à nossa história de amor 💕',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'DancingScript', // Fonte romântica (adicione no pubspec)
                  color: Colors.pinkAccent,
                ),
              ),

              const SizedBox(height: 20),

              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: const Duration(seconds: 1),
                builder: (context, value, child) {
                  return Opacity(
                    opacity: value,
                    child: Transform.scale(scale: value, child: child),
                  );
                },
                child: const Icon(Icons.favorite, size: 60, color: Colors.pink),
              ),

              const SizedBox(height: 30),

              const Text(
                'Escolha uma opção:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),

              const SizedBox(height: 30),

              _buildMenuButton(
                context,
                icon: Icons.timeline,
                label: 'Linha do Tempo do Amor',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const LinhaDoTempoPage(),
                    ),
                  );
                },
              ),

              const SizedBox(height: 16),

              _buildMenuButton(
                context,
                icon: Icons.photo_album,
                label: 'Galeria de Fotos',
                onPressed: () {
                  // Adicione funcionalidade futura
                },
              ),

              const SizedBox(height: 16),

              _buildMenuButton(
                context,
                icon: Icons.person,
                label: 'Características do Casal',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const CaracteristicasCasalPage(),
                    ),
                  );
                },
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuButton(BuildContext context,
      {required IconData icon, required String label, required VoidCallback onPressed}) {
    return ElevatedButton.icon(
      icon: Icon(icon, size: 28),
      label: Text(label, style: const TextStyle(fontSize: 18)),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: Colors.pinkAccent.shade100,
        foregroundColor: Colors.white,
        elevation: 4,
      ),
      onPressed: onPressed,
    );
  }
}
