import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:mafahim_app/app/modules/keranjang/controllers/keranjang_controller.dart';
import 'package:mafahim_app/app/modules/keranjang/views/widgets/berat.dart';
import 'package:mafahim_app/app/modules/keranjang/views/widgets/city.dart';
import 'package:mafahim_app/app/modules/keranjang/views/widgets/province.dart';

class CheckoutView extends GetView<KeranjangController> {
  const CheckoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ongkos Kirim Indonesia'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Provinsi(tipe: "asal"),
            Obx(
              () => controller.hiddenKotaAsal.isTrue
                  ? const SizedBox()
                  : Kota(
                      provId: controller.provAsalId.value,
                      tipe: "asal",
                    ),
            ),
            const Provinsi(tipe: "tujuan"),
            Obx(
              () => controller.hiddenKotaTujuan.isTrue
                  ? const SizedBox()
                  : Kota(
                      provId: controller.provTujuanId.value,
                      tipe: "tujuan",
                    ),
            ),
            const BeratBarang(),
            Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: DropdownSearch<Map<String, dynamic>>(
                items: const [
                  {"code": "jne", "name": "Jalur Nugraha Ekakurir (JNE)"},
                  {"code": "tiki", "name": "Titipan Kilat (TIKI)"},
                  {"code": "pos", "name": "Perusahaan Opsional Surat (POS)"},
                ],
                selectedItem: const {"code": "jne", "name": "Jalur Nugraha Ekakurir (JNE)"},
                onChanged: (value) {
                  if (value != null) {
                    controller.kurir.value = value["code"];
                    controller.showButton();
                  } else {
                    controller.hiddenButton.value = true;
                    controller.kurir.value = "";
                  }
                },
                dropdownDecoratorProps: const DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                    labelText: "Tipe Kurir",
                    border: OutlineInputBorder(),
                  ),
                ),
                popupProps: const PopupProps.menu(
                  showSearchBox: true,
                ),
                itemAsString: (item) => item["name"].toString(),
              ),
            ),
            Obx(
              () => controller.hiddenButton.isTrue
                  ? const SizedBox()
                  : ElevatedButton(
                      onPressed: () => controller.ongkosKirim(),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        backgroundColor: Colors.green,
                      ),
                      child: const Text("CEK ONGKOS KIRIM", style: TextStyle(color: Colors.white)),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
