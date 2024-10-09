import 'package:flutter/material.dart';
import 'result_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Warnet App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white, // Set a white background
      ),
      home: EntryPage(),
    );
  }
}

class EntryPage extends StatefulWidget {
  @override
  _EntryPageState createState() => _EntryPageState();
}

class _EntryPageState extends State<EntryPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController kodePelangganController = TextEditingController();
  TextEditingController namaPelangganController = TextEditingController();
  TextEditingController tglMasukController = TextEditingController();
  TextEditingController jamMasukController = TextEditingController();
  TextEditingController jamKeluarController = TextEditingController();
  String? jenisPelanggan;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Warnet Entry Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Form Pendaftaran Pelanggan',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: kodePelangganController,
                  decoration: InputDecoration(
                    labelText: 'Kode Pelanggan',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Kode pelanggan harus diisi';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: namaPelangganController,
                  decoration: InputDecoration(
                    labelText: 'Nama Pelanggan',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Nama pelanggan harus diisi';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: jenisPelanggan,
                  decoration: InputDecoration(
                    labelText: 'Jenis Pelanggan',
                    border: OutlineInputBorder(),
                  ),
                  items: <String>['VIP', 'GOLD', 'REGULAR']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      jenisPelanggan = newValue;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Jenis pelanggan harus dipilih';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: tglMasukController,
                  decoration: InputDecoration(
                    labelText: 'Tanggal Masuk (DD/MM/YYYY)',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  ),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: jamMasukController,
                  decoration: InputDecoration(
                    labelText: 'Jam Masuk (HH:MM)',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Jam masuk harus diisi';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: jamKeluarController,
                  decoration: InputDecoration(
                    labelText: 'Jam Keluar (HH:MM)',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Jam keluar harus diisi';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      List<String> jamMasukParts = jamMasukController.text.split(':');
                      List<String> jamKeluarParts = jamKeluarController.text.split(':');
                      int jamMasuk = int.parse(jamMasukParts[0]) * 60 + int.parse(jamMasukParts[1]);
                      int jamKeluar = int.parse(jamKeluarParts[0]) * 60 + int.parse(jamKeluarParts[1]);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResultPage(
                            kodePelanggan: kodePelangganController.text,
                            namaPelanggan: namaPelangganController.text,
                            jenisPelanggan: jenisPelanggan!,
                            tglMasuk: tglMasukController.text,
                            jamMasuk: jamMasuk,
                            jamKeluar: jamKeluar,
                          ),
                        ),
                      );
                    }
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
