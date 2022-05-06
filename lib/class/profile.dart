import 'dart:convert';

class Profile {
  int? id_user;
  String? nama;
  String? alamat;
  int? no_telp;
  int? no_hp;
  String? jabatan;
  String? nama_perusahaan;
  String? alamat_perusahaan;
  int? no_telp_perusahaan;
  int? npwpd;
  String? email;
  String? password;
  String? username;

  Profile(
      {required id_user,
      required nama,
      required alamat,
      required no_telp,
      required no_hp,
      required jabatan,
      required nama_perusahaan,
      required alamat_perusahaan,
      required no_telp_perusahaan,
      required npwpd,
      required email,
      required password,
      required username});
  factory Profile.fromJson(Map<String, dynamic> json) {
    print(json['username']);

    return Profile(
      id_user: json['id_user'],
      nama: json['nama'],
      alamat: json['alamat'],
      no_telp: json['no_telp'],
      no_hp: json['no_hp'],
      jabatan: json['jabatan'],
      nama_perusahaan: json['jabatan'],
      alamat_perusahaan: json['nama_perusahaan'],
      no_telp_perusahaan: json['alamat_perusahaan'],
      npwpd: json['npwpd'],
      email: json['email'],
      password: json['password'],
      username: json['username'],
    );
  }
}
