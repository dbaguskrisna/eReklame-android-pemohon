import 'dart:convert';

import 'package:ereklame_pemohon/class/profile.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import 'package:http/http.dart' as http;

class DataUser extends StatefulWidget {
  const DataUser({Key? key}) : super(key: key);

  @override
  State<DataUser> createState() => _DataUserState();
}

class _DataUserState extends State<DataUser> {
  static Profile? profiles;

  final nama_lengkap = TextEditingController(text: profiles?.nama);
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

  @override
  void initState() {
    super.initState();
    bacaData();
  }

  bacaData() {
    fetchData().then((value) {
      Map json = jsonDecode(value);
      profiles = Profile.fromJson(json['data'][0]);
      print(json['data'][0]);

      setState(() {});
    });
  }

  Future<String> fetchData() async {
    final response = await http.post(
        Uri.parse("http://10.0.2.2:8000/api/read_user"),
        body: {'username': active_username});
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to read API');
    }
  }

  void submit() async {
    final response = await http
        .put(Uri.parse("http://10.0.2.2:8000/api/update_user"), body: {
      'nama_lengkap': nama_lengkap.text,
      'no_hp': nomor_handphone.text,
      'alamat': alamat.text,
      'nama_perusahaan': namaPerusahaan.text,
      'jabatan': jabatanPerusahaan.text,
      'alamat_perusahaan': alamatPerusahaan.text,
      'no_telp_perusahaan': nomorTelpPerusahaan.text,
      'npwpd': nomor_handphone.text,
      'username': active_username
    });

    if (response.statusCode == 200) {
      Map json = jsonDecode(response.body);
      if (json['result'] == 'success') {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Update Data Berhasil')));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Silahkan Ubah Data')));
      }
    } else {
      throw Exception('Failed to read API');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Profile'),
      ),
      body: ListView(
        children: [
          Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
              child: Image.asset('assets/image/logo.png')),
          Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
              child: Text(
                'Data Profil',
                style: TextStyle(fontSize: 18),
              )),
          Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.all(10),
              child: Text(
                'Data Pribadi',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              )),
          Container(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              enabled: false,
              initialValue: profiles!.username,
              decoration: InputDecoration(
                  labelText: 'Username',
                  hintText: 'Username',
                  border: OutlineInputBorder()),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              decoration: InputDecoration(
                  labelText: 'Nama Lengkap',
                  hintText: "Nama lengkap",
                  border: OutlineInputBorder()),
              controller: nama_lengkap,
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              decoration: InputDecoration(
                  labelText: 'No HP',
                  hintText: 'No HP',
                  border: OutlineInputBorder()),
              controller: nomor_handphone,
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              decoration: InputDecoration(
                  labelText: 'Alamat',
                  hintText: 'Alamat',
                  border: OutlineInputBorder()),
              controller: alamat,
            ),
          ),
          Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.all(10),
              child: Text(
                'Data Perusahaan',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              )),
          Container(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              decoration: InputDecoration(
                  labelText: 'Nama Perusahaan',
                  hintText: 'Nama Perusahaan',
                  border: OutlineInputBorder()),
              controller: namaPerusahaan,
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              decoration: InputDecoration(
                  labelText: "Jabatan",
                  hintText: 'Jabatan',
                  border: OutlineInputBorder()),
              controller: jabatanPerusahaan,
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              decoration: InputDecoration(
                  labelText: "Alamat Perusahaan",
                  hintText: 'Alamat Perusahaan',
                  border: OutlineInputBorder()),
              controller: alamat,
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              decoration: InputDecoration(
                  labelText: "No Telp Perusahaan",
                  hintText: 'No Telp Perusahaan',
                  border: OutlineInputBorder()),
              controller: nomorTelpPerusahaan,
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              decoration: InputDecoration(
                  labelText: "NPWPD",
                  hintText: 'NPWPD',
                  border: OutlineInputBorder()),
              controller: NPWPD,
            ),
          ),
          Container(
              height: 50,
              padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: ElevatedButton(
                child: Text('Simpan Perubahan'),
                onPressed: () {
                  submit();
                },
              )),
        ],
      ),
    );
  }
}
