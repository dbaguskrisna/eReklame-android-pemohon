import 'dart:convert';

import 'package:ereklame_pemohon/class/reklame.dart';
import 'package:ereklame_pemohon/screen/upload.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:http/http.dart' as http;

import '../main.dart';
import 'detail_reklame.dart';
import 'lihat_detail_reklame_aktif.dart';

class DataReklameTidakAktif extends StatefulWidget {
  const DataReklameTidakAktif({Key? key}) : super(key: key);

  @override
  State<DataReklameTidakAktif> createState() => _DataReklamePengajuanState();
}

class _DataReklamePengajuanState extends State<DataReklameTidakAktif> {
  List<Reklame> Reklames = [];
  @override
  void initState() {
    super.initState();
    bacaData();
  }

  String _temp = 'waiting API respond…';

  bacaData() {
    Reklames.clear();
    Future<String> data = fetchData();
    data.then((value) {
      Map json = jsonDecode(value);
      for (var mov in json['data']) {
        Reklame pm = Reklame.fromJson(mov);
        Reklames.add(pm);
      }
      setState(() {});
    });
  }

  void ajukanPermohonan(int idReklame) async {
    final response = await http.put(
        Uri.parse("http://10.0.2.2:8000/api/update_status_reklame"),
        body: {
          'id_reklame': idReklame.toString(),
        });

    if (response.statusCode == 200) {
      Map json = jsonDecode(response.body);
      if (json['result'] == 'success') {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Sukses Mengajukan Permohonan')));
        bacaData();
        setState(() {});
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                'Gagal Mengajukan Permohonan Silahkan Upload Berkas Terlebih Dahulu')));
      }
    } else {
      throw Exception('Failed to read API');
    }
  }

  void deleteReklame(int idReklame) async {
    print("id reklame" + idReklame.toString());
    final response = await http
        .post(Uri.parse("http://10.0.2.2:8000/api/delete_reklame"), body: {
      'id_reklame': idReklame.toString(),
    });

    if (response.statusCode == 200) {
      Map json = jsonDecode(response.body);
      if (json['result'] == 'success') {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Sukses Menghapus Data Reklame')));
        bacaData();
        setState(() {});
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Gagal Menghapus Data Reklame')));
      }
    } else {
      throw Exception('Failed to read API');
    }
  }

  Future<String> fetchData() async {
    final response = await http.post(
        Uri.parse("http://10.0.2.2:8000/api/read_reklame_tidak_aktif"),
        body: {'email': active_username});
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to read API');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Data Reklame Tidak Aktif",
            style: TextStyle(fontSize: 17),
          ),
        ),
        body: ListView(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              child: DaftarPopMovie(Reklames),
            ),
          ],
        ));
  }

  Widget DaftarPopMovie(PopMovs) {
    print(PopMovs.length);
    if (PopMovs != null) {
      return ListView.builder(
          itemCount: PopMovs.length,
          itemBuilder: (BuildContext ctxt, int index) {
            return new Card(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Nomor Formulir : ' +
                              Reklames[index].no_formulir.toString(),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    subtitle: Text('Status Reklame : Tidak Aktif')),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    const SizedBox(width: 8),
                    ElevatedButton(
                      child: const Text('Lihat Detail'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => (LihatDetailReklame(
                                reklame_id: Reklames[index].id_reklame)),
                          ),
                        );
                      },
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
              ],
            ));
          });
    } else {
      return CircularProgressIndicator();
    }
  }
}
