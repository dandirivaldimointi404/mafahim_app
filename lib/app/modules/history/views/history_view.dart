import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/history_controller.dart';

class HistoryView extends GetView<HistoryController> {
  const HistoryView({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History View'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          final controller = Get.find<HistoryController>();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Sub Total: ${controller.orderSubTotal.value}', style: const TextStyle(fontSize: 18)),
              Text('Ongkos Kirim: ${controller.orderShippingCost.value}', style: const TextStyle(fontSize: 18)),
              Text('Metode Pembayaran: ${controller.orderPaymentMethod.value}', style: const TextStyle(fontSize: 18)),
            ],
          );
        }),
      ),
    );
  }
}
