import 'dart:convert';

class Profile {
  int id_user;
  String nama;
  String? alamat;
  int? no_telp;
  int? no_hp;
  String? jabatan;
  String? nama_perusahaan;
  String? alamat_perusahaan;
  int? no_telp_perusahaan;
  int? npwpd;
  String email;
  String password;
  String username;

  Profile({
    required this.id_user,
    required this.nama,
    required this.alamat,
    required this.no_telp,
    required this.no_hp,
    required this.jabatan,
    required this.nama_perusahaan,
    required this.alamat_perusahaan,
    required this.no_telp_perusahaan,
    required this.npwpd,
    required this.email,
    required this.password,
    required this.username,
  });
  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
        id_user: json['iduser'],
        nama: json['nama'],
        alamat: json['alamat'],
        no_telp: json['no_telp'],
        no_hp: json['no_hp'],
        jabatan: json['jabatan'],
        nama_perusahaan: json['nama_perusahaan'],
        alamat_perusahaan: json['alamat_perusahaan'],
        no_telp_perusahaan: json['no_telp_perusahaan'],
        npwpd: json['npwpd'],
        email: json['email'],
        password: json['password'],
        username: json['username']);
  }
}
