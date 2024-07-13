import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:mafahim_app/app/data/login_provider.dart';
import 'package:mafahim_app/app/routes/app_pages.dart';
import 'package:sp_util/sp_util.dart';

class LoginController extends GetxController {
  var showPassword = false.obs;
  TextEditingController txtUsername = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

  void toggleShowPassword() {
    showPassword.toggle();
  }

  void auth() {
    String username = txtUsername.text;
    String password = txtPassword.text;

    if (username.isEmpty || password.isEmpty) {
      Get.snackbar(
        "Error",
        "Username dan Password Tidak Boleh Kosong",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else {
      EasyLoading.show();
      var data = {
        "username": username,
        "password": password,
      };

      LoginProvider().auth(data).then(
        (value) {
          if (kDebugMode) {
            print("Login API Response: $value");
          }

          if (value.statusCode == 200) {
            var responseBody = value.body;
            var data = responseBody['data'];

            String accessToken = responseBody['access_token'] ?? "";
            if (kDebugMode) {
              print("Access Token: $accessToken");
            }

            SpUtil.putString('name', data['name'] ?? "");
            SpUtil.putString('username', data['username'] ?? "");
            SpUtil.putString('avatar', data['avatar'] ?? "");
            SpUtil.putString('access_token', accessToken);
            SpUtil.putString('id', data['id'].toString());
            SpUtil.putString(
                'email_verified_at', data['email_verified_at'] ?? "");

            SpUtil.putBool('isLogin', true);
            Get.offAllNamed(Routes.MAIN_MENU);
          } else {
            Get.snackbar(
              "Error",
              "Login Gagal",
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
            if (kDebugMode) {
              print("Login failed with status code: ${value.statusCode}");
            }
            if (kDebugMode) {
              print("Response body: ${value.body}");
            }
          }
          EasyLoading.dismiss();
        },
      ).catchError((error) {
        Get.snackbar(
          "Error",
          "An error occurred: $error",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        EasyLoading.dismiss();
        if (kDebugMode) {
          print("Error during login: $error");
        }
      });
    }
  }
}
