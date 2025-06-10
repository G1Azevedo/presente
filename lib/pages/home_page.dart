import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:linha_do_tempo_amor/controllers/music_controller.dart';
import 'package:linha_do_tempo_amor/pages/caracteristicas_casal_page.dart';
import 'package:linha_do_tempo_amor/pages/quiz_page.dart';
import 'linha_do_tempo_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final MusicController _musicController = MusicController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _musicController.ensurePlaying();
      _showWelcomeDialog();
    });
  }

  void _showWelcomeDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return FadeIn(
          duration: const Duration(milliseconds: 500),
          child: AlertDialog(
            backgroundColor: Colors.pink[50],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(color: Colors.pinkAccent.shade100, width: 2),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Feliz dia dos Namorados, meu amor!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'DancingScript',
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink.shade700,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'De todas as formas de dizer que te amo, esta foi uma das que escolhi. Espero que goste, feito com muito amor e carinho.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Sans',
                    fontSize: 16,
                    color: Colors.grey.shade800,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  '- Gabriel',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'DancingScript',
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink.shade600,
                  ),
                ),
                const SizedBox(height: 24),
                IconButton(
                  iconSize: 40,
                  icon: const Icon(Icons.favorite, color: Colors.redAccent),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  tooltip: 'Fechar',
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          ValueListenableBuilder<bool>(
            valueListenable: _musicController.isMutedNotifier,
            builder: (context, isMuted, child) {
              return IconButton(
                icon: Icon(
                  isMuted ? Icons.volume_off : Icons.volume_up,
                  color: Colors.pinkAccent,
                ),
                tooltip: isMuted ? 'Ativar Som' : 'Silenciar',
                onPressed: () {
                  _musicController.toggleMute();
                },
              );
            },
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildBanner(),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
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
                  FadeInUp(
                    child: _buildMenuButton(
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
                  ),
                  const SizedBox(height: 16),
                  FadeInUp(
                    child: _buildMenuButton(
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
                  ),
                  const SizedBox(height: 16),
                  FadeInUp(
                    child: _buildMenuButton(
                      context,
                      icon: Icons.quiz,
                      label: 'Quiz do Casal',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const QuizPage(),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBanner() {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return Padding(
      padding: EdgeInsets.only(top: statusBarHeight),
      child: ClipRRect(
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
    );
  }

  Widget _buildMenuButton(BuildContext context,
      {required IconData icon,
      required String label,
      required VoidCallback onPressed}) {
    return ElevatedButton.icon(
      icon: Icon(icon, size: 28),
      label: Text(label, style: const TextStyle(fontSize: 18)),
      onPressed: onPressed,
    );
  }
}