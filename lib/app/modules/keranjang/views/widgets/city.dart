import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:dropdown_search/dropdown_search.dart';
import 'package:mafahim_app/app/modules/keranjang/controllers/keranjang_controller.dart';
import '../../models/city_model.dart';

class Kota extends GetView<KeranjangController> {
  const Kota({
    Key? key,
    required this.provId,
    required this.tipe,
  }) : super(key: key);

  final int provId;
  final String tipe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: DropdownSearch<City>(
        dropdownDecoratorProps: DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            labelText: tipe == "asal"
                ? "Kota / Kabupaten Asal"
                : "Kota / Kabupaten Tujuan",
          ),
        ),
        asyncItems: (String filter) async {
          try {
            final response = await fetchCities(provId);
            if (response.statusCode == 200) {
              var data = json.decode(response.body) as Map<String, dynamic>;
              var statusCode = data["rajaongkir"]["status"]["code"];
              if (statusCode == 200) {
                var listAllCity =
                    data["rajaongkir"]["results"] as List<dynamic>;
                return City.fromJsonList(listAllCity);
              } else {
                throw Exception(data["rajaongkir"]["status"]["description"]);
              }
            } else {
              throw Exception(
                  "Failed to load cities. Status code: ${response.statusCode}");
            }
          } catch (err) {
            if (kDebugMode) {
              print("Error: $err");
            }
            return List<City>.empty();
          }
        },
        onChanged: (City? cityValue) {
          if (cityValue != null) {
            final cityId = int.parse(cityValue.cityId!);
            if (tipe == "asal") {
              controller.kotaAsalId.value = cityId;
            } else {
              controller.kotaTujuanId.value = cityId;
            }
          } else {
            if (tipe == "asal") {
              if (kDebugMode) {
                print("Tidak memilih kota / kabupaten asal apapun");
              }
              controller.kotaAsalId.value = 0;
            } else {
              if (kDebugMode) {
                print("Tidak memilih kota / kabupaten tujuan apapun");
              }
              controller.kotaTujuanId.value = 0;
            }
          }
          controller.showButton();
        },
        popupProps: PopupProps.menu(
          showSearchBox: true,
          searchFieldProps: TextFieldProps(
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: tipe == "asal"
                  ? "Cari kota / kabupaten asal"
                  : "Cari kota / kabupaten tujuan",
            ),
          ),
          itemBuilder: (context, City item, bool isSelected) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                "${item.type} ${item.cityName}",
                style: const TextStyle(fontSize: 18),
              ),
            );
          },
        ),
        itemAsString: (City item) => "${item.type} ${item.cityName}",
      ),
    );
  }

  Future<http.Response> fetchCities(int provinceId) {
    final Uri url = Uri.parse(
      "https://api.rajaongkir.com/starter/city?province=$provinceId",
    );

    return http.get(
      url,
      headers: {
        "key":
            "7aa8be70dd7cf66a6365f22ff544092a", 
      },
    );
  }
}
