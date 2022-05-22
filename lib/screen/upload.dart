import 'dart:convert';
import 'package:flutter/material.dart';

class UploadDocument extends StatefulWidget {
  final int reklame_id;
  const UploadDocument({Key? key, required this.reklame_id}) : super(key: key);

  @override
  State<UploadDocument> createState() => _UploadDocumentState();
}

String selectedValueStatusTanah = "1";
List<DropdownMenuItem<String>> get statusTanahItems {
  List<DropdownMenuItem<String>> statusTanah = [
    DropdownMenuItem(child: Text("Adminitrasi"), value: "1"),
    DropdownMenuItem(child: Text("Desain dan Tipologi Reklame"), value: "2"),
    DropdownMenuItem(child: Text("Formulir dan Surat Pernyataan"), value: "3"),
    DropdownMenuItem(child: Text("Foto "), value: "4"),
    DropdownMenuItem(child: Text("Foto KTP"), value: "5"),
    DropdownMenuItem(child: Text("Foto NPWPD"), value: "6"),
    DropdownMenuItem(child: Text("Foto STDPR"), value: "7"),
    DropdownMenuItem(child: Text("Foto Lokasi Terbaru"), value: "8"),
    DropdownMenuItem(
        child: Text("IMB Bangunan (Reklame diatas bangunan)"), value: "9"),
    DropdownMenuItem(child: Text("Melengkapi Kekurangan"), value: "10"),
    DropdownMenuItem(child: Text("Melengkapi Kekurangan Dishub"), value: "11"),
    DropdownMenuItem(
        child: Text("Melengkapi Kekurangan Dispenda"), value: "12"),
    DropdownMenuItem(child: Text("Melengkapi Kekurangan DKP"), value: "13"),
    DropdownMenuItem(
        child: Text("Melengkapi Kekurangan Pemetaan"), value: "14"),
    DropdownMenuItem(
        child: Text("Melengkapi Kekurangan Perijinan"), value: "15"),
    DropdownMenuItem(child: Text("Melengkapi Kekurangan PU"), value: "16"),
    DropdownMenuItem(
        child: Text("Melengkapi Kekurangan Struktur Format DWG"), value: "17"),
    DropdownMenuItem(
        child: Text("Perhitungan dan sertifikat keahlian"), value: "18"),
    DropdownMenuItem(child: Text("Perjanjian SEWA"), value: "19"),
    DropdownMenuItem(
        child: Text(
            "Rekom LED atau Videotron dari Dishub(untuk reklame LED / videotron )"),
        value: "20"),
    DropdownMenuItem(child: Text("Sertifikat Tanah"), value: "21"),
    DropdownMenuItem(child: Text("Sketsa titik lokasi"), value: "22"),
    DropdownMenuItem(child: Text("Struktur Format DWG"), value: "23"),
    DropdownMenuItem(child: Text("Surat Kuasa"), value: "24"),
  ];
  return statusTanah;
}

class _UploadDocumentState extends State<UploadDocument> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Upload Documment"),
        ),
        body: ListView(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(15, 25, 15, 15),
              child: Text(
                "Jenis Berkas",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: DropdownButtonFormField(
                  isExpanded: true,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(),
                    border: OutlineInputBorder(),
                  ),
                  value: selectedValueStatusTanah,
                  onChanged: (String? newValue) {
                    selectedValueStatusTanah = newValue!;
                  },
                  items: statusTanahItems),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(onPressed: () {}, child: Text("Pilih berkas")),
                  ElevatedButton(onPressed: () {}, child: Text("Upload Berkas"))
                ],
              ),
            ),
            Container(
                child: DataTable(
              columns: [
                DataColumn(
                  label: Text('TIPE BERKAS'),
                ),
                DataColumn(
                  label: Text('ACTION'),
                ),
              ],
              rows: [
                DataRow(cells: [
                  DataCell(Text("aaaaaaaaa")),
                  DataCell(IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Peringatan'),
                          content: const Text(
                              'Apakah Yakin Akan Menghapus Berkas ?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'Cancel'),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'OK'),
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    },
                  ))
                ])
              ],
            ))
          ],
        ));
  }
}
