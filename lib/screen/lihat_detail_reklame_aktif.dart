import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../class/detail_reklame.dart';

class LihatDetailReklame extends StatefulWidget {
  final int reklame_id;
  const LihatDetailReklame({Key? key, required this.reklame_id})
      : super(key: key);

  @override
  State<LihatDetailReklame> createState() => _LihatDetailReklameState();
}

class _LihatDetailReklameState extends State<LihatDetailReklame> {
  DetailReklame? detailReklames;

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
      setState(() {});
    });
    setState(() {});
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
              padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
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
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Tanggal Berlaku Reklame : ',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    textAlign: TextAlign.center,
                  )),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Tanggal Berlaku Reklame',
                ),
                initialValue: detailReklames!.tgl_awal +
                    " s/d " +
                    detailReklames!.tgl_akhir,
                enabled: false,
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Data Pemohon : ',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    textAlign: TextAlign.center,
                  )),
            ),
            Container(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'E-mail',
                  ),
                  initialValue: detailReklames!.email,
                  enabled: false,
                )),
            Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nama Pemohon',
                ),
                initialValue: detailReklames!.nama,
                enabled: false,
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Alamat',
                ),
                initialValue: detailReklames!.alamat,
                enabled: false,
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nomor Telp',
                ),
                initialValue: detailReklames!.no_hp.toString(),
                enabled: false,
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nama Perusahaan',
                ),
                initialValue: detailReklames!.no_hp.toString(),
                enabled: false,
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Alamat Perusahaan',
                ),
                initialValue: detailReklames!.alamat,
                enabled: false,
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'NPWPD',
                ),
                initialValue: detailReklames!.npwpd,
                enabled: false,
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Form Detail Titik Reklame',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    textAlign: TextAlign.center,
                  )),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nama Jalan',
                ),
                initialValue: detailReklames!.nama_jalan,
                enabled: false,
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nomor Jalan',
                ),
                initialValue: detailReklames!.nomor_jalan.toString(),
                enabled: false,
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Tahun Pendirian',
                ),
                initialValue: detailReklames!.tahun_pendirian.toString(),
                enabled: false,
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Kecamatan',
                ),
                initialValue: detailReklames!.kecamatan,
                enabled: false,
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Kelurahan',
                ),
                initialValue: detailReklames!.no_hp.toString(),
                enabled: false,
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Detail Lokasi',
                ),
                initialValue: detailReklames!.no_hp.toString(),
                enabled: false,
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Data Objek Reklame',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    textAlign: TextAlign.center,
                  )),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Tahun Pajak',
                ),
                initialValue: detailReklames!.tahun_pajak.toString(),
                enabled: false,
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Tanggal Permohonan',
                ),
                initialValue: detailReklames!.tgl_permohonan,
                enabled: false,
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Jenis Reklame',
                ),
                initialValue: detailReklames!.jenis_reklame,
                enabled: false,
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Jenis Produk',
                ),
                initialValue: detailReklames!.jenis_produk,
                enabled: false,
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Lokasi Penempatan',
                ),
                initialValue: detailReklames!.lokasi_penempatan,
                enabled: false,
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Status Tanah',
                ),
                initialValue: detailReklames!.nama_status_tanah,
                enabled: false,
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Letak Reklame',
                ),
                initialValue: detailReklames!.letak,
                enabled: false,
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Atribut Reklame Lainnya',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    textAlign: TextAlign.center,
                  )),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Sudut Pandang',
                ),
                initialValue: detailReklames!.sudut_pandang.toString() + " m",
                enabled: false,
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Panjang Reklame',
                ),
                initialValue: detailReklames!.panjang_reklame.toString() + " m",
                enabled: false,
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Lebar Reklame',
                ),
                initialValue: detailReklames!.lebar_reklame.toString() + " m",
                enabled: false,
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Luas Reklame',
                ),
                initialValue:
                    detailReklames!.panjang_reklame.toString() + " m\u00B2 ",
                enabled: false,
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Tinggi Reklame',
                ),
                initialValue: detailReklames!.tinggi_reklame.toString() + " m",
                enabled: false,
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Teks Reklame',
                ),
                initialValue: detailReklames!.teks,
                enabled: false,
              ),
            ),
          ],
        ),
      );
    }
  }
}
