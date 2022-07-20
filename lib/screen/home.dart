import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../class/perpanjangan.dart';
import '../main.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Perpanjangan> Reklames = [];

  @override
  void initState() {
    super.initState();
    print('halo');
    bacaData();
  }

  bacaData() {
    print('baca_data');
    Reklames.clear();
    Future<String> data = fetchData();
    data.then((value) {
      Map json = jsonDecode(value);
      for (var mov in json['data']) {
        print(json['data']);
        Perpanjangan pm = Perpanjangan.fromJson(mov);
        Reklames.add(pm);
      }
      setState(() {});
    });
  }

  Future<String> fetchData() async {
    print('fetch');
    final response = await http.post(
        Uri.parse("http://10.0.2.2:8000/api/read_reklame_perpanjangan"),
        body: {'username': active_username});
    if (response.statusCode == 200) {
      print('response');
      return response.body;
    } else {
      throw Exception('Failed to read API');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Column(
            children: [
              Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.fromLTRB(25, 40, 25, 10),
                    child: Text(
                      "Halo,",
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.fromLTRB(25, 0, 25, 20),
                    child: Text(
                      active_user,
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.normal),
                    ),
                  )
                ],
              )
            ],
          ),
          Column(
            children: [widgetNotification(Reklames)],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/permohonan');
                },
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/image/tambah.png',
                        height: 100,
                      ),
                      Text("Permohonan Lokasi \nReklame Baru",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontSize: 20))
                    ],
                  ),
                  width: double.infinity,
                  height: 150,
                  margin: EdgeInsets.fromLTRB(25, 0, 20, 0),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                ),
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/lihat-data');
                  },
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/image/search.png',
                          height: 120,
                        ),
                        Text("Lihat Data Reklame",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                fontSize: 20))
                      ],
                    ),
                    width: double.infinity,
                    height: 150,
                    margin: EdgeInsets.fromLTRB(25, 10, 20, 0),
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                  )),
              GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/perpanjangan-reklame');
                  },
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/image/perpanjangan.png',
                          height: 120,
                        ),
                        Text(
                          "Perpanjangan Status\n Reklame",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontSize: 19),
                        )
                      ],
                    ),
                    width: double.infinity,
                    height: 150,
                    margin: EdgeInsets.fromLTRB(25, 10, 20, 0),
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                  )),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/panduan');
                },
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/image/lihat.png',
                        height: 120,
                      ),
                      Text("Persyaratan Pendirian \nReklame",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontSize: 18))
                    ],
                  ),
                  width: double.infinity,
                  height: 150,
                  margin: EdgeInsets.fromLTRB(25, 10, 20, 0),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget widgetNotification(Perpanjangans) {
    if (Perpanjangans.length == 0) {
      return Container(
        child: Row(
          children: [Text('')],
        ),
      );
    } else {
      if (Perpanjangans.length != null) {
        return Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Terdapat Reklame yang Harus di Perpanjang',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 13),
              ),
              Text(
                'Silahkan Cek Menu Perpanjangan Status Reklame',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 13),
              )
            ],
          ),
          width: double.infinity,
          height: 50,
          margin: EdgeInsets.fromLTRB(25, 0, 20, 10),
          decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.all(Radius.circular(10))),
        );
      } else {
        return Container(
          child: Row(
            children: [Text('Kosongan')],
          ),
        );
      }
    }
  }
}
