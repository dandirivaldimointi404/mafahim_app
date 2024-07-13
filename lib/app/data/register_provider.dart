import 'package:get/get.dart';
import 'package:mafahim_app/app/data/base_provider.dart';

class RegisterProvider extends BaseProvider {
  
  Future<Response> register(Map<String, dynamic> data) {
    return post('$myHttpServer/register', data, headers: myHttpHeader);
  }
}
