import 'dart:convert';
import 'package:flutter/material.dart';

class DetailReklame extends StatefulWidget {
  final int reklame_id;
  const DetailReklame({Key? key, required this.reklame_id}) : super(key: key);

  @override
  State<DetailReklame> createState() => _DetailReklameState();
}

class _DetailReklameState extends State<DetailReklame> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Detail Reklame"),
        ),
        body: ListView(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(15, 25, 15, 15),
              child: Text("Data Pemohon",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: Text("Email : ", style: TextStyle(fontSize: 16)),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: Text("Nama pemohon : ", style: TextStyle(fontSize: 16)),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: Text("Alamat pemohon : ", style: TextStyle(fontSize: 16)),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
              child:
                  Text("Nomor Telp Pemohon : ", style: TextStyle(fontSize: 16)),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: Text("Nama Perusahaan : ", style: TextStyle(fontSize: 16)),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: Text("Nama Perusahaan : ", style: TextStyle(fontSize: 16)),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: Text("NPWPD : ", style: TextStyle(fontSize: 16)),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(15, 25, 15, 15),
              child: Text("Form Detail Titik Reklame",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: Text("Nama Jalan : ", style: TextStyle(fontSize: 16)),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: Text("Nomor Jalan : ", style: TextStyle(fontSize: 16)),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: Text("Tahun Pendirian : ", style: TextStyle(fontSize: 16)),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: Text("Kecamatan : ", style: TextStyle(fontSize: 16)),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: Text("Kelurahan : ", style: TextStyle(fontSize: 16)),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: Text("Detail Lokasi : ", style: TextStyle(fontSize: 16)),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(15, 25, 15, 15),
              child: Text("Data Object Reklame",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: Text("Tahun Pajak : ", style: TextStyle(fontSize: 16)),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
              child:
                  Text("Tanggal Permohonan : ", style: TextStyle(fontSize: 16)),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: Text("Jenis Reklame : ", style: TextStyle(fontSize: 16)),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: Text("Jenis Produk : ", style: TextStyle(fontSize: 16)),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
              child:
                  Text("Lokasi Penempatan : ", style: TextStyle(fontSize: 16)),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: Text("Status Tanah : ", style: TextStyle(fontSize: 16)),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: Text("Letak Reklame : ", style: TextStyle(fontSize: 16)),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(15, 25, 15, 15),
              child: Text("Atribut Reklame Lainnya",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: Text("Sudut Pandang Reklame : ",
                  style: TextStyle(fontSize: 16)),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: Text("Panjang Reklame : ", style: TextStyle(fontSize: 16)),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: Text("Lebar Reklame : ", style: TextStyle(fontSize: 16)),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: Text("Luas Reklame : ", style: TextStyle(fontSize: 16)),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: Text("Tinggi Reklame : ", style: TextStyle(fontSize: 16)),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: Text("Teks Reklame : ", style: TextStyle(fontSize: 16)),
            ),
          ],
        ));
  }
}
