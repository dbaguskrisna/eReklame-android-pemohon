import 'dart:convert';

import 'package:ereklame_pemohon/class/profile.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../main.dart';
import 'package:http/http.dart' as http;

class DataUser extends StatefulWidget {
  const DataUser({Key? key}) : super(key: key);

  @override
  State<DataUser> createState() => _DataUserState();
}

class _DataUserState extends State<DataUser> {
  Profiles? profile;

  late String _user_id;
  final nama_lengkap = TextEditingController();
  final alamat = TextEditingController();
  final nomor_handphone = TextEditingController();
  final alamat_email = TextEditingController();

  final password = TextEditingController();
  final namaPerusahaan = TextEditingController();

  final jabatanPerusahaan = TextEditingController();
  final alamatPerusahaan = TextEditingController();
  final nomorTelpPerusahaan = TextEditingController();
  final NPWPD = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    bacaData();
  }

  bacaData() {
    fetchData().then((value) {
      Map json = jsonDecode(value);
      profile = Profiles.fromJson(json['data'][0]);
      print(json['data'][0]);
      setState(() {
        nama_lengkap.text = profile!.nama;
        alamat.text = profile!.alamat;
        nomor_handphone.text = profile!.no_hp.toString();
        alamat_email.text = profile!.alamat;
        password.text = profile!.password;
        namaPerusahaan.text = profile!.nama_perusahaan;
        jabatanPerusahaan.text = profile!.jabatan;
        alamatPerusahaan.text = profile!.alamat;
        nomorTelpPerusahaan.text = profile!.no_telp_perusahaan;
        NPWPD.text = profile!.npwpd;
      });
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
    print(active_username.toString());
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
      'email': active_username
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
    if (profile == null) {
      return Scaffold(
          appBar: AppBar(
            title: Text("Data Login"),
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
          title: Text('Data Profile'),
        ),
        body: Form(
          key: _formKey,
          child: ListView(
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
                    initialValue: profile?.email,
                    decoration: InputDecoration(
                        labelText: 'E-mail',
                        hintText: 'E-mail',
                        border: OutlineInputBorder()),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Textbox tidak boleh kosong';
                      }
                      return null;
                    }),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Nama Lengkap',
                        hintText: "Nama lengkap",
                        border: OutlineInputBorder()),
                    controller: nama_lengkap,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Textbox tidak boleh kosong';
                      }
                      return null;
                    }),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: 'No HP',
                        hintText: 'No HP',
                        border: OutlineInputBorder()),
                    controller: nomor_handphone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Textbox tidak boleh kosong';
                      }
                      return null;
                    }),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Alamat',
                        hintText: 'Alamat',
                        border: OutlineInputBorder()),
                    controller: alamat,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Textbox tidak boleh kosong';
                      }
                      return null;
                    }),
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Textbox tidak boleh kosong';
                      }
                      return null;
                    }),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                    decoration: InputDecoration(
                        labelText: "Jabatan",
                        hintText: 'Jabatan',
                        border: OutlineInputBorder()),
                    controller: jabatanPerusahaan,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Textbox tidak boleh kosong';
                      }
                      return null;
                    }),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                    decoration: InputDecoration(
                        labelText: "Alamat Perusahaan",
                        hintText: 'Alamat Perusahaan',
                        border: OutlineInputBorder()),
                    controller: alamat,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Textbox tidak boleh kosong';
                      }
                      return null;
                    }),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "No Telp Perusahaan",
                        hintText: 'No Telp Perusahaan',
                        border: OutlineInputBorder()),
                    controller: nomorTelpPerusahaan,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Textbox tidak boleh kosong';
                      }
                      return null;
                    }),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                    decoration: InputDecoration(
                        labelText: "NPWPD",
                        hintText: 'NPWPD',
                        border: OutlineInputBorder()),
                    controller: NPWPD,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Textbox tidak boleh kosong';
                      }
                      return null;
                    }),
              ),
              Container(
                  height: 50,
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: ElevatedButton(
                    child: Text('Simpan Perubahan'),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        submit();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('Mohon isi form dengan lengkap')),
                        );
                      }
                    },
                  )),
            ],
          ),
        ),
      );
    }
  }
}
