import 'package:flutter/material.dart';
import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:mafahim_app/app/modules/keranjang/controllers/keranjang_controller.dart';
import 'package:mafahim_app/app/modules/keranjang/models/keranjang.dart';

class KeranjangView extends GetView<KeranjangController> {
  const KeranjangView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Keranjang'),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            onPressed: () {
              // Implement any action here if needed
            },
            icon: const Icon(Icons.shopping_cart),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.isTrue) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (controller.keranjangList.isEmpty) {
          return const Center(
            child: Text('No items in keranjang'),
          );
        } else {
          return ListView.builder(
            itemCount: controller.keranjangList.length,
            itemBuilder: (context, index) {
              Keranjang keranjang = controller.keranjangList[index];
              RxInt itemQuantity = controller.itemQuantities[index];

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () {
                      // Handle tap on the card
                    },
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(keranjang.produk.gambarProduk),
                      ),
                      title: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                  ).format(keranjang.produk.hargaProduk),
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
          );
        }
      }),
    );
  }
}
