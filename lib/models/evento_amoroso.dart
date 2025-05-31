class EventoAmoroso {
  String id;
  final DateTime data; // Esta data é mantida como LOCAL no seu modelo
  final String titulo;
  final String descricao;
  final String imagem;

  EventoAmoroso({
    this.id = '',
    required this.data,
    required this.titulo,
    required this.descricao,
    required this.imagem,
  });

  factory EventoAmoroso.fromJson(Map<String, dynamic> json) {
    return EventoAmoroso(
      id: json['id'] ?? '',
      data: DateTime.parse(json['data']).toLocal(),
      titulo: json['titulo'] ?? '',
      descricao: json['descricao'] ?? '',
      imagem: 'https://gaybriel.up.railway.app/api/files/imagens/${json['id']}/${json['imagem']}',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.toUtc().toIso8601String(),
      'titulo': titulo,
      'descricao': descricao
    };
  }

  String get getData {
    return '${data.day.toString().padLeft(2, '0')}/${data.month.toString().padLeft(2, '0')}/${data.year}';
  }
}