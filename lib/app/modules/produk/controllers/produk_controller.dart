import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mafahim_app/app/data/produk_provider.dart';

class ProdukController extends GetxController {
  var productList = <ProductModel>[].obs;
  var isLoading = true.obs;

  final ProdukProvider produkProvider;

  ProdukController({required this.produkProvider});

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  void fetchProducts() async {
    try {
      isLoading(true);
      final response = await produkProvider.getProducts();
      if (response.statusCode == 200) {
        productList.value = (response.body['data'] as List)
            .map((data) => ProductModel.fromJson(data))
            .toList();

        if (kDebugMode) {
          debugPrint('Data produk berhasil diambil:');
        }
        for (var product in productList) {
          if (kDebugMode) {
            debugPrint('ID: ${product.id}, Nama: ${product.namaProduk}, Harga: ${product.hargaProduk}, Gambar: ${product.gambarProduk}');
          }
        }

      } else {
        // handle error
        Get.snackbar('Error', 'Failed to load products');
      }
    } finally {
      isLoading(false);
    }
  }
}

class ProductModel {
  final int id;
  final String namaProduk;
  final double hargaProduk;
  final String gambarProduk;

  ProductModel({
    required this.id,
    required this.namaProduk,
    required this.hargaProduk,
    required this.gambarProduk,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      namaProduk: json['nama_produk'],
      hargaProduk: double.parse(json['harga_produk'].toString()),
      gambarProduk: json['gambar_produk'],
    );
  }
}
