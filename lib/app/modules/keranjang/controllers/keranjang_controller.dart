import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mafahim_app/app/data/keranjang_provider.dart';
import 'package:mafahim_app/app/data/transaksi_provider.dart';
import 'package:mafahim_app/app/modules/keranjang/models/keranjang.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import '../models/courier_model.dart';
import 'package:intl/intl.dart';

class KeranjangController extends GetxController {
  var hiddenKotaAsal = true.obs;
  var provAsalId = 0.obs;
  var kotaAsalId = 0.obs;
  var hiddenKotaTujuan = true.obs;
  var provTujuanId = 0.obs;
  var kotaTujuanId = 0.obs;
  var hiddenButton = true.obs;
  var kurir = "".obs;

  var provinsi = ''.obs;
  var kota = ''.obs;
  var desa = ''.obs;
  var nomorTelepon = ''.obs;

  RxString selectedPaymentMethod = 'COD'.obs;

  String get paymentMethod => selectedPaymentMethod.value;

  RxDouble shippingCost = 25000.00.obs;
  RxString selectedShippingOption = ''.obs;
  final List<Map<String, double>> shippingOptions = [
    {'Standar': 25000.00},
    {'Ekspres': 50000.00},
    {'Same Day': 100000.00},
  ];

  final NumberFormat currencyFormat = NumberFormat.simpleCurrency(name: 'IDR');

  double berat = 0.0;
  String satuan = "gram";

  late TextEditingController beratC;

  var keranjangList = <Keranjang>[].obs;
  var isLoading = true.obs;
  RxList<RxInt> itemQuantities = <RxInt>[].obs;
  final KeranjangProvider keranjangProvider;
  final TransaksiProvider transaksiProvider;

  KeranjangController({
    required this.keranjangProvider,
    required this.transaksiProvider,
  });

  double get totalHargaProduk {
    double total = 0;
    for (int i = 0; i < keranjangList.length; i++) {
      if (i < itemQuantities.length) {
        total += keranjangList[i].harga * itemQuantities[i].value;
        if (kDebugMode) {
          debugPrint(
              'Item ${i + 1}: Harga = ${keranjangList[i].harga}, Quantity = ${itemQuantities[i].value}, Total = ${keranjangList[i].harga * itemQuantities[i].value}');
        }
      }
    }
    if (kDebugMode) {
      debugPrint('Total Harga Produk: $total');
    }
    return total;
  }

  double get totalHargaKeseluruhan {
    double ongkir = 5000;
    return totalHargaProduk + ongkir;
  }

  get locationController => null;

  get address => null;

  get shippingAddress => null;

  @override
  void onInit() {
    beratC = TextEditingController(text: "$berat");
    fetchKeranjang();
    super.onInit();
  }

  @override
  void onClose() {
    beratC.dispose();
    super.onClose();
  }

  void fetchKeranjang() async {
    try {
      isLoading(true);
      final response = await keranjangProvider.getKeranjang();
      if (response.statusCode == 200) {
        List<dynamic> data = response.body['data'];
        keranjangList.assignAll(
          data.map((item) => Keranjang.fromJson(item)).toList(),
        );

        itemQuantities.assignAll(
          List.generate(keranjangList.length, (index) => 1.obs),
        );
      } else {
        Get.snackbar('Error', 'Failed to load cart items');
      }
    } catch (e) {
      Get.snackbar('Error', 'Exception occurred while fetching cart items');
    } finally {
      isLoading(false);
    }
  }

  void incrementQuantity(int index) {
    if (index >= 0 && index < itemQuantities.length) {
      if (itemQuantities[index].value < 99) {
        itemQuantities[index]++;
      }
    }
  }

  void decrementQuantity(int index) {
    if (index >= 0 && index < itemQuantities.length) {
      if (itemQuantities[index].value > 1) {
        itemQuantities[index]--;
      }
    }
  }

  void hapusBarang(Keranjang keranjang) {
    int index = keranjangList.indexWhere((item) => item.id == keranjang.id);
    if (index != -1) {
      keranjangList.removeAt(index);
      itemQuantities.removeAt(index);
      Get.snackbar('Deleted', 'Item deleted from cart');
    }
  }

  void ongkosKirim() async {
    Uri url = Uri.parse("https://api.rajaongkir.com/starter/cost");
    try {
      final response = await http.post(
        url,
        body: {
          "origin": "$kotaAsalId",
          "destination": "$kotaTujuanId",
          "weight": "$berat",
          "courier": "$kurir",
        },
        headers: {
          "key": "7aa8be70dd7cf66a6365f22ff544092a",
          "content-type": "application/x-www-form-urlencoded",
        },
      );

      var data = json.decode(response.body) as Map<String, dynamic>;
      var results = data["rajaongkir"]["results"] as List<dynamic>;

      var listAllCourier = Courier.fromJsonList(results);
      var courier = listAllCourier[0];

      Get.defaultDialog(
        title: courier.name!,
        content: Column(
          children: courier.costs!
              .map(
                (e) => ListTile(
                  title: Text("${e.service}"),
                  subtitle: Text("Rp ${e.cost![0].value}"),
                  trailing: Text(
                    courier.code == "pos"
                        ? "${e.cost![0].etd}"
                        : "${e.cost![0].etd} HARI",
                  ),
                ),
              )
              .toList(),
        ),
      );
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: err.toString(),
      );
    }
  }

  void showButton() {
    // ignore: unrelated_type_equality_checks
    if (kotaAsalId != 0 && kotaTujuanId != 0 && berat > 0 && kurir != "") {
      hiddenButton.value = false;
    } else {
      hiddenButton.value = true;
    }
  }

  void ubahBerat(String value) {
    berat = double.tryParse(value) ?? 0.0;
    String cekSatuan = satuan;
    switch (cekSatuan) {
      case "ton":
        berat = berat * 1000000;
        break;
      case "kwintal":
        berat = berat * 100000;
        break;
      case "ons":
        berat = berat * 100;
        break;
      case "lbs":
        berat = berat * 2204.62;
        break;
      case "pound":
        berat = berat * 2204.62;
        break;
      case "kg":
        berat = berat * 1000;
        break;
      case "hg":
        berat = berat * 100;
        break;
      case "dag":
        berat = berat * 10;
        break;
      case "gram":
        berat = berat;
        break;
      case "dg":
        berat = berat / 10;
        break;
      case "cg":
        berat = berat / 100;
        break;
      case "mg":
        berat = berat / 1000;
        break;
      default:
        berat = berat;
    }

    if (kDebugMode) {
      print("$berat gram");
    }
    showButton();
  }

  void ubahSatuan(String value) {
    berat = double.tryParse(beratC.text) ?? 0.0;
    switch (value) {
      case "ton":
        berat = berat * 1000000;
        break;
      case "kwintal":
        berat = berat * 100000;
        break;
      case "ons":
        berat = berat * 100;
        break;
      case "lbs":
        berat = berat * 2204.62;
        break;
      case "pound":
        berat = berat * 2204.62;
        break;
      case "kg":
        berat = berat * 1000;
        break;
      case "hg":
        berat = berat * 100;
        break;
      case "dag":
        berat = berat * 10;
        break;
      case "gram":
        berat = berat;
        break;
      case "dg":
        berat = berat / 10;
        break;
      case "cg":
        berat = berat / 100;
        break;
      case "mg":
        berat = berat / 1000;
        break;
      default:
        berat = berat;
    }

    satuan = value;

    if (kDebugMode) {
      print("$berat gram");
    }
    showButton();
  }

  Future<bool> postTransaction() async {
    Map<String, dynamic> transaksiData = {
      "total_pembayaran": totalHargaKeseluruhan,
      "metode_pembayaran": selectedPaymentMethod.value,
      "bukti_transaksi": "",
      "provinsi": provinsi.value,
      "kota": kota.value,
      "no_resi": "",
      "details": keranjangList
          .map((item) => {
                "produk_id": item.produk.id,
                "qty": itemQuantities[keranjangList.indexOf(item)].value
              })
          .toList(),
    };

    print('Transaksi Data: $transaksiData');

    try {
      final response = await transaksiProvider.postTransaksi(transaksiData);
      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 201) {
        Get.snackbar('Success', 'Transaction successful');
        return true;
      } else {
        Get.snackbar('Error', 'Failed to complete transaction');
        return false;
      }
    } catch (e) {
      print('Exception: $e');
      Get.snackbar(
          'Error', 'Exception occurred while processing the transaction');
      return false;
    }
  }
}
