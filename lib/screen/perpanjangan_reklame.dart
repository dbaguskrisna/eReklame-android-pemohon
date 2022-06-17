import 'package:flutter/material.dart';

class PerpanjanganReklame extends StatefulWidget {
  const PerpanjanganReklame({Key? key}) : super(key: key);

  @override
  State<PerpanjanganReklame> createState() => _PerpanjanganReklameState();
}

class _PerpanjanganReklameState extends State<PerpanjanganReklame> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Perpanjangan Reklame"),
      ),
      body: Center(child: Text("Perpanjangan Reklame")),
    );
  }
}
