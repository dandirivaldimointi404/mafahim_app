import 'package:get/get.dart';
import 'package:mafahim_app/app/data/keranjang_provider.dart';
import 'package:mafahim_app/app/data/transaksi_provider.dart';

import '../controllers/keranjang_controller.dart';

class KeranjangBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KeranjangController>(
      () => KeranjangController(keranjangProvider: KeranjangProvider(), transaksiProvider: TransaksiProvider()),
    );
  }
}
