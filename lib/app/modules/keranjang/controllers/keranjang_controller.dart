import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:mafahim_app/app/data/keranjang_provider.dart';
import 'package:mafahim_app/app/modules/keranjang/models/keranjang.dart';

class KeranjangController extends GetxController {
  var keranjangList = <Keranjang>[].obs;
  var isLoading = true.obs;
  RxList<RxInt> itemQuantities = <RxInt>[].obs;
  final KeranjangProvider keranjangProvider;

  KeranjangController({required this.keranjangProvider});

  double get totalHargaProduk {
    double total = 0;
    for (int i = 0; i < keranjangList.length; i++) {
      if (i < itemQuantities.length) {
        total += keranjangList[i].harga * itemQuantities[i].value;
        if (kDebugMode) {
          debugPrint('Item ${i + 1}: Harga = ${keranjangList[i].harga}, Quantity = ${itemQuantities[i].value}, Total = ${keranjangList[i].harga * itemQuantities[i].value}');
        }
      }
    }
    if (kDebugMode) {
      debugPrint('Total Harga Produk: $total');
    }
    return total;
  }

  double get totalHargaKeseluruhan {
    double ongkir = 5000;
    return totalHargaProduk + ongkir;
  }

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
        keranjangList.assignAll(
          data.map((item) => Keranjang.fromJson(item)).toList(),
        );

        if (kDebugMode) {
          debugPrint('Data keranjang berhasil diambil:');
          for (var keranjang in keranjangList) {
            debugPrint(
              'ID: ${keranjang.id}, Nama: ${keranjang.produk.namaProduk}, Harga: ${keranjang.harga}, Quantity: ${keranjang.quantity}',
            );
          }
        }

        itemQuantities.assignAll(
          List.generate(keranjangList.length, (index) => 1.obs),
        );

        if (kDebugMode) {
          debugPrint('Item Quantities Initialized: ${itemQuantities.map((e) => e.value).toList()}');
        }
      } else {
        Get.snackbar('Error', 'Failed to load cart items');
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Exception occurred while fetching cart items: $e');
      }
      Get.snackbar('Error', 'Exception occurred while fetching cart items');
    } finally {
      isLoading(false);
    }
  }

  void incrementQuantity(int index) {
    if (index >= 0 && index < itemQuantities.length) {
      if (itemQuantities[index].value < 99) {
        itemQuantities[index]++;
      }
    }
  }

  void decrementQuantity(int index) {
    if (index >= 0 && index < itemQuantities.length) {
      if (itemQuantities[index].value > 1) {
        itemQuantities[index]--;
      }
    }
  }

  void hapusBarang(Keranjang keranjang) {
    int index = keranjangList.indexWhere((item) => item.id == keranjang.id);
    if (index != -1) {
      keranjangList.removeAt(index);
      itemQuantities.removeAt(index);
      Get.snackbar('Deleted', 'Item deleted from cart');
    }
  }
}
