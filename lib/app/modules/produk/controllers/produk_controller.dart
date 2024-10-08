import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mafahim_app/app/data/keranjang_provider.dart';
import 'package:mafahim_app/app/data/produk_provider.dart';
import 'package:mafahim_app/app/modules/produk/models/produk.dart';

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
      final data = response.body['data'] as List;
      if (data.isNotEmpty) {
        productList.value = data.map((data) => ProductModel.fromJson(data)).toList();
        if (kDebugMode) {
          debugPrint('Data produk berhasil diambil:');
          for (var product in productList) {
            debugPrint(
                'ID: ${product.id}, Nama: ${product.namaProduk}, Harga: ${product.harga}, Gambar: ${product.gambar}');
          }
        }
      } else {
        Get.snackbar('Info', 'Tidak ada produk tersedia');
      }
    } else {
      Get.snackbar('Error', 'Failed to load products');
    }
  } catch (e) {
    if (kDebugMode) {
      debugPrint('Exception: $e');
    }
    Get.snackbar('Error', 'Terjadi kesalahan saat memuat produk');
  } finally {
    isLoading(false);
  }
}



  void addToCart(ProductModel product) async {
    try {
      if (kDebugMode) {
        print('Adding product to cart. Product ID: ${product.id}');
      }

      var response = await KeranjangProvider().postKeranjang({
        'produk_id': product.id,
      });

      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Produk berhasil ditambahkan ke keranjang',
            backgroundColor: Colors.green, colorText: Colors.white);
      } else {
        Get.snackbar('Error', 'Gagal menambahkan produk ke keranjang',
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Exception while adding to cart: $e');
      }
      Get.snackbar(
          'Error', 'Terjadi kesalahan saat menambahkan produk ke keranjang');
    }
  }
}