import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class Profile extends StatelessWidget {
  Profile({Key? key}) : super(key: key);

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
              Icon(
                Icons.person,
                size: 80,
              ),
              Column(
                children: [
                  Text(
                    "Ida Bagus Krisna",
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
