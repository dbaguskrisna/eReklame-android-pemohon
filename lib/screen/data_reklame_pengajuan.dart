import 'dart:convert';

import 'package:ereklame_pemohon/class/reklame.dart';
import 'package:ereklame_pemohon/screen/upload.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:http/http.dart' as http;

import '../main.dart';
import 'detail_reklame.dart';

class DataReklamePengajuan extends StatefulWidget {
  const DataReklamePengajuan({Key? key}) : super(key: key);

  @override
  State<DataReklamePengajuan> createState() => _DataReklamePengajuanState();
}

class _DataReklamePengajuanState extends State<DataReklamePengajuan> {
  List<Reklame> Reklames = [];
  late String _token;
  @override
  void initState() {
    super.initState();
    bacaData();
    bacaDataToken();
  }

  String constructFCMPayloadTerverifikasi(String? token, String? noReklame) {
    return jsonEncode({
      'to': token,
      "collapse_key": "type_a",
      "notification": {
        "body": "Reklame Nomor : $noReklame di Ajukan",
        "title": "Notifikasi eReklame"
      },
    });
  }

  Future<void> sendPushMessage(String _token, String noReklame) async {
    if (_token == null) {
      print('Unable to send FCM message, no token exists.');
      return;
    }
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          "Content-Type": "application/json",
          "Authorization":
              "key=AAAAO5KWOuY:APA91bHcHBZPW9Y90d2pSPp2NFSYhnrw4drVTPFXvcGBj01JWcmYry8huVm4DkXKMbqM6IVlq-NPqGy8V1biekO7_JhVRGeTp0w8WAl7S7DK_umBnC85r_y9tKw6DQrEIR-2fFqvfVgW"
        },
        body: constructFCMPayloadTerverifikasi(_token, noReklame),
      );
      print('FCM request for device sent!');
    } catch (e) {
      print(e);
    }
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

  bacaDataToken() {
    fetchToken().then((value) {
      Map json = jsonDecode(value);
      print(json['data'][0]['token']);
      _token = json['data'][0]['token'];
      setState(() {});
    });
  }

  Future<String> fetchToken() async {
    final response =
        await http.post(Uri.parse("http://10.0.2.2:8000/api/read_token"));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to read API');
    }
  }

  void ajukanPermohonan(int idReklame) async {
    print(idReklame.toString());
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
        setState(() {
          bacaData();
        });
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
        Uri.parse("http://10.0.2.2:8000/api/read_reklame"),
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
            "Reklame Dalam Proses Pengajuan",
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
            print(Reklames[index].no_formulir);
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
                                              "Id reklame" +
                                              Reklames[index]
                                                  .id_reklame
                                                  .toString() +
                                              " ? "),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, 'Cancel'),
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            deleteReklame(
                                                Reklames[index].id_reklame);
                                          },
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    ));
                          },
                          icon: Icon(Icons.delete, size: 20))
                    ],
                  ),
                  subtitle: Text('Status Pengajuan : ' +
                      statusPengajuan(Reklames[index].status_pengajuan)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    ElevatedButton(
                      child: Text('Ajukan Permohonan'),
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
                                      onPressed: () {
                                        ajukanPermohonan(
                                            Reklames[index].id_reklame);
                                        sendPushMessage(_token,
                                            Reklames[index].no_formulir);
                                      },
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

  String statusPengajuan(int statusPengajuan) {
    if (statusPengajuan == 1) {
      return "Sudah di ajukan";
    } else if (statusPengajuan == 2) {
      return "Reklame diterima";
    } else if (statusPengajuan == 3) {
      return "Reklame kekurangan berkas";
    } else {
      return "belum di ajukan";
    }
  }
}
