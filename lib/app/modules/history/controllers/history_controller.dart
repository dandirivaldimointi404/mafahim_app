import 'package:get/get.dart';

class HistoryController extends GetxController {

 var orderSubTotal = 0.0.obs;
  var orderShippingCost = 0.0.obs;
  var orderPaymentMethod = ''.obs;

  void saveOrderData(double subTotal, double shippingCost, String paymentMethod) {
    orderSubTotal.value = subTotal;
    orderShippingCost.value = shippingCost;
    orderPaymentMethod.value = paymentMethod;
  }

}
