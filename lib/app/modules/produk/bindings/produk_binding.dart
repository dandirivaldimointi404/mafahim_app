import 'package:get/get.dart';
import 'package:mafahim_app/app/data/produk_provider.dart';

import '../controllers/produk_controller.dart';

class ProdukBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProdukController>(
      () => ProdukController(produkProvider: ProdukProvider()),
    );
  }
}
