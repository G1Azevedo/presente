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
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(32),
                    bottomRight: Radius.circular(32),
                  ),
                  child: Image.asset(
                    'assets/images/banner.png',
                    width: double.infinity,
                    fit: BoxFit.fitWidth,
                  ),
                ),

                const SizedBox(height: 30),

                const Text(
                  'Bem-vinda à nossa história de amor!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'DancingScript',
                    color: Colors.pinkAccent,
                  ),
                ),

                const SizedBox(height: 30),

                _buildMenuButton(
                  context,
                  icon: Icons.add_a_photo,
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
                  icon: Icons.people,
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
        minimumSize: const Size(280, 60),
      ),
      onPressed: onPressed,
    );
  }
}