import 'package:flutter/material.dart';
import '../models/evento_amoroso.dart';

class LinhaDoTempoPage extends StatelessWidget {
  const LinhaDoTempoPage({super.key});

  final List<EventoAmoroso> eventos = const [
    EventoAmoroso(
      data: '09/07/2022',
      titulo: 'Nosso Primeiro Encontro',
      descricao: 'Aquele dia mágico em que nossos olhares se cruzaram 💫',
      imagem: 'assets/images/encontro.jpg',
    ),
    EventoAmoroso(
      data: '20/07/2022',
      titulo: 'Dia do Nosso Primeiro Beijo',
      descricao:
          'O dia em que finalmente nossos lábios se encontraram pela primeira vez 💋',
      imagem: 'assets/images/beijo.jpg',
    ),
    EventoAmoroso(
      data: '04/10/2022',
      titulo: 'Primeira Vez no Circo',
      descricao: 'Será que foi lá que eu aprendi a fazer palhaçada? 🤡',
      imagem: 'assets/images/circo.jpg',
    ),
    EventoAmoroso(
      data: '17/10/2025',
      titulo: 'Tomando milkshake com nosso pet',
      descricao:
          'Acho que foi a primeira vez que levamos nosso pet pra passear 🐹',
      imagem: 'assets/images/pet.jpg',
    ),
    EventoAmoroso(
      data: '30/10/2022',
      titulo: 'Decidindo o destino do país',
      descricao: 'Quando a gente fingiu que votava no 👆',
      imagem: 'assets/images/voto.jpg',
    ),
    EventoAmoroso(
      data: '12/11/2022',
      titulo: 'Pedido de namoro',
      descricao: 'O momento que nossos corações se fundiram em um 💞',
      imagem: 'assets/images/namoro.jpg',
    ),
    EventoAmoroso(
      data: '24/11/2022',
      titulo: 'Primeira Copa do Mundo',
      descricao: 'Fomos pé quente, o Brasil ganhou nesse dia 🇧🇷',
      imagem: 'assets/images/copa.jpg',
    ),
    EventoAmoroso(
      data: '31/12/2022',
      titulo: 'Primeiro Ano Novo ',
      descricao: 'FELIZ ANO NOVOOOO! 🎆',
      imagem: 'assets/images/novo.jpg',
    ),
    EventoAmoroso(
      data: '01/01/2023',
      titulo: 'Curtindo o primeiro dia do ano',
      descricao: 'Acho que foi a segundo dia que você foi lá em casa 😴',
      imagem: 'assets/images/casa.jpg',
    ),
    EventoAmoroso(
      data: '04/04/2023',
      titulo: 'Dia de Piscina (AABB)',
      descricao: 'Escorregamos bastante no tobogã ⛱',
      imagem: 'assets/images/aabb.jpg',
    ),
    EventoAmoroso(
      data: '16/07/2023',
      titulo: 'Crisma',
      descricao: 'Um momento especial na sua caminhada de fé 🙏',
      imagem: 'assets/images/crisma.jpg',
    ),
    EventoAmoroso(
      data: '23/07/2023',
      titulo: 'Filme da Barbie',
      descricao: 'Aqui você me tirou pra melhor amiga💅',
      imagem: 'assets/images/barbie.jpg',
    ),
    EventoAmoroso(
      data: '30/07/2023',
      titulo: 'Procissão',
      descricao: 'Participamos da procissão de mãos dadas, um momento de paz ✨',
      imagem: 'assets/images/procissao.jpg',
    ),
    EventoAmoroso(
      data: '09/12/2023',
      titulo: 'Formatura',
      descricao: 'Comemorando um dos seus grandes passos 🎓',
      imagem: 'assets/images/formatura.jpg',
    ),
    EventoAmoroso(
      data: '31/12/2023',
      titulo: 'Ano Novo',
      descricao: 'Começamos o ano novo juntos com muito amor e esperança 🎆',
      imagem: 'assets/images/anonovo.jpg',
    ),
    EventoAmoroso(
      data: '11/02/2024',
      titulo: 'Carnaval',
      descricao: 'Festejamos como se estivessemos a sós 🎭',
      imagem: 'assets/images/carnaval.jpg',
    ),
    EventoAmoroso(
      data: '26/07/2024',
      titulo: 'Festa de Santana',
      descricao: 'Lampião e Maria Bonita exibem seus saques 🤠',
      imagem: 'assets/images/festasantana.jpg',
    ),
    EventoAmoroso(
      data: '01/05/2025',
      titulo: 'Nossa Viagem a João Pessoa',
      descricao:
          'Nossa primeira viagem juntinhos, foi muito legal poder aproveitar com você 🌅',
      imagem: 'assets/images/joao_pessoa.jpg', // Imagem da viagem
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Linha do Tempo do Amor 💖'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: eventos.length,
        itemBuilder: (context, index) {
          final evento = eventos[index];
          return Card(
            margin: const EdgeInsets.all(12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 500,
                  decoration: BoxDecoration(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(16)),
                    image: DecorationImage(
                      image: AssetImage(evento.imagem),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.favorite, color: Colors.pink),
                  title: Text(evento.titulo,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(evento.data,
                          style: const TextStyle(color: Colors.grey)),
                      const SizedBox(height: 4),
                      Text(evento.descricao),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
