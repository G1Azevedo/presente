// lib/pages/home_page.dart
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:linha_do_tempo_amor/controllers/music_controller.dart'; // Importe o controlador
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
    // Garante que a música toque ao entrar na HomePage, se não estiver já tocando e não mutada.
    // Isso ajuda com políticas de autoplay que exigem interação do usuário.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _musicController.ensurePlaying();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(""), // O banner já faz o papel de título visual
        backgroundColor: Colors.transparent, // AppBar transparente para o banner
        elevation: 0, // Sem sombra na AppBar
        actions: [
          ValueListenableBuilder<bool>(
            valueListenable: _musicController.isMutedNotifier,
            builder: (context, isMuted, child) {
              return IconButton(
                icon: Icon(
                  isMuted ? Icons.volume_off : Icons.volume_up,
                  color: Colors.pinkAccent, // Cor do ícone
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
      extendBodyBehindAppBar: true, // Para o conteúdo ficar atrás da AppBar transparente
      body: SingleChildScrollView(
        child: Column( // Alterado para Column para o banner e o resto
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildBanner(), // Método para o banner
            Padding( // Padding para o conteúdo abaixo do banner
              padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // A SizedBox aqui pode ser para dar um espaço após o banner se a AppBar não for alta o suficiente
                  // ou se o banner não tiver um tamanho fixo que já empurre o conteúdo para baixo.
                  // Se o banner estiver dentro do Column, pode não ser necessário um SizedBox grande aqui.
                  // Ajuste conforme o visual desejado.
                  // const SizedBox(height: kToolbarHeight + 40), // Exemplo de espaço se a AppBar for sobreposta

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
    // Obtém a altura da status bar para um padding adequado no topo da imagem
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return Padding(
      // Adiciona padding no topo igual à altura da status bar + um pouco mais se a AppBar estiver sobreposta
      padding: EdgeInsets.only(top: statusBarHeight),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
        child: Image.asset(
          'assets/images/banner.png',
          width: double.infinity,
          // Defina uma altura ou use fitWidth para preencher a largura
          // height: 250, // Exemplo de altura
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }


  Widget _buildMenuButton(BuildContext context,
      {required IconData icon,
      required String label,
      required VoidCallback onPressed}) {
    // Usa o tema definido no main.dart para ElevatedButton
    return ElevatedButton.icon(
      icon: Icon(icon, size: 28),
      label: Text(label, style: const TextStyle(fontSize: 18)),
      onPressed: onPressed,
      // O estilo virá do elevatedButtonTheme, mas pode ser sobrescrito aqui se necessário:
      // style: ElevatedButton.styleFrom(
      //   padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      //   backgroundColor: Colors.pinkAccent.shade100,
      //   foregroundColor: Colors.white,
      //   elevation: 4,
      //   minimumSize: const Size(280, 60),
      // ),
    );
  }
}