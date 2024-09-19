class Transaksi {
  final int id;
  final String orderId;
  final int userId;
  final DateTime tglTransaksi;
  final String totalPembayaran;
  final String totalQty;
  final String metodePembayaran;
  final String? buktiTransaksi;
  final String provinsi;
  final String kota;
  final String? noResi;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  Transaksi({
    required this.id,
    required this.orderId,
    required this.userId,
    required this.tglTransaksi,
    required this.totalPembayaran,
    required this.totalQty,
    required this.metodePembayaran,
    this.buktiTransaksi,
    required this.provinsi,
    required this.kota,
    this.noResi,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Transaksi.fromJson(Map<String, dynamic> json) {
    return Transaksi(
      id: json['id'],
      orderId: json['order_id'],
      userId: int.parse(json['user_id']), // Convert to int from String
      tglTransaksi: DateTime.parse(json['tgl_transaksi']),
      totalPembayaran: json['total_pembayaran'],
      totalQty: json['total_qty'],
      metodePembayaran: json['metode_pembayaran'],
      buktiTransaksi: json['bukti_transaksi'],
      provinsi: json['provinsi'],
      kota: json['kota'],
      noResi: json['no_resi'],
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'order_id': orderId,
      'user_id': userId.toString(), // Convert to String for JSON
      'tgl_transaksi': tglTransaksi.toIso8601String(),
      'total_pembayaran': totalPembayaran,
      'total_qty': totalQty,
      'metode_pembayaran': metodePembayaran,
      'bukti_transaksi': buktiTransaksi,
      'provinsi': provinsi,
      'kota': kota,
      'no_resi': noResi,
      'status': status,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
