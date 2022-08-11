import 'dart:convert';

import 'package:ereklame_pemohon/screen/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../main.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:crypto/crypto.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _user_id = "";
  String _user_password = "";
  String error_login = "";
  final GlobalKey<ScaffoldMessengerState> snackbarKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    void doLogin() async {
      var salt = 'eReklame';
      var bytes1 = utf8.encode(salt + _user_password); // data being hashed
      var digest1 = sha256.convert(bytes1); // Hashing Process
      print(digest1.toString());
      String? _token = await FirebaseMessaging.instance.getToken();
      print(_token);
      final response = await http
          .post(Uri.parse("http://10.0.2.2:8000/api/login"), body: {
        'email': _user_id,
        'password': digest1.toString(),
        'token': _token
      });
      if (response.statusCode == 200) {
        Map json = jsonDecode(response.body);
        if (json['result'] == 'success') {
          await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: _user_id, password: _user_password);

          FirebaseAuth.instance.authStateChanges().listen((User? user) async {
            if (user == null) {
              print('User is currently signed out!');
            } else {
              if (user.emailVerified == false) {
                SnackBar snackBar = SnackBar(
                    content: Text(
                        "Login gagal, Silahkan verifikasi email anda terlebih dahulu"));
                snackbarKey.currentState?.showSnackBar(snackBar);
              } else {
                final prefs = await SharedPreferences.getInstance();
                prefs.setString("user_id", json['data'][0]['nama']);
                prefs.setString("email", json['data'][0]['email']);
                print(json['data'][0]['email']);
                main();
              }
            }
          });
        } else {
          SnackBar snackBar = SnackBar(
              content: Text("Login gagal, Silahkan Check Email dan Password"));
          snackbarKey.currentState?.showSnackBar(snackBar);
        }
      } else {
        throw Exception('Failed to read API');
      }
    }

    return MaterialApp(
        scaffoldMessengerKey: snackbarKey,
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
                    labelText: 'Email',
                  ),
                  onChanged: (v) {
                    _user_id = v;
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 10),
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
                    child: Text('Login'),
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Register()));
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
