import 'package:get/get.dart';
import 'package:mafahim_app/app/data/transaksi_provider.dart';
import 'package:mafahim_app/app/modules/history/models/transaksi.dart';

class HistoryController extends GetxController {
  var transaksiList = <Transaksi>[].obs;
   
  @override
  void onInit() {
    super.onInit();
    fetchTransaksi();
  }

void fetchTransaksi() async {
  final response = await TransaksiProvider().getTransaksi({}); // Sertakan queryParams jika ada

  if (response.statusCode == 200) {
    List<dynamic> data = response.body;
    transaksiList.value = data.map((json) => Transaksi.fromJson(json)).toList();
  } else {
    Get.snackbar('Error', 'Failed to load transaction data');
  }
}

//  var orderSubTotal = 0.0.obs;
//   var orderShippingCost = 0.0.obs;
//   var orderPaymentMethod = ''.obs;

//   void saveOrderData(double subTotal, double shippingCost, String paymentMethod) {
//     orderSubTotal.value = subTotal;
//     orderShippingCost.value = shippingCost;
//     orderPaymentMethod.value = paymentMethod;
//   }

}
