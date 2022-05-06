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
  Profile? profiles;

  @override
  void initState() {
    super.initState();
    bacaData();
  }

  bacaData() {
    fetchData().then((value) {
      Map json = jsonDecode(value);
      profiles = Profile.fromJson(json['data'][0]);
      print(profiles!.alamat);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
              initialValue: profiles!.username,
              decoration: InputDecoration(
                  hintText: 'Username', border: OutlineInputBorder()),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              initialValue: profiles!.nama,
              decoration: InputDecoration(
                  hintText: "Nama lengkap", border: OutlineInputBorder()),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              initialValue: profiles!.no_telp.toString(),
              decoration: InputDecoration(
                  hintText: 'No Telp', border: OutlineInputBorder()),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              initialValue: profiles!.no_hp.toString(),
              decoration: InputDecoration(
                  hintText: 'No HP', border: OutlineInputBorder()),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              initialValue: profiles!.alamat,
              decoration: InputDecoration(
                  hintText: 'Alamat', border: OutlineInputBorder()),
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
              initialValue: profiles!.nama_perusahaan,
              decoration: InputDecoration(
                  hintText: 'Nama Perushaan', border: OutlineInputBorder()),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              initialValue: profiles!.jabatan,
              decoration: InputDecoration(
                  hintText: 'Jabatan', border: OutlineInputBorder()),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              initialValue: profiles!.alamat_perusahaan,
              decoration: InputDecoration(
                  hintText: 'Alamat Perusahaan', border: OutlineInputBorder()),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              initialValue: profiles!.no_telp_perusahaan.toString(),
              decoration: InputDecoration(
                  hintText: 'No Telp Perusahaan', border: OutlineInputBorder()),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              initialValue: profiles!.npwpd.toString(),
              decoration: InputDecoration(
                  hintText: 'NPWPD', border: OutlineInputBorder()),
            ),
          ),
          Container(
              height: 50,
              padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: ElevatedButton(
                child: Text('Simpan Perubahan'),
                onPressed: () {},
              )),
        ],
      ),
    );
  }
}
