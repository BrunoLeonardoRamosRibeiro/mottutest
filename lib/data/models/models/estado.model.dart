// To parse this JSON data, do
//
//     final estado = estadoFromJson(jsonString);

import 'dart:convert';

Estado estadoFromJson(String str) => Estado.fromJson(json.decode(str));

String estadoToJson(Estado data) => json.encode(data.toJson());

class Estado {
  Estado({
    required this.id,
    required this.sigla,
    required this.nome,
  });

  int id;
  String sigla;
  String nome;

  Estado copyWith({
    int? id,
    String? sigla,
    String? nome,
  }) =>
      Estado(
        id: id ?? this.id,
        sigla: sigla ?? this.sigla,
        nome: nome ?? this.nome,
      );

  factory Estado.fromJson(Map<String, dynamic> json) => Estado(
    id: json["id"] == null ? null : json["id"],
    sigla: json["sigla"] == null ? null : json["sigla"],
    nome: json["nome"] == null ? null : json["nome"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "sigla": sigla == null ? null : sigla,
    "nome": nome == null ? null : nome,
  };
}
