import 'package:ereklame_pemohon/screen/cek_status.dart';
import 'package:ereklame_pemohon/screen/data_login.dart';
import 'package:ereklame_pemohon/screen/data_user.dart';
import 'package:ereklame_pemohon/screen/home.dart';
import 'package:ereklame_pemohon/screen/lihat_data_reklame.dart';
import 'package:ereklame_pemohon/screen/login_screen.dart';
import 'package:ereklame_pemohon/screen/main_2.dart';
import 'package:ereklame_pemohon/screen/maps.dart';
import 'package:ereklame_pemohon/screen/panduan.dart';
import 'package:ereklame_pemohon/screen/permohonan_baru.dart';
import 'package:ereklame_pemohon/screen/profile.dart';
import 'package:ereklame_pemohon/screen/register.dart';
import 'package:ereklame_pemohon/screen/reklame.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

String active_user = "";

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  checkUser().then((String result) {
    if (result == '')
      runApp(Login());
    else {
      active_user = result;
      runApp(MyApp());
    }
  });
}

Future<String> checkUser() async {
  final prefs = await SharedPreferences.getInstance();
  String user_id = prefs.getString("user_id") ?? '';
  return user_id;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: MyStatefulWidget(),
      ),
      routes: {
        '/sign-up': (context) => Register(),
        '/home': (context) => MyApp(),
        '/reklame': (context) => Reklame(),
        '/data-login': (context) => DataLogin(),
        '/data-user': (context) => DataUser(),
        '/lihat-data': (context) => DataReklame(),
        '/cek-status': (context) => CekStatus(),
        '/panduan': (context) => Panduan(),
        '/permohonan': (context) => PermohonanBaru(),
        '/login-page': (context) => MyApp()
      },
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _currentIndex = 0;

  final List<Widget> _screens = [Home(), Maps(), Profile()];

  Widget bottomNavigation() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      fixedColor: Colors.blue,
      items: [
        BottomNavigationBarItem(
          label: "Home",
          icon: Icon(
            Icons.home,
            color: Colors.blue,
          ),
        ),
        BottomNavigationBarItem(
          label: "Lokasi",
          icon: Icon(
            Icons.pin_drop,
            color: Colors.blue,
          ),
        ),
        BottomNavigationBarItem(
          label: "Profile",
          icon: Icon(
            Icons.person,
            color: Colors.blue,
          ),
        ),
      ],
      onTap: (int index) {
        setState(() {
          _currentIndex = index;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: bottomNavigation(),
    );
  }
}
