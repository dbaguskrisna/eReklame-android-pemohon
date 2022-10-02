import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';

import '../class/maps.dart';
import '../main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:custom_info_window/custom_info_window.dart';

class EditKoordinat extends StatefulWidget {
  final String no_reklame;
  const EditKoordinat({Key? key, required this.no_reklame}) : super(key: key);

  @override
  State<EditKoordinat> createState() => _EditKoordinatState();
}

class _EditKoordinatState extends State<EditKoordinat> {
  CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();
  List<Maps> listMaps = [];
  String _txtCari = "";

  List<Marker> lisMarkers = [];

  LatLng marker = LatLng(0, 0);
  List<Marker> newMarker = [];
  @override
  initState() {
    super.initState();
    bacaData();
  }

  late LatLng coordinate = LatLng(0, 0);

  bacaData() {
    print('HALO');
    listMaps.clear();
    Future<String> data = fetchData();
    data.then((value) {
      Map json = jsonDecode(value);
      for (var mov in json['data']) {
        Maps pm = Maps.fromJson(mov);
        print(pm);
        listMaps.add(pm);
      }
      setState(() {
        addMaps();
      });
    });
  }

  Future<String> fetchData() async {
    final response = await http.post(
        Uri.parse("http://10.0.2.2:8000/api/search"),
        body: {'no_reklame': widget.no_reklame});
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to read API');
    }
  }

  void addMaps() {
    lisMarkers.clear();
    listMaps.forEach((Maps maps) {
      lisMarkers.add(
        Marker(
          //add second marker
          markerId: MarkerId(maps.id_reklame.toString()),
          position: LatLng(double.parse(maps.latitude),
              double.parse(maps.longtitude)), //position of marker
          onTap: () {
            _customInfoWindowController.addInfoWindow!(
                Column(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                "Nomor Formulir : " +
                                    maps.no_formulir.toString(),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text("Tgl Berkaku : " +
                                  maps.tgl_berlaku_awal +
                                  " s/d " +
                                  maps.tgl_berlaku_akhir),
                              Text("Status : " + checkStatus(maps.status)),
                            ],
                          ),
                        ),
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                  ],
                ),
                LatLng(
                  double.parse(maps.latitude),
                  double.parse(maps.longtitude),
                ));
          },
          icon: BitmapDescriptor.defaultMarkerWithHue(
              checkBitMapColor(maps.status)), //Icon for Marker
        ),
      );
    });
  }

  double checkBitMapColor(int status) {
    if (status == 0) {
      return BitmapDescriptor.hueBlue;
    } else if (status == 1) {
      return BitmapDescriptor.hueGreen;
    } else {
      return BitmapDescriptor.hueRed;
    }
  }

  String checkStatus(int status) {
    if (status == 0) {
      return "Dalam Proses Permohonan";
    } else if (status == 1) {
      return "Aktif";
    } else {
      return "Tidak Aktif";
    }
  }

  String _txtcari = "";

  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(-7.253142, 112.7236701),
    zoom: 10.000,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Lihat titik lokasi reklame"),
        ),
        body: Stack(children: <Widget>[
          GoogleMap(
            onTap: (latLng) {
              lisMarkers.clear();
              lisMarkers.add(Marker(
                markerId: MarkerId("1"),
                icon: BitmapDescriptor.defaultMarker,
                position: LatLng(latLng.latitude, latLng.longitude),
              ));
              marker = LatLng(latLng.latitude, latLng.longitude);
              showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                        title: const Text('Notifikasi'),
                        content:
                            Text("Apakah anda yakin dengan titik lokasi ini?"),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Keluar'),
                            child: const Text('Tidak'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context, '');
                              Navigator.pop(context, marker);
                              print(marker);
                            },
                            child: const Text('Yakin'),
                          ),
                        ],
                      ));
              setState(() {});
            },
            mapType: MapType.normal,
            initialCameraPosition: _kGooglePlex,
            markers: Set<Marker>.of(lisMarkers),
          ),
          CustomInfoWindow(
            controller: _customInfoWindowController,
            height: 130,
            width: 300,
            offset: 50,
          ),
        ]));
  }

  void _sendDataBack(BuildContext context) {
    String textToSendBack = "halo";
    Navigator.pop(context, textToSendBack);
  }
}
