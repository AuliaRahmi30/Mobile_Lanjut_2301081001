import 'package:flutter/material.dart';

class TransaksiPage extends StatefulWidget {
  @override
  _TransaksiPageState createState() => _TransaksiPageState();
}

class _TransaksiPageState extends State<TransaksiPage> {
  final _formKey = GlobalKey<FormState>();
  String? _kodeTransaksi;
  String? _jenisPelanggan;
  double _tarif = 0;

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Simpan data transaksi ke database (atau proses lainnya)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Data Transaksi Disimpan: $_kodeTransaksi, $_jenisPelanggan')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transaksi Warnet'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Kode Transaksi'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan Kode Transaksi';
                  }
                  return null;
                },
                onSaved: (value) => _kodeTransaksi = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Jenis Pelanggan (VIP/GOLD)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan Jenis Pelanggan';
                  }
                  return null;
                },
                onSaved: (value) => _jenisPelanggan = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Tarif'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan Tarif';
                  }
                  return null;
                },
                onSaved: (value) => _tarif = double.tryParse(value!) ?? 0,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submit,
                child: Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
