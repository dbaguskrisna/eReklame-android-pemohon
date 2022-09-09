import 'dart:convert';

import 'package:ereklame_pemohon/class/Profile.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

//firebase pacakge
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late String _fullname = "username";
  Profiles? profile;

  @override
  void initState() {
    super.initState();
    bacaData();
    bacaDataLengkap();
  }

  Future<String> fetchDataUser() async {
    final response = await http.post(
        Uri.parse("http://10.0.2.2:8000/api/read_username"),
        body: {'email': active_username});
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to read API');
    }
  }

  bacaData() {
    fetchDataUser().then((value) {
      Map json = jsonDecode(value);
      _fullname = json['data'][0]['nama'];
      setState(() {});
    });
  }

  bacaDataLengkap() {
    fetchDataLengkap().then((value) {
      Map json = jsonDecode(value);
      profile = Profiles.fromJson(json['data'][0]);
      print(json['data'][0]);
      setState(() {});
    });
  }

  Future<String> fetchDataLengkap() async {
    final response = await http.post(
        Uri.parse("http://10.0.2.2:8000/api/read_user"),
        body: {'username': active_username});
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to read API');
    }
  }

  void doLogout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("user_id");
    main();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(25, 80, 25, 10),
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 15, 0),
                child: Image.asset(
                  'assets/image/user.png',
                  height: 80,
                  width: 80,
                ),
              ),
              Column(
                children: [
                  Text(
                    _fullname,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "-",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                    textAlign: TextAlign.left,
                  )
                ],
              )
            ],
          ),
        ),
        Container(
            margin: EdgeInsets.fromLTRB(25, 0, 25, 10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.blue, // background
                onPrimary: Colors.white, // foreground
                fixedSize: const Size(double.maxFinite, 50),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/data-login');
              },
              child: Text('Data Login'),
            )),
        Container(
            margin: EdgeInsets.fromLTRB(25, 0, 25, 10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.blue, // background
                onPrimary: Colors.white, // foreground
                fixedSize: const Size(double.maxFinite, 50),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/data-user');
              },
              child: Text('Data Profile'),
            )),
        Container(
            margin: EdgeInsets.fromLTRB(25, 0, 25, 10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.blue, // background
                onPrimary: Colors.white, // foreground
                fixedSize: const Size(double.maxFinite, 50),
              ),
              onPressed: () {
                doLogout();
              },
              child: Text('Log Out'),
            )),
      ],
    ));
  }
}
