import 'package:flutter/material.dart';
import 'dart:ui';

class DataReklame extends StatefulWidget {
  const DataReklame({Key? key}) : super(key: key);

  @override
  State<DataReklame> createState() => _DataReklameState();
}

class _DataReklameState extends State<DataReklame> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text("Lihat Data Reklame"),
      ),
    );
  }
}
