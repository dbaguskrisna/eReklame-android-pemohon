import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';

class Maps extends StatefulWidget {
  const Maps({Key? key}) : super(key: key);

  @override
  State<Maps> createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  String _txtCari = "";

  LatLng marker = LatLng(0, 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: TextFormField(
          decoration: const InputDecoration(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            labelText: "Cari Lokasi",
            labelStyle: TextStyle(color: Colors.white),
          ),
          style: TextStyle(color: Colors.white),
          onFieldSubmitted: (value) {
            _txtCari = value;
            //bacaData();
          },
        ),
      ),
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(-7.334962, 112.8011705),
          zoom: 20.0,
          onTap: (tapPosition, point) {
            marker = point;
            setState(() {});
          },
        ),
        layers: [
          TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
            attributionBuilder: (_) {
              return Text("© OpenStreetMap contributors");
            },
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
                  onPressed: () {
                    print("Marker Tapped");
                  },
                )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
