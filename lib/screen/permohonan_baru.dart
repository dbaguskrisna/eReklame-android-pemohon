import 'dart:convert';

import 'package:ereklame_pemohon/class/profile.dart';
import 'package:ereklame_pemohon/screen/cari_koordinat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../main.dart';

class PermohonanBaru extends StatefulWidget {
  const PermohonanBaru({Key? key}) : super(key: key);

  @override
  State<PermohonanBaru> createState() => _PermohonanBaruState();
}

class _PermohonanBaruState extends State<PermohonanBaru> {
  static Profile? profiles;
  int no_formulir = 0;
  @override
  void initState() {
    super.initState();
    bacaData();
  }

  bacaData() {
    fetchData().then((value) {
      Map json = jsonDecode(value);
      print(json['data'][0]['no_formulir']);
      String a = json['data'][0]['no_formulir'];
      String aStr = a.replaceAll(new RegExp(r'[^0-9]'), '');
      no_formulir = int.parse(aStr) + 1;
      setState(() {});
    });
  }

  Future<String> fetchData() async {
    final response =
        await http.post(Uri.parse("http://10.0.2.2:8000/api/get_last_form"));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to read API');
    }
  }

  String tahun = DateFormat('yyyy').format(DateTime.now());
  String tanggalBulanTahun = DateFormat('yyyy-MM-dd').format(DateTime.now());
  //Dropdown letak reklame

  final nama_lengkap = TextEditingController(text: profiles?.nama);
  final email = TextEditingController(text: profiles?.email);
  final alamat = TextEditingController(text: profiles?.alamat);
  final nomor_handphone =
      TextEditingController(text: profiles?.no_hp.toString());
  final alamat_email = TextEditingController(text: profiles?.email);

  final username = TextEditingController(text: profiles?.username);
  final password = TextEditingController(text: profiles?.password);
  final namaPerusahaan = TextEditingController(text: profiles?.nama_perusahaan);

  final jabatanPerusahaan = TextEditingController(text: profiles?.jabatan);
  final alamatPerusahaan =
      TextEditingController(text: profiles?.alamat_perusahaan);
  final nomorTelpPerusahaan =
      TextEditingController(text: profiles?.no_telp_perusahaan.toString());
  final NPWPD = TextEditingController(text: profiles?.npwpd);

  final kecamatan = TextEditingController();
  final kelurahan = TextEditingController();
  final tahunPajak = TextEditingController();
  final tglPermohonan = TextEditingController();
  final sudutPandang = TextEditingController();
  final namaJalan = TextEditingController();
  final nomorJalan = TextEditingController();
  final detailLokasi = TextEditingController();
  final panjangReklame = TextEditingController();
  final lebarReklame = TextEditingController();
  final luasReklame = TextEditingController();
  final tinggiReklame = TextEditingController();
  final teks = TextEditingController();
  final rt = TextEditingController();
  final rw = TextEditingController();

  int status_pengajuan = 0;
  int status = 0;

  late LatLng coordinate = LatLng(0, 0);

  void _navigateAndDisplaySelection(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const FindCoordinate()),
    );

    coordinate = result;
  }

  void submit() async {
    print(coordinate.latitude);
    print(selectedValueJenisReklame);
    print(profiles?.id_user.toString());
    final response = await http
        .post(Uri.parse("http://10.0.2.2:8000/api/insert_reklame"), body: {
      'id_jenis_reklame': selectedValueJenisReklame,
      'id_user': profiles?.id_user.toString(),
      'id_jenis_produk': selectedValueJenisProduk,
      'id_lokasi_penempatan': selectedValueLokasiPenempatan,
      'id_status_tanah': selectedValueStatusTanah,
      'id_letak_reklame': selectedValueLetakReklame,
      'tahun_pendirian': tahun,
      'kecamatan': kecamatan.text,
      'kelurahan': kelurahan.text,
      'tahun_pajak': tahun,
      'tgl_permohonan': tanggalBulanTahun,
      'sudut_pandang': selectedValueSudutPandangReklame,
      'nama_jalan': namaJalan.text,
      'nomor_jalan': nomorJalan.text,
      'detail_lokasi': detailLokasi.text,
      'panjang_reklame': panjangReklame.text,
      'lebar_reklame': lebarReklame.text,
      'luas_reklame': luasReklame.text,
      'tinggi_reklame': tinggiReklame.text,
      'teks': teks.text,
      'no_formulir': "T-" + no_formulir.toString(),
      'status_pengajuan': status_pengajuan.toString(),
      'status': status.toString(),
      'latitude': coordinate.latitude.toString(),
      'longtitude': coordinate.longitude.toString()
    });

    if (response.statusCode == 200) {
      Map json = jsonDecode(response.body);
      if (json['result'] == 'success') {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Sukses Menambah Data')));
      }
    } else {
      throw Exception('Failed to read API');
    }
  }

  String selectedValueLetakReklame = "1";
  List<DropdownMenuItem<String>> get letakReklameItems {
    List<DropdownMenuItem<String>> letakReklame = [
      DropdownMenuItem(child: Text("Didalam ruangan"), value: "1"),
      DropdownMenuItem(child: Text("Diluar ruangan"), value: "2"),
    ];
    return letakReklame;
  }

  //Dropdown status tanah
  String selectedValueStatusTanah = "1";
  List<DropdownMenuItem<String>> get statusTanahItems {
    List<DropdownMenuItem<String>> statusTanah = [
      DropdownMenuItem(
          child: Text("Tanah Dinas Instansi Luar Pemda"), value: "1"),
      DropdownMenuItem(child: Text("Tanah Pemda"), value: "2"),
      DropdownMenuItem(child: Text("Tanah Swasta"), value: "3"),
      DropdownMenuItem(child: Text("Tanah Swasta(Damija)"), value: "4"),
    ];
    return statusTanah;
  }

  //Lokasi penempatan
  String selectedValueLokasiPenempatan = "1";
  List<DropdownMenuItem<String>> get lokasiPenempatanItems {
    List<DropdownMenuItem<String>> lokasiPenempatan = [
      DropdownMenuItem(child: Text("Bando Jalan"), value: "1"),
      DropdownMenuItem(child: Text("Di atas bangunan"), value: "2"),
      DropdownMenuItem(child: Text("Halte"), value: "3"),
      DropdownMenuItem(child: Text("Jalur Hijau"), value: "4"),
      DropdownMenuItem(child: Text("Jembatan Penyebrangan Orang"), value: "5"),
      DropdownMenuItem(child: Text("Jembatan selain JPO"), value: "6"),
      DropdownMenuItem(child: Text("Median Jalan"), value: "7"),
      DropdownMenuItem(child: Text("Menempel pada konstruksi"), value: "8"),
      DropdownMenuItem(child: Text("Penerangan Jalan Umum"), value: "9"),
      DropdownMenuItem(child: Text("Persil"), value: "10"),
      DropdownMenuItem(child: Text("Pos Polisi"), value: "11"),
      DropdownMenuItem(child: Text("Pulau Jalan"), value: "12"),
      DropdownMenuItem(child: Text("Sempadan rel kereta api"), value: "13"),
      DropdownMenuItem(child: Text("Sempadan sungai"), value: "14"),
      DropdownMenuItem(child: Text("Signage"), value: "15"),
      DropdownMenuItem(child: Text("Taman Kota/Monumen"), value: "16"),
    ];
    return lokasiPenempatan;
  }

  //Jenis Produk
  String selectedValueJenisProduk = "1";
  List<DropdownMenuItem<String>> get jenisProdukItems {
    List<DropdownMenuItem<String>> jenisProduk = [
      DropdownMenuItem(child: Text("Rokok"), value: "1"),
      DropdownMenuItem(child: Text("Non rokok"), value: "2"),
    ];
    return jenisProduk;
  }

  //Jenis Reklame
  String selectedValueJenisReklame = "1";
  List<DropdownMenuItem<String>> get jenisReklameItems {
    List<DropdownMenuItem<String>> jenisReklame = [
      DropdownMenuItem(
          child: Text("Billboard (Papan Menempel Dengan Lampu)"), value: "1"),
      DropdownMenuItem(
          child: Text("Billboard (Papan Menempel Tanpa Lampu)"), value: "2"),
      DropdownMenuItem(
          child: Text("Billboard (Papan Tiang dengan NeonBox)"), value: "3"),
      DropdownMenuItem(
          child: Text("Billboard (Papan Tiang dengan Penerangan)"), value: "4"),
      DropdownMenuItem(
          child: Text("Billboard (Papan Tiang tanpa Penerangan)"), value: "5"),
      DropdownMenuItem(child: Text("Jembatan Penyeberangan Orang"), value: "6"),
      DropdownMenuItem(child: Text("Megatron/Video/LED"), value: "7"),
    ];
    return jenisReklame;
  }

  //Sudut Pandang Reklame
  String selectedValueSudutPandangReklame = "1";
  List<DropdownMenuItem<String>> get sudutPandangItems {
    List<DropdownMenuItem<String>> sudutPandang = [
      DropdownMenuItem(child: Text("1 Sisi"), value: "1"),
      DropdownMenuItem(child: Text("2 Sisi"), value: "2"),
      DropdownMenuItem(child: Text("3 Sisi"), value: "3"),
      DropdownMenuItem(child: Text("4 Sisi"), value: "4"),
    ];
    return sudutPandang;
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    String dropdownValue = 'One';

    return Scaffold(
        appBar: AppBar(
          title: Text("Permohonan Reklame Baru"),
        ),
        body: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Image.asset('assets/image/logo.png')),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Tambah Reklame Baru',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Form Detail Titik Reklame',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    )),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    controller: namaJalan,
                    decoration: InputDecoration(
                        hintText: 'Masukkan Nama Jalan',
                        border: OutlineInputBorder(),
                        labelText: "Nama Jalan"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: nomorJalan,
                    decoration: InputDecoration(
                        hintText: 'Masukkan Nomor Jalan',
                        border: OutlineInputBorder(),
                        labelText: "Nomor Jalan"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    controller: rt,
                    decoration: InputDecoration(
                        hintText: 'Masukkan RT',
                        border: OutlineInputBorder(),
                        labelText: "RT"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    controller: rw,
                    decoration: InputDecoration(
                        hintText: 'Masukkan RW',
                        border: OutlineInputBorder(),
                        labelText: "RW"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    initialValue: tahun,
                    decoration: InputDecoration(
                        hintText: 'Tahun Pendirian',
                        border: OutlineInputBorder(),
                        labelText: "Tahun Pendirian"),
                    enabled: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    controller: kecamatan,
                    decoration: InputDecoration(
                        hintText: 'Kecamatan',
                        border: OutlineInputBorder(),
                        labelText: "Kecamatan"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    controller: kelurahan,
                    decoration: InputDecoration(
                        hintText: 'Kelurahan',
                        border: OutlineInputBorder(),
                        labelText: "Kelurahan"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    controller: detailLokasi,
                    maxLines: 5,
                    decoration: InputDecoration(
                        hintText: 'Masukkan Detail Lokasi',
                        border: OutlineInputBorder(),
                        labelText: "Detail Lokasi"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                    child: ElevatedButton(
                        child: Text('Cari Titik Reklame'),
                        onPressed: () {
                          _navigateAndDisplaySelection(context);
                        })),
                Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Form Data Objek Reklame',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    )),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    initialValue: tahun,
                    decoration: InputDecoration(
                        hintText: 'Tahun Pajak',
                        border: OutlineInputBorder(),
                        labelText: "Tahun Pajak"),
                    enabled: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    initialValue: tanggalBulanTahun,
                    decoration: InputDecoration(
                        hintText: 'Tanggal Permohonan',
                        border: OutlineInputBorder(),
                        labelText: "Tanggal Permohonan"),
                    enabled: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        labelText: "Jenis Reklame",
                        enabledBorder: OutlineInputBorder(),
                        border: OutlineInputBorder(),
                      ),
                      value: selectedValueJenisReklame,
                      onChanged: (String? newValue) {
                        selectedValueJenisReklame = newValue!;
                      },
                      items: jenisReklameItems),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        labelText: "Jenis Produk",
                        enabledBorder: OutlineInputBorder(),
                        border: OutlineInputBorder(),
                      ),
                      value: selectedValueJenisProduk,
                      onChanged: (String? newValue) {
                        selectedValueJenisProduk = newValue!;
                      },
                      items: jenisProdukItems),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        labelText: "Lokasi Penempatan",
                        enabledBorder: OutlineInputBorder(),
                        border: OutlineInputBorder(),
                      ),
                      value: selectedValueLokasiPenempatan,
                      onChanged: (String? newValue) {
                        selectedValueLokasiPenempatan = newValue!;
                      },
                      items: lokasiPenempatanItems),
                ),
                Container(
                    padding: EdgeInsets.all(10),
                    child: DropdownButtonFormField(
                        decoration: InputDecoration(
                          labelText: "Status Tanah",
                          enabledBorder: OutlineInputBorder(),
                          border: OutlineInputBorder(),
                        ),
                        value: selectedValueStatusTanah,
                        onChanged: (String? newValue) {
                          selectedValueStatusTanah = newValue!;
                        },
                        items: statusTanahItems)),
                Container(
                    padding: EdgeInsets.all(10),
                    child: DropdownButtonFormField(
                        decoration: InputDecoration(
                          labelText: "Letak Reklame",
                          enabledBorder: OutlineInputBorder(),
                          border: OutlineInputBorder(),
                        ),
                        value: selectedValueLetakReklame,
                        onChanged: (String? newValue) {
                          selectedValueLetakReklame = newValue!;
                        },
                        items: letakReklameItems)),
                Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Atribut Reklame Lainnya',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    )),
                Container(
                    padding: EdgeInsets.all(10),
                    child: DropdownButtonFormField(
                        decoration: InputDecoration(
                          labelText: "Sudut Pandang Reklame",
                          enabledBorder: OutlineInputBorder(),
                          border: OutlineInputBorder(),
                        ),
                        value: selectedValueSudutPandangReklame,
                        onChanged: (String? newValue) {
                          selectedValueSudutPandangReklame = newValue!;
                        },
                        items: sudutPandangItems)),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    controller: panjangReklame,
                    decoration: InputDecoration(
                        hintText: 'Panjang Reklame',
                        border: OutlineInputBorder(),
                        labelText: "Panjang Reklame"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Align(
                            alignment: Alignment
                                .centerLeft, // Align however you like (i.e .centerRight, centerLeft)
                            child: Text(
                              " Satuan reklame menggunakan m\u00B2",
                            ),
                          ),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          controller: lebarReklame,
                          decoration: InputDecoration(
                              hintText: 'Lebar Reklame',
                              border: OutlineInputBorder(),
                              labelText: "Lebar Reklame"),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                      ],
                    )),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: luasReklame,
                    decoration: InputDecoration(
                        hintText: 'Luas Reklame',
                        border: OutlineInputBorder(),
                        labelText: "Luas Reklame"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: tinggiReklame,
                    decoration: InputDecoration(
                        hintText: 'Tinggi',
                        border: OutlineInputBorder(),
                        labelText: "Tinggi"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    controller: teks,
                    maxLines: 3,
                    decoration: InputDecoration(
                        hintText: 'Teks Reklame',
                        border: OutlineInputBorder(),
                        labelText: "Teks Reklame"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                    child: ElevatedButton(
                        child: Text('Daftar Baru'),
                        onPressed: () {
                          print('halo');
                          submit();
                          print(coordinate.toString());
                        })),
              ],
            )));
  }
}
