import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mafahim_app/app/modules/keranjang/controllers/keranjang_controller.dart';

class CheckoutView extends GetView<KeranjangController> {
  const CheckoutView({super.key});

  @override
  Widget build(BuildContext context) {
    final double subTotal = 150000.00;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ringkasan Pengiriman'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          width: double
              .infinity, // Make the container fill the width of its parent
          child: Card(
            elevation: 2.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Obx(() {
                final shippingCost = controller.shippingCost.value;
                final double total = subTotal + shippingCost;
                return Column(
                  mainAxisSize: MainAxisSize
                      .min, // Ensure the column's size fits its content
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
                    _buildSummaryRow(
                        'Sub Total:', subTotal, controller.currencyFormat),
                    const SizedBox(height: 8.0),
                    GestureDetector(
                      onTap: () => _showShippingOptions(context),
                      child: _buildSummaryRow(
                        'Ongkos Kirim:',
                        shippingCost,
                        controller.currencyFormat,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    const Divider(),
                    _buildSummaryRow('Total:', total, controller.currencyFormat,
                        isTotal: true),
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, double amount, NumberFormat format,
      {bool isTotal = false}) {
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
          format.format(amount), // Format amount using NumberFormat
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
                children: controller.shippingOptions.map((option) {
                  final label = option.keys.first;
                  final cost = option.values.first;
                  return ListTile(
                    title: Text(label),
                    subtitle: Text(controller.currencyFormat.format(cost)),
                    onTap: () {
                      controller.shippingCost.value = cost;
                      Get.back();
                    },
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
      isDismissible: true,
      enableDrag: true,
      backgroundColor:
          Colors.transparent, // Optional, if you want a transparent background
    );
  }
}
