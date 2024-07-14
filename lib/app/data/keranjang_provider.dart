import 'package:get/get.dart';
import 'package:mafahim_app/app/data/base_provider.dart';

class KeranjangProvider extends BaseProvider {

  Future<Response> postKeranjang(Map<String, dynamic> data) {
    return post('$myHttpServer/store', data, headers: myHttpHeader);
  }

  Future<Response> getKeranjang() {
    return get('$myHttpServer/index',  headers: myHttpHeader);
  }

  deleteKeranjang(int id) {}

  updateQuantity(int id, int updatedQuantity) {}

}
