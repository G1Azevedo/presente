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
