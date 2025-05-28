import 'package:flutter/material.dart';
import 'package:linha_do_tempo_amor/utils/pocketbase.dart';
import '../models/evento_amoroso.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';

class LinhaDoTempoPage extends StatefulWidget {
  const LinhaDoTempoPage({super.key});

  @override
  State<LinhaDoTempoPage> createState() => _LinhaDoTempoPageState();
}

class _LinhaDoTempoPageState extends State<LinhaDoTempoPage> {
  final TextEditingController tituloController = TextEditingController();
  final TextEditingController descricaoController = TextEditingController();

  http.MultipartFile? imagemSelecionada;
  DateTime dataSelecionada = DateTime.now();

  Future<void> carregarFotos() async {}

  List<EventoAmoroso> eventos = [];

  bool carregando = true;

  /*
  final List<EventoAmoroso> eventos = [
    EventoAmoroso(
      data: '09/07/2022',
      titulo: 'Nosso Primeiro Encontro',
      descricao: 'Aquele dia mágico em que nossos olhares se cruzaram 💫',
      imagem: 'assets/images/encontro.jpg',
    ),
    EventoAmoroso(
      data: '20/07/2022',
      titulo: 'Dia do Nosso Primeiro Beijo',
      descricao: 'O dia em que finalmente nossos lábios se encontraram pela primeira vez 💋',
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
      descricao: 'Acho que foi a primeira vez que levamos nosso pet pra passear 🐹',
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
      descricao: 'Nossa primeira viagem juntinhos, foi muito legal poder aproveitar com você 🌅',
      imagem: 'assets/images/joao_pessoa.jpg', // Imagem da viagem
    ),
  ];
  */
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      carregarImagens();
    });
  }

  Future<void> carregarImagens() async {
    await pb.collection('imagens').getFullList(sort: 'data').then((r) {
      setState(() {
        eventos = r.map((e) => EventoAmoroso.fromJson(e.toJson())).toList();
        carregando = false;
      });
    }).catchError((e) {
      setState(() {
        carregando = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao carregar imagens.')),
        );
      }
    });
  }

  Future<bool> _showDialogCadastrarEvento() async {
    final r = await showModalBottomSheet<bool>(
      isScrollControlled: true,
      context: context,
      showDragHandle: true,
      builder: (BuildContext ctx) {
        return Padding(
          padding: EdgeInsets.only(top: 5, left: 20, right: 20, bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setEstado) {
                return Column(
                  children: [
                    TextField(
                      controller: tituloController,
                      decoration: const InputDecoration(
                        labelText: 'Título',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: descricaoController,
                      decoration: const InputDecoration(
                        labelText: 'Descrição',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () async {
                        final data = await showDatePicker(
                          context: context,
                          initialDate: dataSelecionada,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        );
                        if (data != null) {
                          setEstado(() {
                            dataSelecionada = data;
                          });
                        }
                      },
                      child: Text('Selecionar Data (${dataSelecionada.toLocal().toString().split(' ')[0]})'),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () async {
                        FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(allowMultiple: true);

                        if (pickedFile != null) {
                          setEstado(() {
                            imagemSelecionada = http.MultipartFile.fromBytes('imagem', pickedFile.files.first.bytes!,
                                filename: pickedFile.files.first.name);
                          });
                        }
                      },
                      child: const Text('Selecionar Imagem'),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        if (tituloController.text.isEmpty || descricaoController.text.isEmpty || imagemSelecionada == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Preencha todos os campos.')),
                          );
                          return;
                        }

                        final evento = EventoAmoroso(
                          titulo: tituloController.text,
                          descricao: descricaoController.text,
                          data: dataSelecionada,
                          imagem: '',
                        );

                        try {
                          await pb.collection('imagens').create(body: evento.toJson(), files: [imagemSelecionada!]);
                          Navigator.pop(context, true);
                        } catch (e) {
                          print('Erro ao cadastrar evento: $e');

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Erro ao cadastrar evento.')),
                          );
                        }
                      },
                      child: const Text('Cadastrar Evento'),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );

    return r ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Linha do Tempo do Amor 💖'),
        centerTitle: true,
      ),
      body: carregando
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
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
                      Image.network(evento.imagem, fit: BoxFit.cover, width: double.infinity),
                      ListTile(
                        leading: const Icon(Icons.favorite, color: Colors.pink),
                        title: Text(evento.titulo, style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(evento.getData, style: const TextStyle(color: Colors.grey)),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final resultado = await _showDialogCadastrarEvento();
          if (resultado) {
            carregarImagens();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
