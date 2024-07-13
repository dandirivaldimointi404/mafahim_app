import 'package:get/get.dart';

class KeranjangController extends GetxController {
  final count = 0.obs;
  final RxList<Map<String, dynamic>> produkList = <Map<String, dynamic>>[].obs;

  double get totalPrice {
    double total = 0;
    for (var produk in produkList) {
      total += produk['harga'] * produk['jumlah'];
    }
    return total;
  }

  int get cartItems => produkList.length;



  void increment() => count.value++;

  void ubahJumlahProduk(Map<String, dynamic> produk, int newQuantity) {
    final index = produkList.indexWhere((p) => p['id'] == produk['id']);
    if (index != -1) {
      produkList[index]['jumlah'] = newQuantity;
    }
  }

  void hapusProduk(Map<String, dynamic> produk) {
    produkList.removeWhere((p) => p['id'] == produk['id']);
  }
}
