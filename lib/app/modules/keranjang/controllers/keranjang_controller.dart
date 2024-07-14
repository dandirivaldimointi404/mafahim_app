import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:mafahim_app/app/data/keranjang_provider.dart';
import 'package:mafahim_app/app/modules/keranjang/models/keranjang.dart';
import 'package:mafahim_app/app/modules/produk/models/produk.dart';

class KeranjangController extends GetxController {
  var keranjangList = <Keranjang>[].obs;
  var isLoading = true.obs;

  final KeranjangProvider keranjangProvider;

  KeranjangController({required this.keranjangProvider});

  get navigateToCartScreen => null;

  @override
  void onInit() {
    fetchKeranjang();
    super.onInit();
  }

  void fetchKeranjang() async {
    try {
      isLoading(true);
      final response = await keranjangProvider.getKeranjang();
      if (response.statusCode == 200) {
        List<dynamic> data = response.body['data'];
        keranjangList.value =
            data.map((item) => Keranjang.fromJson(item)).toList();

        if (kDebugMode) {
          debugPrint('Data keranjang berhasil diambil:');
          for (var keranjang in keranjangList) {
            debugPrint(
                'ID: ${keranjang.id}, Qty: ${keranjang.qty}, Nama: ${keranjang.produk.namaProduk}');
          }
        }
      } else {
        Get.snackbar('Error', 'Failed to load cart items');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Exception occurred while fetching cart items: $e');
      }
      Get.snackbar('Error', 'Exception occurred while fetching cart items');
    } finally {
      isLoading(false);
    }
  }

  void navigateToProductDetail(ProductModel produk) {}

  void tambahBarangKeKeranjang() {}

  void tambahJumlahBarang(Keranjang keranjang) {}

  void kurangiJumlahBarang(Keranjang keranjang) {}

  void hapusBarang(Keranjang keranjang) {}
}
