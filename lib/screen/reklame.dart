import 'package:flutter/material.dart';

class Reklame extends StatefulWidget {
  const Reklame({Key? key}) : super(key: key);

  @override
  State<Reklame> createState() => _ReklameState();
}

class _ReklameState extends State<Reklame> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      alignment: Alignment.center,
      child: Text("Reklame A"),
    ));
  }
}
