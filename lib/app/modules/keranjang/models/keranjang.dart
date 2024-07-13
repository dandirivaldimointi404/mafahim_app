import 'package:mafahim_app/app/modules/produk/models/produk.dart';

class Keranjang {
  final int id;
  final int userId;
  final ProductModel produk;
  final double harga;
  final int qty;
  final String status;

  Keranjang({
    required this.id,
    required this.userId,
    required this.produk,
    required this.harga,
    required this.qty,
    required this.status,
  });

  factory Keranjang.fromJson(Map<String, dynamic> json) {
    return Keranjang(
      id: json['id'],
      userId: json['user_id'],
      produk: ProductModel.fromJson(json['produk']),
      harga: json['harga'].toDouble(),
      qty: json['qty'],
      status: json['status'],
    );
  }
}
