import 'package:get/get.dart';
import 'package:mafahim_app/app/data/base_provider.dart';

class ProdukProvider extends BaseProvider {
  Future<Response> getProducts() {
    return get('$myHttpServer/produk',  headers: myHttpHeader);
  }
}
