import 'package:flutter/material.dart';

class GabrielPage extends StatelessWidget {
  const GabrielPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sobre Gabriel 💙'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 70,
              backgroundImage: AssetImage('assets/images/gabriel1.jpg'),
            ),
            const SizedBox(height: 24),
            const Text(
              'Características der Gabriel',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.pinkAccent,
              ),
            ),
            const SizedBox(height: 16),
            const CharacteristicItem(text: 'Inteligente 🧠'),
            const CharacteristicItem(text: 'Carinhoso 💕'),
            const CharacteristicItem(text: 'Engraçado 😄'),
            const CharacteristicItem(text: 'Amante de tecnologia 💻'),
            const CharacteristicItem(text: 'Melhor namorado do mundo 💘'),
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
