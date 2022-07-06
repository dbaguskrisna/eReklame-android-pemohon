import 'dart:convert';
import 'package:ereklame_pemohon/screen/register.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../main.dart';
import 'package:crypto/crypto.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);

  String _user_id = "";
  String _user_password = "";
  String error_login = "";
  String hashPassword = "";

  void doLogin() async {
    var salt = 'eReklame';
    var bytes1 = utf8.encode(salt + _user_password); // data being hashed
    var digest1 = sha256.convert(bytes1); // Hashing Process
    print("Digest as bytes: ${digest1.bytes}");
    print("Digest as hex string: $digest1");
    final response = await http.post(
        Uri.parse("http://10.0.2.2:8000/api/login"),
        body: {'username': _user_id, 'password': digest1});
    if (response.statusCode == 200) {
      Map json = jsonDecode(response.body);
      if (json['result'] == 'success') {
        final prefs = await SharedPreferences.getInstance();
        prefs.setString("user_id", json['data'][0]['nama']);
        prefs.setString("username", json['data'][0]['username']);
        main();
      } else {
        print("Error tidak dapat login");
      }
    } else {
      throw Exception('Failed to read API');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
              child: Image.asset('assets/image/logo.png')),
          Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
              child: Text(
                'Silahkan login untuk masuk aplikasi',
                style: TextStyle(fontSize: 15),
              )),
          Container(
            padding: EdgeInsets.all(10),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Username',
              ),
              onChanged: (v) {
                _user_id = v;
              },
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 15),
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
              onChanged: (v) {
                _user_password = v;
              },
            ),
          ),
          Container(
              height: 50,
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ElevatedButton(
                child: Text('Ini Login Screen'),
                onPressed: () {
                  doLogin();
                },
              )),
          Row(
            children: <Widget>[
              const Text('Belum punya akun ?'),
              TextButton(
                child: const Text(
                  'Daftar Disini',
                  style: TextStyle(fontSize: 14),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/data-user');
                },
              )
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ],
      ),
    ));
  }
}
