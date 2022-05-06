import 'dart:convert';
import 'package:ereklame_pemohon/screen/register.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  void doLogin() async {
    print(_user_id);
    print(_user_password);
    final response = await http.post(
        Uri.parse("http://10.0.2.2:8000/api/login"),
        body: {'username': _user_id, 'password': _user_password});
    if (response.statusCode == 200) {
      Map json = jsonDecode(response.body);
      if (json['result'] == 'success') {
        print(json['data'][0]['nama']);
        print(json['data'][0]['username']);
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

  String _user_id = "";
  String _user_password = "";
  String error_login = "";

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
                child: Text('Login haha'),
                onPressed: () {
                  doLogin();
                },
              )),
          Row(
            children: <Widget>[
              const Text('Belum punya akun ?'),
              Builder(
                builder: (context) => TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Register()));
                  },
                  child: Text('Daftar Disini'),
                ),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ],
      ),
    ));
  }
}
