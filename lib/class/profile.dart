import 'dart:convert';

class Profiles {
  int id_user;
  String nama;
  String alamat;
  String no_hp;
  String jabatan;
  String nama_perusahaan;
  String alamat_perusahaan;
  String no_telp_perusahaan;
  String npwpd;
  String email;
  String password;

  Profiles({
    required this.id_user,
    required this.nama,
    required this.alamat,
    required this.no_hp,
    required this.jabatan,
    required this.nama_perusahaan,
    required this.alamat_perusahaan,
    required this.no_telp_perusahaan,
    required this.npwpd,
    required this.email,
    required this.password,
  });

  factory Profiles.fromJson(Map<String, dynamic> json) {
    print(json['nama_perusahaan']);
    return Profiles(
      id_user: json['iduser'],
      nama: json['nama'],
      alamat: json['alamat'],
      no_hp: json['no_hp'],
      jabatan: json['jabatan'],
      nama_perusahaan: json['nama_perusahaan'],
      alamat_perusahaan: json['alamat_perusahaan'],
      no_telp_perusahaan: json['no_telp_perusahaan'],
      npwpd: json['npwpd'],
      email: json['email'],
      password: json['password'],
    );
  }
}
