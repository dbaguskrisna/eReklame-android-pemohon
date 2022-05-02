import 'package:flutter/material.dart';
import 'dart:ui';

class CekStatus extends StatefulWidget {
  const CekStatus({Key? key}) : super(key: key);

  @override
  State<CekStatus> createState() => _CekStatusState();
}

class _CekStatusState extends State<CekStatus> {
  final List bulan = [
    "Januari",
    "Fabruari",
    "Maret",
    "April",
    "Mei",
    "Juni",
    "Juli",
    "Agustus",
    "September",
    "Oktober",
    "November",
    "Desember"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cek Status Reklame"),
      ),
      body: Column(
        children: [
          Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              child: Center(
                child: TextField(
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          /* Clear the search field */
                        },
                      ),
                      hintText: 'Masukkan Nomor Formulir',
                      border: InputBorder.none),
                ),
              )),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListTile(
                          leading: const Icon(Icons.flight_land),
                          title: Text(bulan[index]),
                          onTap: () {
                            const snackBar = SnackBar(
                              content: Text("a"),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          })),
                );
              },
              itemCount: bulan.length,
            ),
          ),
        ],
      ),
    );
  }
}
