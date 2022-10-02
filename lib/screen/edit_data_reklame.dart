import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../class/detail_reklame.dart';
import 'cari_koordinat.dart';
import 'edit_coordinate.dart';

class EditReklame extends StatefulWidget {
  final int reklame_id;
  const EditReklame({Key? key, required this.reklame_id}) : super(key: key);

  @override
  State<EditReklame> createState() => _EditReklameState();
}

class _EditReklameState extends State<EditReklame> {
  DetailReklame? detailReklames;
  late LatLng coordinate = LatLng(0, 0);
  final _namaJalan = TextEditingController();
  final _nomorJalan = TextEditingController();
  final _tahunPendirian = TextEditingController();
  final _kecamatan = TextEditingController();
  final _kelurahan = TextEditingController();
  final _detailLokasi = TextEditingController();
  final _tahunPajak = TextEditingController();
  final _tanggalPermohonan = TextEditingController();
  final _panjang = TextEditingController();
  final _lebar = TextEditingController();
  final _tinggi = TextEditingController();
  final _text = TextEditingController();
  final _luas = TextEditingController();

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
  void initState() {
    super.initState();
    bacaData();
  }

  late String _token = "-";

  bacaData() {
    fetchData().then((value) {
      Map json = jsonDecode(value);
      print(json['data'][0]);
      detailReklames = DetailReklame.fromJson(json['data'][0]);
      setState(() {
        _namaJalan.text = detailReklames!.nama_jalan;
        _nomorJalan.text = detailReklames!.nomor_jalan.toString();
        _tahunPendirian.text = detailReklames!.tahun_pendirian.toString();
        _kecamatan.text = detailReklames!.kecamatan;
        _kelurahan.text = detailReklames!.kelurahan;
        _detailLokasi.text = detailReklames!.detail_lokasi;
        _tahunPajak.text = detailReklames!.tahun_pajak.toString();
        _tanggalPermohonan.text = detailReklames!.tgl_permohonan;
        selectedValueJenisProduk = detailReklames!.id_jenis_produk.toString();
        selectedValueLetakReklame = detailReklames!.id_letak_reklame.toString();
        selectedValueJenisReklame = detailReklames!.id_jenis_reklame.toString();
        selectedValueLokasiPenempatan =
            detailReklames!.id_lokasi_penempatan.toString();
        selectedValueSudutPandangReklame =
            detailReklames!.sudut_pandang.toString();
        selectedValueStatusTanah = detailReklames!.id_status_tanah.toString();
        _panjang.text = detailReklames!.panjang_reklame.toString();
        _lebar.text = detailReklames!.lebar_reklame.toString();
        _luas.text = detailReklames!.luas_reklame.toString();
        _tinggi.text = detailReklames!.tinggi_reklame.toString();
        _text.text = detailReklames!.teks;
      });
    });
  }

  void submit() async {
    print(coordinate.latitude);
    print(coordinate.longitude);
    final response = await http
        .put(Uri.parse("http://10.0.2.2:8000/api/update_reklame"), body: {
      'id_reklame': widget.reklame_id.toString(),
      'id_jenis_produk': selectedValueJenisProduk,
      'id_lokasi_penempatan': selectedValueLokasiPenempatan,
      'id_status_tanah': selectedValueStatusTanah,
      'id_letak_reklame': selectedValueLetakReklame,
      'id_jenis_reklame': selectedValueJenisReklame,
      'tahun_pendirian': _tahunPendirian.text,
      'kecamatan': _kecamatan.text,
      'kelurahan': _kelurahan.text,
      'tahun_pajak': _tahunPajak.text,
      'sudut_pandang': selectedValueSudutPandangReklame,
      'nama_jalan': _namaJalan.text,
      'nomor_jalan': _nomorJalan.text,
      'detail_lokasi': _detailLokasi.text,
      'panjang_reklame': _panjang.text,
      'lebar_reklame': _lebar.text,
      'luas_reklame': _luas.text,
      'tinggi_reklame': _tinggi.text,
      'teks': _text.text,
      'latitude': coordinate.latitude.toString(),
      'longtitude': coordinate.longitude.toString(),
    });

    if (response.statusCode == 200) {
      Map json = jsonDecode(response.body);
      if (json['result'] == 'success') {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Update Data Berhasil')));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Gagal Berhasil')));
      }
    } else {
      throw Exception('Failed to read API');
    }
  }

  Future<String> fetchData() async {
    final response = await http.post(
        Uri.parse("http://10.0.2.2:8000/api/read_reklame_detail"),
        body: {'id_reklame': widget.reklame_id.toString()});
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to read API');
    }
  }

  Future<String> fetchToken() async {
    final response = await http
        .post(Uri.parse("http://10.0.2.2:8000/api/read_reklame_detail"));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to read API');
    }
  }

  @override
  Widget build(BuildContext context) {
    void _navigateAndDisplaySelection(BuildContext context) async {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                EditKoordinat(no_reklame: detailReklames!.no_formulir)),
      );

      coordinate = result;
    }

    if (detailReklames == null) {
      return Scaffold(
          appBar: AppBar(
            title: Text("Lihat Detail Reklame"),
          ),
          body: Center(
            child: LoadingAnimationWidget.staggeredDotsWave(
              color: Colors.blue,
              size: 80,
            ),
          ));
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text("Lihat Detail Reklame"),
        ),
        body: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Nomor Formulir Reklame : ' +
                        detailReklames!.no_formulir.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    textAlign: TextAlign.center,
                  )),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: alasanWidget(
                  detailReklames!.status.toString(), detailReklames!.alasan),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Form Detail Titik Reklame',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    textAlign: TextAlign.center,
                  )),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nama Jalan',
                ),
                controller: _namaJalan,
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nomor Jalan',
                ),
                controller: _nomorJalan,
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Tahun Pendirian',
                ),
                controller: _tahunPendirian,
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Kecamatan',
                  ),
                  controller: _kecamatan),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Kelurahan',
                ),
                controller: _kelurahan,
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Detail Lokasi',
                ),
                controller: _detailLokasi,
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: ElevatedButton(
                onPressed: () {
                  _navigateAndDisplaySelection(context);
                },
                child: const Text('Ubah titik lokasi reklame'),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Data Objek Reklame',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    textAlign: TextAlign.center,
                  )),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Tahun Pajak',
                    enabled: false),
                controller: _tahunPajak,
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Tanggal Permohonan',
                ),
                controller: _tanggalPermohonan,
                enabled: false,
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
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Atribut Reklame Lainnya',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    textAlign: TextAlign.center,
                  )),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: DropdownButtonFormField(
                  decoration: InputDecoration(
                    labelText: "Sudut Pandang",
                    enabledBorder: OutlineInputBorder(),
                    border: OutlineInputBorder(),
                  ),
                  value: selectedValueSudutPandangReklame,
                  onChanged: (String? newValue) {
                    selectedValueSudutPandangReklame = newValue!;
                  },
                  items: sudutPandangItems),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Panjang Reklame',
                ),
                controller: _panjang,
                onChanged: (text) {
                  if (_lebar.text != null && _panjang.text != null) {
                    double lebar = double.parse(_lebar.text.toString());
                    double panjang = double.parse(_panjang.text.toString());
                    double hasil = lebar * panjang;
                    _luas.text = hasil.toStringAsFixed(2);
                  }
                },
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Lebar Reklame',
                ),
                controller: _lebar,
                onChanged: (text) {
                  if (_lebar.text != null && _panjang.text != null) {
                    double lebar = double.parse(_lebar.text.toString());
                    double panjang = double.parse(_panjang.text.toString());
                    double hasil = lebar * panjang;
                    _luas.text = hasil.toStringAsFixed(2);
                  }
                },
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Luas Reklame',
                ),
                controller: _luas,
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Tinggi Reklame',
                ),
                controller: _tinggi,
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Teks Reklame',
                ),
                controller: _text,
              ),
            ),
            Container(
                height: 50,
                padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: ElevatedButton(
                    child: Text('Edit Data Reklame'),
                    onPressed: () {
                      submit();
                    })),
          ],
        ),
      );
    }
  }

  Widget alasanWidget(String status, String alasan) {
    if (status == '2') {
      return Container(
        child: Column(children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Alasan Berkas Dicabut : ',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: 10),
              child: TextFormField(
                maxLines: 5,
                decoration: InputDecoration(border: OutlineInputBorder()),
                initialValue: alasan,
                enabled: false,
              )),
        ]),
      );
    } else {
      return Text('');
    }
  }
}
