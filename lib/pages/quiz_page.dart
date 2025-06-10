import 'package:flutter/material.dart';

class PerguntaQuiz {
  final String texto;
  final List<String> opcoes;
  final int indiceRespostaCorreta;

  PerguntaQuiz({
    required this.texto,
    required this.opcoes,
    required this.indiceRespostaCorreta,
  });
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int _perguntaAtualIndex = 0;
  int _pontuacao = 0;
  bool _quizFinalizado = false;

  final List<PerguntaQuiz> _perguntas = [
    PerguntaQuiz(
      texto: 'Onde foi o nosso primeiro beijo?',
      opcoes: ['Cineland', 'Ilha de Santana', 'Big Hangus', 'Mr Mix'],
      indiceRespostaCorreta: 2,
    ),
    PerguntaQuiz(
      texto: 'Quem disse “eu te amo” primeiro?',
      opcoes: ['Lara', 'Gabriel'],
      indiceRespostaCorreta: 1,
    ),
    PerguntaQuiz(
      texto: 'Onde foi o nosso primeiro jantar romântico?',
      opcoes: ['Nápoles', 'Holanda', 'S2 Lanches', 'Ilha de Santana'],
      indiceRespostaCorreta: 3,
    ),
    PerguntaQuiz(
      texto: 'Qual foi a primeira comida que comemos juntos a sós?',
      opcoes: ['Pizza', 'Açaí', 'Hambúrguer', 'Filé'],
      indiceRespostaCorreta: 3,
    ),
    PerguntaQuiz(
      texto: 'Qual foi o primeiro filme que assistimos juntos?',
      opcoes: [
        'Thor: Ragnarok',
        'Doutor Estranho no Multiverso da Loucura',
        'Homem-Aranha: De Volta ao Lar',
        'Thor: Amor e Trovão'
      ],
      indiceRespostaCorreta: 3,
    ),
    PerguntaQuiz(
      texto: 'Qual foi a nossa primeira viagem longa como casal?',
      opcoes: ['João Pessoa', 'Apodi', 'Natal', 'Ouro Branco'],
      indiceRespostaCorreta: 1,
    ),
    PerguntaQuiz(
      texto: 'Qual é a nossa música?',
      opcoes: ["Sweet Child O'Mine", 'All of me', 'I wanna be yours', 'Stay'],
      indiceRespostaCorreta: 0,
    ),
    PerguntaQuiz(
      texto: 'Em que mês começamos a namorar?',
      opcoes: ['Fevereiro', 'Dezembro', 'Julho', 'Novembro'],
      indiceRespostaCorreta: 3,
    ),
    PerguntaQuiz(
      texto: 'Qual a nossa série favorita como casal?',
      opcoes: ['Lupin', 'Greys Anatomy', 'The Vampire Diaries', 'Cobra Kai'],
      indiceRespostaCorreta: 2,
    ),
    PerguntaQuiz(
      texto: 'Qual foi a nossa primeira festa juntos?',
      opcoes: ['São João', 'Carnaval', 'Ano Novo', 'Festa de Santana'],
      indiceRespostaCorreta: 3,
    ),
  ];

  void _responder(int indiceOpcaoSelecionada) {
    if (_quizFinalizado) return;

    if (indiceOpcaoSelecionada ==
        _perguntas[_perguntaAtualIndex].indiceRespostaCorreta) {
      setState(() {
        _pontuacao++;
      });
    }

    if (_perguntaAtualIndex < _perguntas.length - 1) {
      setState(() {
        _perguntaAtualIndex++;
      });
    } else {
      setState(() {
        _quizFinalizado = true;
      });
    }
  }

  void _reiniciarQuiz() {
    setState(() {
      _perguntaAtualIndex = 0;
      _pontuacao = 0;
      _quizFinalizado = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz do Casal 💖'),
        centerTitle: true,
        backgroundColor: Colors.pinkAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: _quizFinalizado ? _buildResultadoQuiz() : _buildCorpoQuiz(),
      ),
    );
  }

  Widget _buildCorpoQuiz() {
    if (_perguntas.isEmpty) {
      return const Center(
        child: Text(
          'Nenhuma pergunta cadastrada ainda!',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      );
    }

    final perguntaAtual = _perguntas[_perguntaAtualIndex];

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Pergunta ${(_perguntaAtualIndex + 1).toString()} de ${_perguntas.length.toString()}',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.pink.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.pinkAccent.shade100),
          ),
          child: Text(
            perguntaAtual.texto,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ),
        const SizedBox(height: 24),
        ...perguntaAtual.opcoes.asMap().entries.map((entry) {
          int idx = entry.key;
          String opcaoTexto = entry.value;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pinkAccent.shade100,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(fontSize: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () => _responder(idx),
              child: Text(opcaoTexto),
            ),
          );
        }).toList(),
        const Spacer(),
      ],
    );
  }

  Widget _buildResultadoQuiz() {
    bool acertouTodas = _pontuacao == _perguntas.length;
    String imagemPath;
    String mensagemResultado;

    if (acertouTodas) {
      imagemPath =
          'assets/images/imagem_parabens.png';
      mensagemResultado = '🏆 Parabéns, você tem o gabarito do nosso amor.';
    } else {
      imagemPath =
          'assets/images/imagem_tentar_novamente.png';
      mensagemResultado = '😕 Ahn, você clicou errado?';
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagemPath,
            height: 150, 
            errorBuilder: (context, error, stackTrace) {
              return Container(
                height: 150,
                width: 150,
                color: Colors.grey[300],
                child: Center(
                  child: Icon(
                    Icons.image_not_supported,
                    color: Colors.grey[600],
                    size: 50,
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 20),

          Text(
            mensagemResultado,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: acertouTodas
                  ? Colors.green.shade700
                  : Colors.pinkAccent.shade700,
            ),
          ),
          const SizedBox(height: 20),

          Text(
            'Sua pontuação: $_pontuacao de ${_perguntas.length}',
            style: const TextStyle(
              fontSize: 20,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 30),

          ElevatedButton.icon(
            icon: const Icon(Icons.refresh),
            label: const Text('Tentar Novamente'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.pinkAccent,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              textStyle: const TextStyle(fontSize: 18),
            ),
            onPressed: _reiniciarQuiz,
          ),
        ],
      ),
    );
  }
}
