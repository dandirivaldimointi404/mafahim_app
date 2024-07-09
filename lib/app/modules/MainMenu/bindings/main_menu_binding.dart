import 'package:get/get.dart';
import 'package:mafahim_app/app/data/produk_provider.dart';
import 'package:mafahim_app/app/modules/keranjang/controllers/keranjang_controller.dart';
import 'package:mafahim_app/app/modules/produk/controllers/produk_controller.dart';
import 'package:mafahim_app/app/modules/register/controllers/register_controller.dart';

import '../controllers/main_menu_controller.dart';

class MainMenuBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainMenuController>(
      () => MainMenuController(),
    );
    Get.lazyPut<ProdukController>(
      () => ProdukController(produkProvider: ProdukProvider()),
    );
    Get.lazyPut<KeranjangController>(
      () => KeranjangController(),
    );
      Get.lazyPut<RegisterController>(
      () => RegisterController(),
    );
  }
}
