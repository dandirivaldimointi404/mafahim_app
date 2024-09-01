import 'package:get/get.dart';
import 'package:mafahim_app/app/data/base_provider.dart';

class TransaksiProvider extends BaseProvider {
  Future<Response> transaksi(Map<String, dynamic> data) {
    return post('$myHttpServer/transaksi', data, headers: myHttpHeader);
  }
}
