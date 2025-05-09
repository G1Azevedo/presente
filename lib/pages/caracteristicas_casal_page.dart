import 'package:flutter/material.dart';
import 'lara_page.dart';
import 'gabriel_page.dart';

class CaracteristicasCasalPage extends StatelessWidget {
  const CaracteristicasCasalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Características do Casal 💑'),
        centerTitle: true,
        backgroundColor: Colors.pinkAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 24),
            const Text(
              'Quem você quer conhecer melhor?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'Georgia',
                color: Colors.pinkAccent,
              ),
            ),
            const SizedBox(height: 50),
            // Cards de Gabriel e Lara
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildPersonCard(
                  context,
                  nome: 'Gabriel',
                  imagem: 'assets/images/gabriel.jpg',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const GabrielPage(),
                      ),
                    );
                  },
                ),
                const SizedBox(width: 24), // Espaçamento entre os cards
                _buildPersonCard(
                  context,
                  nome: 'Lara',
                  imagem: 'assets/images/lara.jpg',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const LaraPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPersonCard(BuildContext context,
      {required String nome,
      required String imagem,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                imagem,
                width: 120,
                height: 250,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            nome,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'Georgia',
              color: Colors.pinkAccent,
            ),
          ),
        ],
      ),
    );
  }
}
