import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mafahim_app/app/modules/keranjang/controllers/keranjang_controller.dart';
import 'package:mafahim_app/app/modules/keranjang/models/keranjang.dart';
import 'package:mafahim_app/app/modules/keranjang/views/checkout_view.dart';

class KeranjangView extends GetView<KeranjangController> {
  const KeranjangView({super.key});

  Future<void> _refreshData() async {
    controller.fetchKeranjang();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Keranjang'),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.shopping_cart),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (controller.isLoading.isTrue) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (controller.keranjangList.isEmpty) {
                return const Center(
                  child: Text('No items in keranjang'),
                );
              } else {
                return RefreshIndicator(
                  onRefresh: _refreshData,
                  child: ListView.builder(
                    itemCount: controller.keranjangList.length,
                    itemBuilder: (context, index) {
                      Keranjang keranjang = controller.keranjangList[index];
                      RxInt itemQuantity = controller.itemQuantities[index];

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(10),
                            onTap: () {},
                            child: ListTile(
                              leading: CircleAvatar(
                                radius: 20,
                                backgroundImage:
                                    NetworkImage(keranjang.produk.gambar),
                              ),
                              title: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          keranjang.produk.namaProduk,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          NumberFormat.currency(
                                            locale: 'id_ID',
                                            symbol: 'Rp',
                                            decimalDigits: 0,
                                          ).format(keranjang.harga),
                                          style: const TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          controller.decrementQuantity(index);
                                        },
                                        icon: const Icon(Icons.remove),
                                      ),
                                      Obx(() => Text('${itemQuantity.value}')),
                                      IconButton(
                                        onPressed: () {
                                          controller.incrementQuantity(index);
                                        },
                                        icon: const Icon(Icons.add),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              trailing: IconButton(
                                onPressed: () {
                                  controller.hapusBarang(keranjang);
                                },
                                icon: const Icon(Icons.delete),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
            }),
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
                    return Text(
                      'Total: ${NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0).format(totalHarga)}',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    );
                  }),
                  Obx(() => ElevatedButton(
                        onPressed: controller.keranjangList.isNotEmpty
                            ? () {
                                final subTotal = controller.totalHargaProduk;
                                Get.to(() => CheckoutView(subTotal: subTotal));
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.green,
                        ),
                        child: const Text('Checkout'),
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
