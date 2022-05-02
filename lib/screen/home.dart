import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

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
                    margin: EdgeInsets.fromLTRB(25, 0, 25, 50),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/permohonan');
                },
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/image/tambah.png',
                      ),
                      Text("Permohonan Lokasi \nReklame Baru",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontSize: 12))
                    ],
                  ),
                  width: 150,
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/image/search.png',
                      ),
                      Text("Lihat Data \nReklame",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontSize: 12))
                    ],
                  ),
                  width: 150,
                  height: 150,
                  margin: EdgeInsets.fromLTRB(25, 0, 20, 0),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/panduan');
                },
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.help_center,
                        size: 80,
                      ),
                      Text(
                        "Panduan \n Alur Peizinan & Persyaratan",
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                  width: 150,
                  height: 150,
                  margin: EdgeInsets.fromLTRB(25, 25, 20, 25),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/cek-status');
                },
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/image/lihat.png',
                      ),
                      Text("Cek Status \nReklame ",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontSize: 12))
                    ],
                  ),
                  width: 150,
                  height: 150,
                  margin: EdgeInsets.fromLTRB(25, 0, 20, 0),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
