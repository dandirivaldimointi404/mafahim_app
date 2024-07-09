import 'package:get/get.dart';
import 'package:mafahim_app/app/modules/register/controllers/register_controller.dart';

import '../controllers/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
      () => LoginController(),
    );
      Get.lazyPut<RegisterController>(
      () => RegisterController(),
    );
  }
}
