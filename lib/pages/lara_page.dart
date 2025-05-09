import 'package:flutter/material.dart';

class LaraPage extends StatelessWidget {
  const LaraPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sobre Lara 💖'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 70,
              backgroundImage: AssetImage('assets/images/lara1.jpg'),
            ),
            const SizedBox(height: 24),
            const Text(
              'Características de Lara',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.pinkAccent,
              ),
            ),
            const SizedBox(height: 16),
            const CharacteristicItem(text: 'É a mulher mais bonita do mundo 🌟'),
            const CharacteristicItem(text: 'Inteligente e dedicada, monitora na UERN 📚'),
            const CharacteristicItem(text: 'É graciosa, mas também é engraçada 😄'),
            const CharacteristicItem(text: 'Meiga, carinhosa, dengosa e amável 🧸'),
            const CharacteristicItem(text: 'Enfim, a namorada perfeita 💝'),
          ],
        ),
      ),
    );
  }
}

class CharacteristicItem extends StatelessWidget {
  final String text;

  const CharacteristicItem({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          const Icon(Icons.favorite, color: Colors.pinkAccent),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
