// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../controllers/history_controller.dart';

// class HistoryView extends GetView<HistoryController> {
//   const HistoryView({super.key});
  
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Order History'),
//         centerTitle: true,
//         backgroundColor: Colors.green,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Obx(() {
//           final controller = Get.find<HistoryController>();
//           return Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Card(
//                 elevation: 5.0,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10.0),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       _buildSummaryRow('Sub Total:', controller.orderSubTotal.value),
//                       const Divider(),
//                       _buildSummaryRow('Ongkos Kirim:', controller.orderShippingCost.value),
//                       const Divider(),
//                       _buildSummaryRow('Metode Pembayaran:', controller.orderPaymentMethod.value),
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20.0), // Optional space below the card
//               // You can add other widgets here if needed
//             ],
//           );
//         }),
//       ),
//     );
//   }

//   Widget _buildSummaryRow(String label, dynamic value) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           label,
//           style: const TextStyle(
//             fontSize: 16.0,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         Text(
//           value.toString(),
//           style: const TextStyle(
//             fontSize: 16.0,
//             color: Colors.grey,
//           ),
//         ),
//       ],
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/history_controller.dart';

class HistoryView extends GetView<HistoryController> {
  const HistoryView({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order History'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          final controller = Get.find<HistoryController>();

          // Cek apakah transaksiList kosong
          if (controller.transaksiList.isEmpty) {
            return const Center(
              child: Text('No transactions found'),
            );
          }

          // Menampilkan daftar transaksi dalam bentuk ListView
          return ListView.builder(
            itemCount: controller.transaksiList.length,
            itemBuilder: (context, index) {
              final transaksi = controller.transaksiList[index];
              return Card(
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSummaryRow('Order ID:', transaksi.orderId),
                      _buildSummaryRow('Tanggal:', transaksi.tglTransaksi.toLocal().toString()),  // Format tanggal sesuai kebutuhan
                      _buildSummaryRow('Total Pembayaran:', transaksi.totalPembayaran),
                      _buildSummaryRow('Jumlah Barang:', transaksi.totalQty),
                      _buildSummaryRow('Metode Pembayaran:', transaksi.metodePembayaran),
                      const Divider(),
                      _buildSummaryRow('Provinsi:', transaksi.provinsi),
                      _buildSummaryRow('Kota:', transaksi.kota),
                      const Divider(),
                      _buildSummaryRow('Status:', transaksi.status == '1' ? 'Completed' : 'Pending'),
                    ],
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16.0,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
