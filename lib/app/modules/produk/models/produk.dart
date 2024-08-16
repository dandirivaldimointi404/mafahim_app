class ProductModel {
  final int id;
  final String kategoriId;
  final String brandId;
  final String namaProduk;
  final double harga;
  final String gambar;
  final double stok;
  DateTime createdAt;
  DateTime updatedAt;
  final String status;


  

  ProductModel({
    required this.id,
    required this.namaProduk,
    required this.harga,
    required this.gambar,
    required this.stok,
    required this.kategoriId,
    required this.brandId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      namaProduk: json['nama_produk'],
      harga: double.parse(json['harga'].toString()),
      stok: double.parse(json['stok'].toString()),
      gambar: json['gambar'],
      status: json['status'],
      kategoriId: json['kategori_id'],
      brandId: json['brand_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}

