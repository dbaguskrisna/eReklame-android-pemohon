import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Register extends StatelessWidget {
  const Register({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  bool _isHidden1 = true;

  final nama_lengkap = TextEditingController();
  final alamat = TextEditingController();
  final nomor_handphone = TextEditingController();
  final alamat_email = TextEditingController();
  final konfirmasi_alamat_email = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();
  final konfirmasiPassword = TextEditingController();
  final namaPerusahaan = TextEditingController();
  final jabatanPerusahaan = TextEditingController();
  final alamatPerusahaan = TextEditingController();
  final nomorTelpPerusahaan = TextEditingController();
  final NPWPD = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void submit() async {
    final response = await http
        .post(Uri.parse("http://10.0.2.2:8000/api/daftar_user"), body: {
      'nama': nama_lengkap.text,
      'alamat': alamat.text,
      'noHP': nomor_handphone.text,
      'jabatan': jabatanPerusahaan.text,
      'nama_perusahaan': namaPerusahaan.text,
      'alamat_perusahaan': alamatPerusahaan.text,
      'no_telp_perusahaan': nomorTelpPerusahaan.text,
      'email': konfirmasi_alamat_email.text,
      'npwpd': NPWPD.text,
      'username': username.text,
      'password': konfirmasiPassword.text
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

  void _togglePasswordView() {
    setState(() {
      _isHidden1 = !_isHidden1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
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
                'Daftar Baru',
                style: TextStyle(fontSize: 18),
              ),
            ),
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
                controller: nama_lengkap,
                decoration: InputDecoration(
                    hintText: 'Masukkan Nama Lengkap',
                    border: OutlineInputBorder(),
                    labelText: 'Nama Lengkap'),
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
                controller: alamat,
                maxLines: 5,
                decoration: InputDecoration(
                    hintText: 'Masukkan Alamat',
                    border: OutlineInputBorder(),
                    labelText: 'Alamat'),
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
                controller: nomor_handphone,
                decoration: InputDecoration(
                    hintText: 'Masukkan Nomor Handphone',
                    border: OutlineInputBorder(),
                    labelText: 'Nomor Handphone'),
                keyboardType: TextInputType.number,
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
                controller: alamat_email,
                decoration: InputDecoration(
                    hintText: 'Masukkan Alamat Email',
                    border: OutlineInputBorder(),
                    labelText: 'Email'),
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
                controller: konfirmasi_alamat_email,
                decoration: InputDecoration(
                    hintText: 'Konfirmasi Alamat Email',
                    border: OutlineInputBorder(),
                    labelText: 'Konfirmasi Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
            ),
            Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.all(10),
                child: Text(
                  'Data Login',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                )),
            Container(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                decoration: InputDecoration(
                    hintText: 'Masukkan Username',
                    border: OutlineInputBorder(),
                    labelText: 'Username'),
                controller: username,
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
                controller: password,
                obscureText: _isHidden1,
                decoration: InputDecoration(
                    hintText: 'Password',
                    border: OutlineInputBorder(),
                    suffix: InkWell(
                      onTap: _togglePasswordView,
                      child: Icon(Icons.visibility),
                    ),
                    labelText: 'Password'),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                controller: konfirmasiPassword,
                obscureText: _isHidden1,
                decoration: InputDecoration(
                    hintText: 'Konfirmasi Password',
                    border: OutlineInputBorder(),
                    suffix: InkWell(
                      onTap: _togglePasswordView,
                      child: Icon(Icons.visibility),
                    ),
                    labelText: 'Konfirmasi Password'),
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
                controller: namaPerusahaan,
                decoration: InputDecoration(
                    hintText: 'Nama Perushaan',
                    border: OutlineInputBorder(),
                    labelText: 'Nama Perusahaan'),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                controller: jabatanPerusahaan,
                decoration: InputDecoration(
                    hintText: 'Jabatan',
                    border: OutlineInputBorder(),
                    labelText: 'Jabatan'),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                controller: alamatPerusahaan,
                decoration: InputDecoration(
                    hintText: 'Alamat Perusahaan',
                    border: OutlineInputBorder(),
                    labelText: 'Alamat Perusahaan'),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                controller: nomorTelpPerusahaan,
                decoration: InputDecoration(
                    hintText: 'No Telp Perusahaan',
                    border: OutlineInputBorder(),
                    labelText: "No Telp Perusahaan"),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                controller: NPWPD,
                decoration: InputDecoration(
                    hintText: 'NPWPD',
                    border: OutlineInputBorder(),
                    labelText: "NPWPD"),
              ),
            ),
            Container(
                height: 50,
                padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: ElevatedButton(
                  child: Text('Daftar Baru'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (konfirmasi_alamat_email.text == alamat_email.text) {
                        if (password.text == konfirmasiPassword.text) {
                          submit();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(konfirmasiPassword.text)),
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Alamat email tidak sama')),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Mohon isi form dengan benar')),
                      );
                    }
                  },
                )),
          ],
        ));
  }
}
