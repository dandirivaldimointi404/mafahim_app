import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:mafahim_app/app/modules/keranjang/controllers/keranjang_controller.dart';

class AlamatView extends GetView<KeranjangController> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alamat Pengiriman'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Provinsi',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                initialValue: controller.provinsi.value,
                decoration: const InputDecoration(
                  hintText: 'Masukkan provinsi',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => controller.provinsi.value = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Provinsi tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Kota',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                initialValue: controller.kota.value,
                decoration: const InputDecoration(
                  hintText: 'Masukkan kota',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => controller.kota.value = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Kota tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Desa',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                initialValue: controller.desa.value,
                decoration: const InputDecoration(
                  hintText: 'Masukkan desa',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => controller.desa.value = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Desa tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Nomor Telepon',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                initialValue: controller.nomorTelepon.value,
                decoration: const InputDecoration(
                  hintText: 'Masukkan nomor telepon',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => controller.nomorTelepon.value = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nomor telepon tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24.0), // Jarak antara input dan tombol
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Get.back(); // Kembali ke halaman sebelumnya
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child: const Text(
                    'Simpan',
                    style: TextStyle(fontSize: 14.0, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
