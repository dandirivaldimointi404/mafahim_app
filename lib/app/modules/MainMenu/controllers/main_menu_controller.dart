import 'package:get/get.dart';
import 'package:mafahim_app/app/data/keranjang_provider.dart';

class MainMenuController extends GetxController {
  var tabIndex = 0.obs;
   var cartItemCount = 0.obs;

  final KeranjangProvider _keranjangProvider = KeranjangProvider();

  @override
  void onInit() {
    super.onInit();
    _fetchCartItemCount();
  }

  void changeTabIndex(int index) {
    tabIndex.value = index;
    update();
  }

  Future<void> _fetchCartItemCount() async {
    int count = await _keranjangProvider.getCartItemCount();
    cartItemCount.value = count;
  }
}
