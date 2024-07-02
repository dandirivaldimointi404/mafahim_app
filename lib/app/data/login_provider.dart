import 'package:get/get.dart';
import 'package:mafahim_app/app/data/base_provider.dart';

class LoginProvider extends BaseProvider {
  Future<Response> auth(var data) {
    return post('$myHttpServer/login', data, headers: myHttpHeader);
  }
}
