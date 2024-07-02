import 'package:get/get.dart';
import 'package:sp_util/sp_util.dart';

class BaseProvider extends GetConnect {
  var myHttpServer = "https://balegade-lombok.alpsstudio.id/api";

  Map<String, String> get myHttpHeader {
    return {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${SpUtil.getString("access_token") ?? ''}',
    };
  }
}

