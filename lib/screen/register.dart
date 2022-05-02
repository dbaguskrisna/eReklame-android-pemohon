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
      routes: {'/sign-up': (context) => Register()},
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  final nama_lengkap = TextEditingController();
  final alamat = TextEditingController();
  final nomor_handphone = TextEditingController();
  final alamat_email = TextEditingController();
  final konfirmasi_alamat_email = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();
  final konfirmasiPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void submit() async {
    final response = await http
        .post(Uri.parse("http://10.0.2.2:8000/api/daftar_user"), body: {
      'nama': nama_lengkap.text,
      'alamat': alamat.text,
      'noHP': nomor_handphone.text,
      'username': username.text,
      'email': konfirmasi_alamat_email.text,
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
                    border: OutlineInputBorder()),
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
                    hintText: 'Masukkan Alamat', border: OutlineInputBorder()),
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
                    border: OutlineInputBorder()),
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
                    border: OutlineInputBorder()),
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
                    border: OutlineInputBorder()),
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
                    border: OutlineInputBorder()),
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
                decoration: InputDecoration(
                    hintText: 'Masukkan Password',
                    border: OutlineInputBorder()),
                controller: password,
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
                decoration: InputDecoration(
                    hintText: 'Konfirmasi Password',
                    border: OutlineInputBorder()),
                controller: konfirmasiPassword,
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
