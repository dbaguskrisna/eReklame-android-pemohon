import 'package:ereklame_pemohon/screen/home.dart';
import 'package:ereklame_pemohon/screen/maps.dart';
import 'package:ereklame_pemohon/screen/profile.dart';
import 'package:ereklame_pemohon/screen/register.dart';
import 'package:ereklame_pemohon/screen/reklame.dart';
import 'package:flutter/material.dart';

class HomeMain extends StatefulWidget {
  const HomeMain({Key? key}) : super(key: key);

  @override
  State<HomeMain> createState() => _HomeState();
}

class _HomeState extends State<HomeMain> {
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
