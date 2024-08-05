import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:mafahim_app/app/modules/keranjang/controllers/keranjang_controller.dart';

class BeratBarang extends GetView<KeranjangController> {
  const BeratBarang({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              autocorrect: false,
              controller: controller.beratC,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: "Berat Barang",
                hintText: "Masukkan Berat Barang",
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => controller.ubahBerat(value),
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 100, 
            child: DropdownSearch<String>(
              selectedItem: "gram", 
              items: const [
                "ton",
                "kwintal",
                "ons",
                "lbs",
                "pound",
                "kg",
                "hg",
                "dag",
                "gram",
                "dg",
                "cg",
                "mg",
              ],
              onChanged: (value) => controller.ubahSatuan(value!),
            ),
          ),
        ],
      ),
    );
  }
}
