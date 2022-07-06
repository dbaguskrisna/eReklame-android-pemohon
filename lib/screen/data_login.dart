import 'dart:convert';

import 'package:ereklame_pemohon/class/user.dart';
import 'package:ereklame_pemohon/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';

class DataLogin extends StatefulWidget {
  const DataLogin({Key? key}) : super(key: key);

  @override
  State<DataLogin> createState() => _DataLoginState();
}

class _DataLoginState extends State<DataLogin> {
  User? users;

  bool _isHidden1 = true;
  bool _isHidden2 = true;
  bool _isHidden3 = true;

  final nama_lengkap = TextEditingController();
  final alamat = TextEditingController();
  final password = TextEditingController();
  final _KonfirmasiPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    bacaData();
  }

  bacaData() {
    fetchData().then((value) {
      Map json = jsonDecode(value);
      users = User.fromJson(json['data'][0]);
      setState(() {});
    });
  }

  void _togglePasswordView() {
    setState(() {
      _isHidden1 = !_isHidden1;
      _isHidden2 = !_isHidden2;
      _isHidden3 = !_isHidden3;
    });
  }

  void submit() async {
    var salt = 'eReklame';
    var bytes1 = utf8.encode(salt + password.text); // data being hashed
    var digest1 = sha256.convert(bytes1); // Hashing Process
    final response = await http
        .put(Uri.parse("http://10.0.2.2:8000/api/update_password"), body: {
      'password': digest1.toString(),
      'username': active_username,
    });

    if (response.statusCode == 200) {
      Map json = jsonDecode(response.body);
      if (json['result'] == 'success') {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Sukses Mengganti Password')));
      }
    } else {
      throw Exception('Failed to read API');
    }
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
    return Form(
        key: _formKey,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Data Login'),
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
                    'Data Login',
                    style: TextStyle(fontSize: 18),
                  )),
              Container(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  initialValue: users!.username,
                  decoration: InputDecoration(
                      hintText: 'Username',
                      border: OutlineInputBorder(),
                      label: Text('Username')),
                  readOnly: true,
                ),
              ),
              Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.fromLTRB(12, 20, 10, 5),
                  child: Text(
                    'Silahkan isi untuk mengganti password',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  )),
              Container(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  obscureText: _isHidden2,
                  decoration: InputDecoration(
                      hintText: 'New Password',
                      border: OutlineInputBorder(),
                      suffix: InkWell(
                        onTap: _togglePasswordView,
                        child: Icon(Icons.visibility),
                      ),
                      label: Text('New Password')),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  controller: password,
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  obscureText: _isHidden3,
                  decoration: InputDecoration(
                      hintText: 'Repeat new password',
                      border: OutlineInputBorder(),
                      suffix: InkWell(
                        onTap: _togglePasswordView,
                        child: Icon(Icons.visibility),
                      ),
                      label: Text('Repeat New Password')),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  controller: _KonfirmasiPassword,
                ),
              ),
              Container(
                  height: 50,
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    child: Text('Simpan Perubahan'),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (password.text == _KonfirmasiPassword.text) {
                          print(password.text);
                          print(_KonfirmasiPassword.text);
                          submit();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Password tidak sesuai')),
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('Mohon isi form dengan benar')),
                        );
                      }
                    },
                  )),
            ],
          ),
        ));
  }
}
