import 'dart:convert';

import 'package:ereklame_pemohon/class/reklame.dart';
import 'package:ereklame_pemohon/screen/upload.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:http/http.dart' as http;

import '../main.dart';
import 'detail_reklame.dart';

class DataReklame extends StatefulWidget {
  const DataReklame({Key? key}) : super(key: key);

  @override
  State<DataReklame> createState() => _DataReklameState();
}

class _DataReklameState extends State<DataReklame> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (AppBar(
        title: Text("Lihat Data Reklame"),
      )),
      body: ListView(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/data-reklame-pengajuan');
                },
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Image.asset(
                          'assets/image/upload.png',
                          height: 80,
                        ),
                      ),
                      Text("Data Reklame Dalam \nProses Pengajuan",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontSize: 18))
                    ],
                  ),
                  width: double.infinity,
                  height: 100,
                  margin: EdgeInsets.fromLTRB(25, 25, 20, 0),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                ),
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/data-reklame-aktif');
                  },
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.all(10),
                          child: Image.asset(
                            'assets/image/aktif.png',
                            height: 80,
                          ),
                        ),
                        Text("Data Reklame Aktif",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                fontSize: 18))
                      ],
                    ),
                    width: double.infinity,
                    height: 100,
                    margin: EdgeInsets.fromLTRB(25, 10, 20, 0),
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
