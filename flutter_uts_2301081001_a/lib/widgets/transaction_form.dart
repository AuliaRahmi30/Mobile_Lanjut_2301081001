import 'package:flutter/material.dart';

class TransactionForm extends StatelessWidget {
  final Function(String) onKodeChanged;
  final Function(String) onNamaChanged;
  final Function(String) onJenisChanged;
  final Function(DateTime) onTglMasukChanged;
  final Function(DateTime) onJamMasukChanged;
  final Function(DateTime) onJamKeluarChanged;
  final Function(double) onTarifChanged;
  final Function() onAddTransaction;

  const TransactionForm({
    Key? key,
    required this.onKodeChanged,
    required this.onNamaChanged,
    required this.onJenisChanged,
    required this.onTglMasukChanged,
    required this.onJamMasukChanged,
    required this.onJamKeluarChanged,
    required this.onTarifChanged,
    required this.onAddTransaction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String jenisPelanggan = '';
    DateTime tglMasuk = DateTime.now();
    DateTime jamMasuk = DateTime.now();
    DateTime jamKeluar = DateTime.now();
    double tarif = 10000;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(labelText: 'Kode Transaksi'),
            onChanged: onKodeChanged,
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Nama Pelanggan'),
            onChanged: onNamaChanged,
          ),
          DropdownButtonFormField<String>(
            decoration: InputDecoration(labelText: 'Jenis Pelanggan'),
            items: [
              DropdownMenuItem(value: 'VIP', child: Text('VIP')),
              DropdownMenuItem(value: 'GOLD', child: Text('GOLD')),
            ],
            onChanged: (value) {
              if (value != null) {
                onJenisChanged(value);
              }
            },
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Tanggal Masuk'),
            readOnly: true,
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: tglMasuk,
                firstDate: DateTime(2000),
                lastDate: DateTime(2101),
              );
              if (pickedDate != null) {
                tglMasuk = pickedDate;
                onTglMasukChanged(pickedDate);
              }
            },
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Jam Masuk'),
            readOnly: true,
            onTap: () async {
              TimeOfDay? pickedTime = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );
              if (pickedTime != null) {
                jamMasuk = DateTime(
                    tglMasuk.year,
                    tglMasuk.month,
                    tglMasuk.day,
                    pickedTime.hour,
                    pickedTime.minute);
                onJamMasukChanged(jamMasuk);
              }
            },
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Jam Keluar'),
            readOnly: true,
            onTap: () async {
              TimeOfDay? pickedTime = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );
              if (pickedTime != null) {
                jamKeluar = DateTime(
                    tglMasuk.year,
                    tglMasuk.month,
                    tglMasuk.day,
                    pickedTime.hour,
                    pickedTime.minute);
                onJamKeluarChanged(jamKeluar);
              }
            },
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Tarif (per jam)'),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              if (value.isNotEmpty) {
                onTarifChanged(double.tryParse(value) ?? 10000);
              }
            },
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: onAddTransaction,
            child: Text('Tambah Transaksi'),
          ),
        ],
      ),
    );
  }
}
