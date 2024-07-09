import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/keranjang_controller.dart';

class KeranjangView extends GetView<KeranjangController> {
  const KeranjangView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KeranjangView'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Get.to(() => const RiwayatPesananPage());
            },
          ),
        ],
      ),
      body: Obx(() => Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: controller.produkList.length,
              itemBuilder: (context, index) {
                return buildProdukItem(controller.produkList[index]);
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.grey[200],
            child: Column(
              children: [
                buildTotalHargaProduk(),
                const SizedBox(height: 8),
                buildTotalOngkosKirim(),
                const Divider(color: Colors.green),
                buildTotalHargaKeseluruhan(),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // Tambahkan logika untuk pembayaran transfer di sini
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Bayar Transfer'),
                          content: const Text('Metode pembayaran transfer belum diimplementasikan.'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Tutup'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: const Text('Bayar Transfer'),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }

  Widget buildProdukItem(Map<String, dynamic> produk) {
    String imagePath = 'assets/img/${produk['nama'].toLowerCase().replaceAll(' ', '_')}.jpeg';

    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(imagePath),
        ),
        title: Text(produk['nama']),
        subtitle: Text('Harga: Rp ${produk['harga']}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: () {
                controller.ubahJumlahProduk(produk, produk['jumlah'] - 1);
              },
            ),
            Obx(() => Text('${produk['jumlah']}')),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                controller.ubahJumlahProduk(produk, produk['jumlah'] + 1);
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                controller.hapusProduk(produk);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTotalHargaProduk() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('Total Harga Produk:'),
        Obx(() => Text(
              'Rp ${calculateTotalHargaProduk()}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            )),
      ],
    );
  }

  Widget buildTotalOngkosKirim() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('Total Ongkos Kirim:'),
        Obx(() => Text(
              'Rp ${calculateTotalOngkosKirim()}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            )),
      ],
    );
  }

  Widget buildTotalHargaKeseluruhan() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('Total Harga Keseluruhan:'),
        Obx(() => Text(
              'Rp ${calculateTotalHargaKeseluruhan()}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            )),
      ],
    );
  }

  String calculateTotalHargaProduk() {
    // Calculate total harga produk
    double totalHarga = controller.produkList.fold(0, (sum, produk) => sum + produk['harga'] * produk['jumlah']);
    return totalHarga.toStringAsFixed(0);
  }

  String calculateTotalOngkosKirim() {
    // Calculate total ongkos kirim
    int totalOngkosKirim = controller.produkList.length * 10000; // Example ongkos kirim per produk
    return totalOngkosKirim.toString();
  }

  String calculateTotalHargaKeseluruhan() {
    // Calculate total harga keseluruhan
    double totalHargaProduk = controller.produkList.fold(0, (sum, produk) => sum + produk['harga'] * produk['jumlah']);
    int totalOngkosKirim = controller.produkList.length * 10000; // Example ongkos kirim per produk
    double totalHargaKeseluruhan = totalHargaProduk + totalOngkosKirim;
    return totalHargaKeseluruhan.toStringAsFixed(0);
  }
}

class RiwayatPesananPage extends StatelessWidget {
  const RiwayatPesananPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Pesanan'),
        backgroundColor: Colors.green,
      ),
      body: const Center(
        child: Text('Riwayat Pesanan Anda'),
      ),
    );
  }
}
