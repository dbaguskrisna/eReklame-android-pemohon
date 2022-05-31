import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';

class FindCoordinate extends StatefulWidget {
  const FindCoordinate({Key? key}) : super(key: key);

  @override
  State<FindCoordinate> createState() => _FindCoordinateState();
}

class _FindCoordinateState extends State<FindCoordinate> {
  String _txtCari = "";

  LatLng marker = LatLng(0, 0);

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
            MarkerLayerOptions(
              markers: [
                Marker(
                  width: 50.0,
                  height: 50.0,
                  point: marker,
                  builder: (ctx) => Container(
                      child: IconButton(
                          icon: Icon(Icons.location_on),
                          color: Colors.red,
                          onPressed: () => showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                    title: const Text('Notifikasi'),
                                    content: Text(
                                        "Apakah anda yakin dengan titik lokasi ini?"),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, 'Keluar'),
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context, '');
                                          Navigator.pop(context, marker);
                                        },
                                        child: const Text('Yakin'),
                                      ),
                                    ],
                                  )))),
                ),
              ],
            ),
          ],
        ));
  }

  void _sendDataBack(BuildContext context) {
    String textToSendBack = "halo";
    Navigator.pop(context, textToSendBack);
  }
}
