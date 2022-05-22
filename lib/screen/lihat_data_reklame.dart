import 'dart:convert';

import 'package:ereklame_pemohon/class/reklame.dart';
import 'package:ereklame_pemohon/screen/upload.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:http/http.dart' as http;

import '../main.dart';
import 'detail_reklame.dart';

class DataReklame extends StatefulWidget {
  const DataReklame({Key? key}) : super(key: key);

  @override
  State<DataReklame> createState() => _DataReklameState();
}

class _DataReklameState extends State<DataReklame> {
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

  Future<String> fetchData() async {
    final response = await http.post(
        Uri.parse("http://10.0.2.2:8000/api/read_reklame"),
        body: {'user': active_username});
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
          title: Text("Data Reklame"),
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
                      IconButton(
                          onPressed: () {
                            showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                      title: const Text('Peringatan'),
                                      content: Text(
                                          'Apakah Yakin Akan Menghapus Berkas ' +
                                              Reklames[index]
                                                  .no_formulir
                                                  .toString() +
                                              " ? "),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, 'Cancel'),
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, 'OK'),
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    ));
                          },
                          icon: Icon(Icons.delete, size: 20))
                    ],
                  ),
                  subtitle: Text(
                    'Status Pengajuan : ' + Reklames[index].status.toString(),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    ElevatedButton(
                      child: const Text('Ajukan Permohonan'),
                      onPressed: () {
                        showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                                  title: const Text('Peringatan'),
                                  content: Text(
                                      'Apakah yakin akan melakukan pengajuan permohonan dengan nomor : ' +
                                          Reklames[index]
                                              .no_formulir
                                              .toString() +
                                          " ? "),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, 'Cancel'),
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, 'OK'),
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ));
                      },
                    ),
                    const SizedBox(width: 8),
                    TextButton(
                      child: const Text('Upload Berkas'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UploadDocument(
                                reklame_id: Reklames[index].id_reklame),
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
