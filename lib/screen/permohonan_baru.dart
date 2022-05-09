import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:intl/intl.dart';

class PermohonanBaru extends StatefulWidget {
  const PermohonanBaru({Key? key}) : super(key: key);

  @override
  State<PermohonanBaru> createState() => _PermohonanBaruState();
}

class _PermohonanBaruState extends State<PermohonanBaru> {
  String tahun = DateFormat('yyyy').format(DateTime.now());
  String tanggalBulanTahun = DateFormat('yyyy-MM-dd').format(DateTime.now());
  //Dropdown letak reklame
  String selectedValueLetakReklame = "1";
  List<DropdownMenuItem<String>> get letakReklameItems {
    List<DropdownMenuItem<String>> letakReklame = [
      DropdownMenuItem(child: Text("Belum diketahui"), value: "1"),
      DropdownMenuItem(child: Text("Didalam ruangan"), value: "2"),
      DropdownMenuItem(child: Text("Diluar ruangan"), value: "3"),
    ];
    return letakReklame;
  }

  //Dropdown status tanah
  String selectedValueStatusTanah = "1";
  List<DropdownMenuItem<String>> get statusTanahItems {
    List<DropdownMenuItem<String>> statusTanah = [
      DropdownMenuItem(child: Text("Belum diketahui"), value: "1"),
      DropdownMenuItem(child: Text("Didalam ruangan"), value: "2"),
      DropdownMenuItem(child: Text("Diluar ruangan"), value: "3"),
    ];
    return statusTanah;
  }

  //Lokasi penempatan
  String selectedValueLokasiPenempatan = "1";
  List<DropdownMenuItem<String>> get lokasiPenempatanItems {
    List<DropdownMenuItem<String>> lokasiPenempatan = [
      DropdownMenuItem(child: Text("Belum diketahui"), value: "1"),
      DropdownMenuItem(child: Text("Didalam ruangan"), value: "2"),
      DropdownMenuItem(child: Text("Diluar ruangan"), value: "3"),
    ];
    return lokasiPenempatan;
  }

  //Jenis Produk
  String selectedValueJenisProduk = "1";
  List<DropdownMenuItem<String>> get jenisProdukItems {
    List<DropdownMenuItem<String>> jenisProduk = [
      DropdownMenuItem(child: Text("Belum diketahui"), value: "1"),
      DropdownMenuItem(child: Text("Didalam ruangan"), value: "2"),
      DropdownMenuItem(child: Text("Diluar ruangan"), value: "3"),
    ];
    return jenisProduk;
  }

  //Jenis Reklame
  String selectedValueJenisReklame = "1";
  List<DropdownMenuItem<String>> get jenisReklameItems {
    List<DropdownMenuItem<String>> jenisReklame = [
      DropdownMenuItem(child: Text("Belum diketahui"), value: "1"),
      DropdownMenuItem(child: Text("Didalam ruangan"), value: "2"),
      DropdownMenuItem(child: Text("Diluar ruangan"), value: "3"),
    ];
    return jenisReklame;
  }

  @override
  Widget build(BuildContext context) {
    final nama_lengkap = TextEditingController();
    final alamat = TextEditingController();
    final nomor_handphone = TextEditingController();
    final alamat_email = TextEditingController();
    final konfirmasi_alamat_email = TextEditingController();
    final username = TextEditingController();
    final password = TextEditingController();
    final konfirmasiPassword = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    String dropdownValue = 'One';

    return Scaffold(
        appBar: AppBar(),
        body: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Image.asset('assets/image/logo.png')),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Tambah Reklame Baru',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Data Pemohon',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    )),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    controller: konfirmasi_alamat_email,
                    decoration: InputDecoration(
                        hintText: 'Email',
                        border: OutlineInputBorder(),
                        labelText: "Email"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    controller: nama_lengkap,
                    decoration: InputDecoration(
                        hintText: 'Nama Pemohon',
                        border: OutlineInputBorder(),
                        labelText: "Nama Pemohon"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    controller: alamat,
                    maxLines: 5,
                    decoration: InputDecoration(
                        hintText: 'Alamat Pemohon',
                        border: OutlineInputBorder(),
                        labelText: "Alamat Pemohon"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    controller: alamat_email,
                    decoration: InputDecoration(
                        hintText: 'Nomor Telp Pemohon',
                        border: OutlineInputBorder(),
                        labelText: "Nomor Telp Pemohon"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    controller: nomor_handphone,
                    decoration: InputDecoration(
                        hintText: 'Nama Perusahaan',
                        border: OutlineInputBorder(),
                        labelText: "Nama Perusahaan"),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    controller: konfirmasi_alamat_email,
                    decoration: InputDecoration(
                        hintText: 'Nama Perusahaan',
                        border: OutlineInputBorder(),
                        labelText: "Nama Perusahaan"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    controller: alamat,
                    maxLines: 5,
                    decoration: InputDecoration(
                        hintText: 'Alamat Perusahaan',
                        border: OutlineInputBorder(),
                        labelText: "Alamat Perusahaan"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    controller: konfirmasi_alamat_email,
                    decoration: InputDecoration(
                        hintText: 'NPWPD',
                        border: OutlineInputBorder(),
                        labelText: "NPWPD"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Form Detail Titik Reklame',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    )),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Masukkan Nama Jalan',
                        border: OutlineInputBorder(),
                        labelText: "Nama Jalan"),
                    controller: username,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Masukkan Nomor Jalan',
                        border: OutlineInputBorder(),
                        labelText: "Nomor Jalan"),
                    controller: password,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Masukkan Blok',
                        border: OutlineInputBorder(),
                        labelText: "Blok"),
                    controller: password,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Masukkan RT',
                        border: OutlineInputBorder(),
                        labelText: "RT"),
                    controller: password,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Masukkan RW',
                        border: OutlineInputBorder(),
                        labelText: "RW"),
                    controller: password,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    controller: alamat,
                    maxLines: 5,
                    decoration: InputDecoration(
                        hintText: 'Masukkan Detail Lokasi',
                        border: OutlineInputBorder(),
                        labelText: "Detail Lokasi"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Tahun Pendirian',
                        border: OutlineInputBorder(),
                        labelText: "Tahun Pendirian"),
                    controller: password,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Kecamatan',
                        border: OutlineInputBorder(),
                        labelText: "Kecamatan"),
                    controller: password,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Kelurahan',
                        border: OutlineInputBorder(),
                        labelText: "Kelurahan"),
                    controller: password,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Form Data Objek Reklame',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    )),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    initialValue: tahun,
                    decoration: InputDecoration(
                        hintText: 'Tahun Pajak',
                        border: OutlineInputBorder(),
                        labelText: "Tahun Pajak"),
                    enabled: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    initialValue: tanggalBulanTahun,
                    decoration: InputDecoration(
                        hintText: 'Tanggal Permohonan',
                        border: OutlineInputBorder(),
                        labelText: "Tanggal Permohonan"),
                    enabled: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        labelText: "Jenis Reklame",
                        enabledBorder: OutlineInputBorder(),
                        border: OutlineInputBorder(),
                      ),
                      value: selectedValueJenisReklame,
                      onChanged: (String? newValue) {
                        selectedValueJenisReklame = newValue!;
                      },
                      items: jenisReklameItems),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        labelText: "Jenis Produk",
                        enabledBorder: OutlineInputBorder(),
                        border: OutlineInputBorder(),
                      ),
                      value: selectedValueJenisProduk,
                      onChanged: (String? newValue) {
                        selectedValueJenisProduk = newValue!;
                      },
                      items: jenisProdukItems),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        labelText: "Lokasi Penempatan",
                        enabledBorder: OutlineInputBorder(),
                        border: OutlineInputBorder(),
                      ),
                      value: selectedValueLokasiPenempatan,
                      onChanged: (String? newValue) {
                        selectedValueLokasiPenempatan = newValue!;
                      },
                      items: lokasiPenempatanItems),
                ),
                Container(
                    padding: EdgeInsets.all(10),
                    child: DropdownButtonFormField(
                        decoration: InputDecoration(
                          labelText: "Status Tanah",
                          enabledBorder: OutlineInputBorder(),
                          border: OutlineInputBorder(),
                        ),
                        value: selectedValueStatusTanah,
                        onChanged: (String? newValue) {
                          selectedValueStatusTanah = newValue!;
                        },
                        items: statusTanahItems)),
                Container(
                    padding: EdgeInsets.all(10),
                    child: DropdownButtonFormField(
                        decoration: InputDecoration(
                          labelText: "Letak Reklame",
                          enabledBorder: OutlineInputBorder(),
                          border: OutlineInputBorder(),
                        ),
                        value: selectedValueLetakReklame,
                        onChanged: (String? newValue) {
                          selectedValueLetakReklame = newValue!;
                        },
                        items: letakReklameItems)),
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                    child: ElevatedButton(
                        child: Text('Daftar Baru'),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(selectedValueLetakReklame)),
                          );
                        })),
              ],
            )));
  }
}
