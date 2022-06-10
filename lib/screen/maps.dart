import 'dart:convert';
import 'dart:ffi';
import 'package:ereklame_pemohon/class/maps.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http;

import '../main.dart';

class MapsLocation extends StatefulWidget {
  const MapsLocation({Key? key}) : super(key: key);

  @override
  State<MapsLocation> createState() => _MapsLocation();
}

class _MapsLocation extends State<MapsLocation> {
  List<Maps> listMaps = [];
  String _txtCari = "";

  LatLng marker = LatLng(0, 0);

  List<Marker> lisMarkers = [];

  @override
  void initState() {
    super.initState();
    bacaData();
  }

  String _temp = 'waiting API respond…';

  bacaData() {
    listMaps.clear();
    Future<String> data = fetchData();
    data.then((value) {
      Map json = jsonDecode(value);
      print(json['data']);
      for (var mov in json['data']) {
        Maps pm = Maps.fromJson(mov);
        listMaps.add(pm);
      }
      setState(() {
        test();
      });
    });
  }

  Future<String> fetchData() async {
    final response = await http.post(
        Uri.parse("http://10.0.2.2:8000/api/read_maps"),
        body: {'user': active_username});
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to read API');
    }
  }

  void test() {
    listMaps.forEach((Maps maps) {
      lisMarkers.add(Marker(
          width: 70.0,
          height: 70.0,
          point: LatLng(
              double.parse(maps.latitude), double.parse(maps.longtitude)),
          builder: (ctx) => Container(
              child: IconButton(
                  icon: Icon(Icons.location_on),
                  color: maps.status == 0 ? Colors.blue : Colors.red,
                  onPressed: () => showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                            title: const Text('Notifikasi'),
                            content: Text("Reklame dengan Nomor Formulir" +
                                maps.no_formulir.toString()),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(context, 'Keluar'),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: const Text('Yakin'),
                              ),
                            ],
                          ))))));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Cari titik reklame"),
        ),
        body: FlutterMap(
          options: MapOptions(
            center: LatLng(-7.334962, 112.8011705),
            zoom: 13.0,
            onTap: (tapPosition, point) {
              marker = point;
              setState(() {});
            },
          ),
          layers: [
            TileLayerOptions(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c'],
            ),
            MarkerLayerOptions(markers: lisMarkers),
          ],
        ));
  }

  void _sendDataBack(BuildContext context) {
    String textToSendBack = "halo";
    Navigator.pop(context, textToSendBack);
  }
}
