import 'dart:async';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FindCoordinate extends StatefulWidget {
  const FindCoordinate({Key? key}) : super(key: key);

  @override
  State<FindCoordinate> createState() => _FindCoordinateState();
}

class _FindCoordinateState extends State<FindCoordinate> {
  String _txtCari = "";

  LatLng marker = LatLng(0, 0);
  List<Marker> listMarker = [];

  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(-7.253142, 112.7236701),
    zoom: 10.000,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cari titik reklame"),
      ),
      body: Stack(children: [
        GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: _kGooglePlex,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          markers: Set<Marker>.of(listMarker),
          onTap: (latLng) {
            listMarker.add(Marker(
                markerId: MarkerId("1"),
                icon: BitmapDescriptor.defaultMarker,
                position: LatLng(latLng.latitude, latLng.longitude),
                onTap: () {
                  marker = LatLng(latLng.latitude, latLng.longitude);
                  showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                            title: const Text('Notifikasi'),
                            content: Text(
                                "Apakah anda yakin dengan titik lokasi ini?"),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(context, 'Keluar'),
                                child: const Text('Tidak'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context, '');
                                  Navigator.pop(context, marker);
                                },
                                child: const Text('Yakin'),
                              ),
                            ],
                          ));
                }));

            setState(() {});
          },
        ),
        Container(
            child: Text(
              "Silahkan pilih titik lokasi reklame dengan menekan peta pada lokasi yang diinginkan, kemudian jika lokasi sudah sesuai silahkan tekan kembali marker untuk memunculkan peringatan persetujuan",
              style: TextStyle(fontSize: 15),
              textAlign: TextAlign.justify,
            ),
            color: Colors.white,
            width: double.infinity,
            height: 70),
      ]),
    );
  }

  void _sendDataBack(BuildContext context) {
    String textToSendBack = "halo";
    Navigator.pop(context, textToSendBack);
  }
}
