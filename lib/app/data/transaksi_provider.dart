import 'package:get/get.dart';
import 'package:mafahim_app/app/data/base_provider.dart';

class TransaksiProvider extends BaseProvider {
  Future<Response> postTransaksi(Map<String, dynamic> data) {
    return post('$myHttpServer/transaksi', data, headers: myHttpHeader);
  }

  Future<Response> getTransaksi(Map<String, dynamic> queryParams) {
    final uri = Uri.parse('$myHttpServer/gettransaksi').replace(queryParameters: queryParams);
    return get(uri.toString(), headers: myHttpHeader);
  }
}
