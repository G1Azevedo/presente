class EventoAmoroso {
  final String data;
  final String titulo;
  final String descricao;
  final String imagem;

  const EventoAmoroso({
    // <- adicionado "const" aqui
    required this.data,
    required this.titulo,
    required this.descricao,
    required this.imagem,
  });
}
