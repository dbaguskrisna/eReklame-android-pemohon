import 'package:flutter/material.dart';
import 'dart:ui';

class Panduan extends StatelessWidget {
  const Panduan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: <Widget>[
          Center(
              child: Text(
            'PERSYARATAN',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            textAlign: TextAlign.center,
          )),
          Container(
            padding: EdgeInsets.all(10),
            child: Text("1. Fotokopi Kartu Tanda Penduduk"),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Text('2. Fotokopi NPWPD'),
          ),
          Container(
              padding: EdgeInsets.all(10),
              child: Text(
                '3. Fotokopi SIUP (untuk pemohon badan usaha yang bergerak dibidang jasa periklanan)',
                overflow: TextOverflow.clip,
              )),
          Container(
              padding: EdgeInsets.all(10),
              child: Text(
                  '4. Surat kuasa bermaterai cukup dari pemohon (apabila pengajuan permohonan dikuasakan kepada orang lain)')),
          Container(
              padding: EdgeInsets.all(10),
              child: Text("5. Sketsa titik lokasi penyelenggaraan reklame")),
          Container(
              padding: EdgeInsets.all(10),
              child: Text("6. Desain dan tipologi reklame")),
          Container(
              padding: EdgeInsets.all(10),
              child: Text(
                  "7. Foto terbaru rencana lokasi penyelenggaraan reklame")),
          Container(
              padding: EdgeInsets.all(10),
              child: Text(
                  "8. Perjanjian sewa atau bentuk lain sesuai dengan ketentuan (apabila menggunakan lahan aset pemerintah, pemerintah provinsi atau pemerintah daerah)")),
          Container(
              padding: EdgeInsets.all(10),
              child: Text(
                  "9. Surat persetujuan bermaterai cukup dari pemilik / yang menguasai lahan / bangunan apabila reklame didirikan pada lahan dan atau pada bangunan milik orang lain (form tersedia). dengan dilampiri bukti kepemilikan penguasaan atas lahan atau bangunan, antara lain berupa sertifikat dan atau perjanjian sewa menyewa sesuai kebutuhan)")),
          Container(
              padding: EdgeInsets.all(10),
              child: Text(
                  "10. Surat pernyataan bermaterai cukup kesanggupan menanggung segala akibat yang ditimbulkan atas penyelenggaraan reklame(form tersedia)")),
          Container(
              padding: EdgeInsets.all(10),
              child: Text(
                  "11. Fotokopi SIPR lama yang pernah dimiliki sebelumnya dan polis asuransi dan polis asuransi reklame (untuk permohonan perpanjangan)")),
          Container(
              padding: EdgeInsets.all(10),
              child: Text(
                  "12. Apabila luas bidang berukuran diatas 8m2 dan menggunakan konstruksi, persyaratan ditambahkan: ")),
          Container(
              padding: EdgeInsets.all(10),
              child: Text("13. Gambar rencana konstruksi (format auto cad)")),
          Container(
              padding: EdgeInsets.all(10),
              child: Text(
                  "14. Perhitungan konstruksi yang ditandatangani oleh penanggung jawab struktur/konstruksi yang mempunyai sertifikasi dari lembaga yang berwenang")),
          Container(
              padding: EdgeInsets.all(10),
              child: Text(
                  "15. Evaluasi konstruksi yang ditandatangani oleh penanggung jawab struktur / konstruksi dan IMB reklame yang pernah dimiliki sebelumnya (untuk permohonan perpanjangan)")),
        ],
      ),
    );
  }
}
