import 'package:ereklame_pemohon/screen/cari_koordinat.dart';
import 'package:ereklame_pemohon/screen/cek_status.dart';
import 'package:ereklame_pemohon/screen/data_login.dart';
import 'package:ereklame_pemohon/screen/data_reklame_aktif.dart';
import 'package:ereklame_pemohon/screen/data_reklame_pengajuan.dart';
import 'package:ereklame_pemohon/screen/data_user.dart';
import 'package:ereklame_pemohon/screen/home.dart';
import 'package:ereklame_pemohon/screen/lihat_data_reklame.dart';
import 'package:ereklame_pemohon/screen/lihat_detail_reklame_aktif.dart';
import 'package:ereklame_pemohon/screen/login.dart';
import 'package:ereklame_pemohon/screen/main_2.dart';
import 'package:ereklame_pemohon/screen/maps.dart';
import 'package:ereklame_pemohon/screen/panduan.dart';
import 'package:ereklame_pemohon/screen/permohonan_baru.dart';
import 'package:ereklame_pemohon/screen/perpanjangan_reklame.dart';
import 'package:ereklame_pemohon/screen/profile.dart';
import 'package:ereklame_pemohon/screen/register.dart';
import 'package:ereklame_pemohon/screen/reklame.dart';
import 'package:ereklame_pemohon/screen/upload.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
//firebase pacakge
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

String active_user = "";
String active_username = "";

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "XXX", // Your apiKey
      appId: "XXX", // Your appId
      messagingSenderId: "XXX", // Your messagingSenderId
      projectId: "XXX", // Your projectId
    ),
  );
  print('Handling a background message ${message.messageId}');
}

late AndroidNotificationChannel channel;

late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Set the background messaging handler early on, as a named top-level function
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  if (!kIsWeb) {
    channel = const AndroidNotificationChannel(
      'High Importance Notifications', // title
      'This channel is used for important notifications.', // description
      importance: Importance.high,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  WidgetsFlutterBinding.ensureInitialized();
  checkUser().then((String result) {
    if (result == '')
      runApp(LoginScreen());
    else {
      active_user = result;
      checkUsername().then((String result2) {
        if (result2 == '')
          active_username = "username not found";
        else {
          active_username = result2;
        }
      });
      runApp(MyApp());
    }
  });
}

Future<String> checkUser() async {
  final prefs = await SharedPreferences.getInstance();
  String user_id = prefs.getString("user_id") ?? '';
  return user_id;
}

Future<String> checkUsername() async {
  final prefs = await SharedPreferences.getInstance();
  String username = prefs.getString("username") ?? '';
  return username;
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
        '/cari-koordinat': (context) => FindCoordinate(),
        '/perpanjangan-reklame': (context) => PerpanjanganReklame(),
        '/data-reklame-pengajuan': (context) => DataReklamePengajuan(),
        '/data-reklame-aktif': (context) => DataReklameAktif(),
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
  @override
  void initState() {
    super.initState();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              icon: 'launch_background',
            ),
          ),
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      Navigator.pushNamed(
        context,
        '/message',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: bottomNavigation(),
    );
  }

  int _currentIndex = 0;

  final List<Widget> _screens = [Home(), MapsLocation(), Profile()];

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
}
