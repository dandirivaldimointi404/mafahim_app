import 'package:get/get.dart';
import 'package:mafahim_app/app/data/base_provider.dart';

class KeranjangProvider extends BaseProvider {

  Future<Response> postKeranjang(Map<String, dynamic> data) {
    return post('$myHttpServer/store', data, headers: myHttpHeader);
  }

  Future<Response> getKeranjang() {
    return get('$myHttpServer/index',  headers: myHttpHeader);
  }

   Future<int> getCartItemCount() async {
    final response = await getKeranjang();
    if (response.statusCode == 200) {
      // Assume response.body contains a list of cart items
      List<dynamic> cartItems = response.body['data'];
      return cartItems.length;
    } else {
      return 0;
    }
  }

  deleteKeranjang(int id) {}

  updateQuantity(int id, int updatedQuantity) {}

}
