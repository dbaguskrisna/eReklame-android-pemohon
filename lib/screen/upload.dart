import 'dart:convert';

import 'package:ereklame_pemohon/main.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;

import '../class/upload_files.dart';

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
  List<UploadFiles> listUpload = [];

  late FilePickerResult result;
  late PlatformFile file1;
  selectFile() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['jpg', 'pdf']);
    if (result == null) return;
    file1 = result.files.first;
  }

  @override
  void initState() {
    super.initState();
    bacaData();
  }

  bacaData() {
    listUpload.clear();
    Future<String> data = fetchData();
    data.then((value) {
      Map json = jsonDecode(value);
      print(json['data']);
      for (var mov in json['data']) {
        UploadFiles pm = UploadFiles.fromJson(mov);
        listUpload.add(pm);
      }
      setState(() {});
    });
  }

  Future<String> fetchData() async {
    final response = await http.post(
        Uri.parse("http://10.0.2.2:8000/api/read_upload_reklame"),
        body: {'id_reklame': widget.reklame_id.toString()});
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to read API');
    }
  }

  @override
  Widget build(BuildContext context) {
    void submit() async {
      var request = http.MultipartRequest(
          'POST', Uri.parse('http://10.0.2.2:8000/api/upload_reklame'));
      request.files.add(
          await http.MultipartFile.fromPath('file', file1.path.toString()));
      print(active_username);
      request.fields.addAll({
        'username': active_username,
        'id_reklame': widget.reklame_id.toString(),
        'id_berkas': selectedValueStatusTanah
      });

      var res = await request.send();
      var responseJSON = await http.Response.fromStream(res);
      print(res.statusCode);
      if (res.statusCode == 200) {
        Map json = jsonDecode(responseJSON.body);
        if (json['result'] == 'success') {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Sukses Mengupload File')));
          setState(() {
            bacaData();
          });
        }
      } else {
        throw Exception('Failed to read API');
      }
    }

    void deleteBerkas(int id_upload) async {
      final response = await http.post(
          Uri.parse("http://10.0.2.2:8000/api/delete_berkas"),
          body: {'id_upload': id_upload.toString()});

      if (response.statusCode == 200) {
        Map json = jsonDecode(response.body);
        if (json['result'] == 'success') {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Sukses Menhapus Berkas')));
          setState(() {
            bacaData();
          });
        }
      } else {
        throw Exception('Failed to read API');
      }
    }

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
                  ElevatedButton(
                      onPressed: () {
                        selectFile();
                      },
                      child: Text("Pilih berkas")),
                  ElevatedButton(
                      onPressed: () {
                        submit();
                      },
                      child: Text("Upload Berkas"))
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: DataTable(
                  columns: [
                    DataColumn(
                      label: Text('TIPE BERKAS'),
                    ),
                    DataColumn(
                      label: Text('ACTION'),
                    ),
                  ],
                  rows: List.generate(listUpload.length, (index) {
                    String nama_berkas = listUpload[index].jenis_berkas;

                    return DataRow(cells: [
                      DataCell(Text(nama_berkas)),
                      DataCell(IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('Peringatan'),
                              content: Text(
                                  'Apakah Yakin Akan Menghapus Berkas ?' +
                                      listUpload[index].id_upload.toString()),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, 'Cancel'),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    deleteBerkas(listUpload[index].id_upload);
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                        },
                      ))
                    ]);
                  }),
                ),
              ),
            ),
          ],
        ));
  }
}
