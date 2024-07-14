import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:mafahim_app/app/data/keranjang_provider.dart';
import 'package:mafahim_app/app/modules/keranjang/models/keranjang.dart';

class KeranjangController extends GetxController {
  var keranjangList = <Keranjang>[].obs;
  var isLoading = true.obs;
  RxList<RxInt> itemQuantities = <RxInt>[].obs; // List of RxInt for item quantities
  final KeranjangProvider keranjangProvider;

  KeranjangController({required this.keranjangProvider});

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

        // Initialize itemQuantities with default values (1 for each item)
        itemQuantities.assignAll(List.generate(keranjangList.length, (index) => 1.obs));

        if (kDebugMode) {
          debugPrint('Data keranjang berhasil diambil:');
          for (var keranjang in keranjangList) {
            debugPrint(
              'ID: ${keranjang.id}, Nama: ${keranjang.produk.namaProduk}',
            );
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

  void incrementQuantity(int index) {
    if (itemQuantities[index].value < 99) { // Example limit, adjust as needed
      itemQuantities[index]++;
      // Optional: Update backend or local storage here
    }
  }

  void decrementQuantity(int index) {
    if (itemQuantities[index].value > 1) {
      itemQuantities[index]--;
      // Optional: Update backend or local storage here
    }
  }

  void hapusBarang(Keranjang keranjang) {
    int index = keranjangList.indexWhere((item) => item.id == keranjang.id);
    if (index != -1) {
      keranjangList.removeAt(index);
      itemQuantities.removeAt(index);
      Get.snackbar('Deleted', 'Item deleted from cart');
      // Optional: Update backend or local storage here
    }
  }
}
