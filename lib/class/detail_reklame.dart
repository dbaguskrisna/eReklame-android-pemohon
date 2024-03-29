import 'dart:convert';

class DetailReklame {
  int id_reklame;
  int id_jenis_reklame;
  int id_user;
  int id_jenis_produk;
  int id_lokasi_penempatan;
  int id_status_tanah;
  int id_letak_reklame;
  int tahun_pendirian;
  String kecamatan;
  String kelurahan;
  int tahun_pajak;
  String tgl_permohonan;
  int sudut_pandang;
  String nama_jalan;
  int nomor_jalan;
  String detail_lokasi;
  int panjang_reklame;
  int lebar_reklame;
  int luas_reklame;
  int tinggi_reklame;
  String teks;
  String no_formulir;
  int status_pengajuan;
  int status;
  String nama;
  String alamat;
  String no_hp;
  String jabatan;
  String nama_perusahaan;
  String alamat_perusahaan;
  String no_telp_perusahaan;
  String npwpd;
  String email;
  String jenis_produk;
  String jenis_reklame;
  String letak;
  String lokasi_penempatan;
  String nama_status_tanah;
  String token;
  String alasan;
  String tgl_awal;
  String tgl_akhir;

  DetailReklame(
      {required this.nama,
      required this.alamat,
      required this.no_hp,
      required this.jabatan,
      required this.nama_perusahaan,
      required this.alamat_perusahaan,
      required this.no_telp_perusahaan,
      required this.npwpd,
      required this.email,
      required this.token,
      required this.jenis_produk,
      required this.jenis_reklame,
      required this.letak,
      required this.lokasi_penempatan,
      required this.nama_status_tanah,
      required this.id_reklame,
      required this.id_jenis_reklame,
      required this.id_user,
      required this.id_jenis_produk,
      required this.id_lokasi_penempatan,
      required this.id_status_tanah,
      required this.id_letak_reklame,
      required this.tahun_pendirian,
      required this.kecamatan,
      required this.kelurahan,
      required this.tahun_pajak,
      required this.tgl_permohonan,
      required this.sudut_pandang,
      required this.nama_jalan,
      required this.nomor_jalan,
      required this.detail_lokasi,
      required this.panjang_reklame,
      required this.lebar_reklame,
      required this.luas_reklame,
      required this.tinggi_reklame,
      required this.teks,
      required this.no_formulir,
      required this.status_pengajuan,
      required this.status,
      required this.alasan,
      required this.tgl_awal,
      required this.tgl_akhir});

  factory DetailReklame.fromJson(Map<String, dynamic> json) {
    return DetailReklame(
        nama: json['nama'],
        alamat: json['alamat'],
        no_hp: json['no_hp'],
        jabatan: json['jabatan'],
        nama_perusahaan: json['nama_perusahaan'],
        alamat_perusahaan: json['alamat_perusahaan'],
        no_telp_perusahaan: json['no_telp_perusahaan'],
        npwpd: json['npwpd'],
        email: json['email'],
        token: json['token'],
        jenis_produk: json['nama_jenis_produk'],
        jenis_reklame: json['nama_jenis_reklame'],
        letak: json['letak'],
        lokasi_penempatan: json['lokasi_penempatan'],
        nama_status_tanah: json['nama_status_tanah'],
        id_reklame: json['id_reklame'],
        id_jenis_reklame: json['id_jenis_reklame'],
        id_user: json['id_user'],
        id_jenis_produk: json['id_jenis_produk'],
        id_lokasi_penempatan: json['id_lokasi_penempatan'],
        id_status_tanah: json['id_status_tanah'],
        id_letak_reklame: json['id_letak_reklame'],
        tahun_pendirian: json['tahun_pendirian'],
        kecamatan: json['kecamatan'],
        kelurahan: json['kelurahan'],
        tahun_pajak: json['tahun_pajak'],
        tgl_permohonan: json['tgl_permohonan'],
        sudut_pandang: json['sudut_pandang'],
        nama_jalan: json['nama_jalan'],
        nomor_jalan: json['nomor_jalan'],
        detail_lokasi: json['detail_lokasi'],
        panjang_reklame: json['panjang_reklame'],
        lebar_reklame: json['lebar_reklame'],
        luas_reklame: json['luas_reklame'],
        tinggi_reklame: json['tinggi_reklame'],
        teks: json['teks'],
        no_formulir: json['no_formulir'],
        status_pengajuan: json['status_pengajuan'],
        status: json['status'],
        alasan: json['alasan'] == null ? '' : json['alasan'],
        tgl_awal:
            json['tgl_berlaku_awal'] == '1' ? '' : json['tgl_berlaku_awal'],
        tgl_akhir:
            json['tgl_berlaku_akhir'] == '1' ? '' : json['tgl_berlaku_akhir']);
  }
}
