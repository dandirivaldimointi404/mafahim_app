import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mafahim_app/app/modules/keranjang/controllers/keranjang_controller.dart';
import 'package:mafahim_app/app/modules/history/controllers/history_controller.dart';
import 'package:mafahim_app/app/modules/history/views/history_view.dart';

class CheckoutView extends GetView<KeranjangController> {
  final double subTotal;

  const CheckoutView({super.key, required this.subTotal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengiriman'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  Container(
                    width: double.infinity,
                    child: Card(
                      elevation: 2.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Obx(() {
                          final shippingCost = controller.shippingCost.value;
                          final shippingOption = controller.selectedShippingOption.value;
                          final double total = subTotal + shippingCost;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Ringkasan Pengiriman',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              _buildSummaryRow('Sub Total:', subTotal, controller.currencyFormat),
                              const SizedBox(height: 8.0),
                              GestureDetector(
                                onTap: () => _showShippingOptions(context),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildSummaryRow(
                                      'Ongkos Kirim:',
                                      shippingCost,
                                      controller.currencyFormat,
                                    ),
                                    if (shippingOption.isNotEmpty)
                                      Text(
                                        shippingOption,
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              const Divider(),
                              _buildSummaryRow('Total:', total, controller.currencyFormat, isTotal: true),
                            ],
                          );
                        }),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Card(
                    elevation: 2.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Metode Pembayaran',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          Obx(() {
                            return Column(
                              children: [
                                RadioListTile<String>(
                                  title: const Text('COD (Cash on Delivery)'),
                                  value: 'COD',
                                  groupValue: controller.selectedPaymentMethod.value,
                                  onChanged: (value) {
                                    controller.selectedPaymentMethod.value = value!;
                                  },
                                ),
                                RadioListTile<String>(
                                  title: const Text('Transfer Bank'),
                                  value: 'Transfer',
                                  groupValue: controller.selectedPaymentMethod.value,
                                  onChanged: (value) {
                                    controller.selectedPaymentMethod.value = value!;
                                  },
                                ),
                              ],
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            color: Colors.lightGreen[100],
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(() {
                    final totalHarga = controller.totalHargaProduk;
                    final shippingCost = controller.shippingCost.value;
                    final total = totalHarga + shippingCost;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSummaryRow('Total:', total, controller.currencyFormat, isTotal: true),
                      ],
                    );
                  }),
                  ElevatedButton(
                    onPressed: () {
                      final total = subTotal + controller.shippingCost.value;

                      // Simpan data ke kontroler History
                      final historyController = Get.find<HistoryController>();
                      historyController.saveOrderData(subTotal, controller.shippingCost.value, controller.selectedPaymentMethod.value);

                      // Pindah ke HistoryView
                      Get.to(() => const HistoryView());
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.green,
                    ),
                    child: const Text('Buat Pesan'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, double amount, NumberFormat format, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            fontSize: isTotal ? 18.0 : 16.0,
          ),
        ),
        Text(
          format.format(amount),
          style: TextStyle(
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            fontSize: isTotal ? 18.0 : 16.0,
          ),
        ),
      ],
    );
  }

  void _showShippingOptions(BuildContext context) {
    Get.bottomSheet(
      Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey.shade300),
                ),
              ),
              child: const Center(
                child: Text(
                  'Pilih Jenis Ongkos Kirim',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16.0),
                children: controller.shippingOptions.isNotEmpty
                    ? controller.shippingOptions.map((option) {
                        final label = option.keys.first;
                        final cost = option.values.first;
                        return ListTile(
                          title: Text(label),
                          subtitle: Text(controller.currencyFormat.format(cost)),
                          onTap: () {
                            controller.shippingCost.value = cost;
                            controller.selectedShippingOption.value = label;
                            Get.back();
                          },
                        );
                      }).toList()
                    : [const Center(child: Text('No options available'))],
              ),
            ),
          ],
        ),
      ),
      isDismissible: true,
      enableDrag: true,
      backgroundColor: Colors.transparent,
    );
  }
}
