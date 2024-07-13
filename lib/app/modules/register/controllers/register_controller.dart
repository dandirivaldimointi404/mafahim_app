import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:mafahim_app/app/data/register_provider.dart'; // Assuming this is your RegisterProvider
import 'package:mafahim_app/app/routes/app_pages.dart';
import 'package:sp_util/sp_util.dart';

class RegisterController extends GetxController {
  final nameController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void onClose() {
    nameController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void register() async {
    String username = usernameController.text.trim();
    String name = nameController.text.trim();
    String password = passwordController.text;

    if (name.isEmpty || username.isEmpty || password.isEmpty) {
      Get.snackbar(
        "Error",
        "Username, Name, and Password cannot be empty",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else {
      EasyLoading.show(status: 'Registering...');

      Map<String, dynamic> data = {
        'name': name,
        'username': username,
        'password': password,
      };

      try {
        var response = await RegisterProvider().register(data);

        if (kDebugMode) {
          print("Registration API Response: ${response.body}");
        }

        if (response.statusCode == 200) {
          var responseBody = response.body;
          var data = responseBody['data'];

          String accessToken = responseBody['access_token'] ?? "";

          SpUtil.putString('name', data['name'] ?? "");
          SpUtil.putString('username', data['username'] ?? "");
          SpUtil.putString('access_token', accessToken);
          SpUtil.putString('id', data['id'].toString());
          SpUtil.putBool('isLogin', true);

          Get.offAllNamed(Routes.MAIN_MENU);

          Get.snackbar('Success', 'Registration successful');
        } else {
          Get.snackbar(
            "Error",
            "Registration failed. Please try again.",
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
          if (kDebugMode) {
            print(
                "Registration failed with status code: ${response.statusCode}");
            print("Response body: ${response.body}");
          }
        }
      } catch (e) {
        Get.snackbar(
          "Error",
          "An error occurred: $e",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        if (kDebugMode) {
          print("Error during registration: $e");
        }
      } finally {
        EasyLoading.dismiss();
      }
    }
  }
}
