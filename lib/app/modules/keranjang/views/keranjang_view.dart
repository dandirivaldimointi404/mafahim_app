import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mafahim_app/app/modules/keranjang/models/keranjang.dart';

import '../controllers/keranjang_controller.dart';

class KeranjangView extends GetView<KeranjangController> {
  const KeranjangView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Keranjang'),
        centerTitle: false,
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            onPressed: () {
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
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                        radius: 30, 
                        backgroundImage: keranjang.produk.gambarProduk.isEmpty
                            ? NetworkImage(keranjang.produk.gambarProduk)
                            : const AssetImage('images/mafahim.png'),
                      ),
                      title: Text(
                        keranjang.produk.namaProduk,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        'Harga: ${keranjang.produk.hargaProduk}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      // You can add more content here if needed
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
