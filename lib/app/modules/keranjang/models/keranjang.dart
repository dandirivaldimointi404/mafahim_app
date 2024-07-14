import 'package:mafahim_app/app/modules/produk/models/produk.dart';

class Keranjang {
  final int id;
  final int userId;
  final ProductModel produk;
  final int qty;
  final double harga;
  final String status;

  Keranjang({
    required this.id,
    required this.userId,
    required this.produk,
    required this.qty,
    required this.harga,
    required this.status,
  });

  factory Keranjang.fromJson(Map<String, dynamic> json) {
    return Keranjang(
      id: int.parse(json['id'].toString()),
      userId: int.parse(json['user_id'].toString()),
      produk: ProductModel.fromJson(json['produk']),
      qty: int.parse(json['qty'].toString()),
      harga: double.parse(json['harga'].toString()),
      status: json['status'].toString(),
    );
  }
}
