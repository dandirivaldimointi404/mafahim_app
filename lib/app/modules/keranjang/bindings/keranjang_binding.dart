import 'package:get/get.dart';
import 'package:mafahim_app/app/data/keranjang_provider.dart';
import 'package:mafahim_app/app/modules/history/controllers/history_controller.dart';

import '../controllers/keranjang_controller.dart';

class KeranjangBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KeranjangController>(
      () => KeranjangController(keranjangProvider: KeranjangProvider()),
    );

    
  }
}
