import 'dart:convert';

class Perpanjangan {
  int id_reklame;
  String no_formulir;
  int days;
  Perpanjangan(
      {required this.id_reklame,
      required this.no_formulir,
      required this.days});

  factory Perpanjangan.fromJson(Map<String, dynamic> json) {
    return Perpanjangan(
        no_formulir: json['no_formulir'],
        days: json['daysdiff'],
        id_reklame: json['id_reklame']);
  }
}
