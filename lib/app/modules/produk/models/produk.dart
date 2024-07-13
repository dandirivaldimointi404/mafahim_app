class ProductModel {
  final int id;
  final String namaProduk;
  final double hargaProduk;
  final String gambarProduk;
  final String deskripsiProduk;
  final double stok;

  ProductModel({
    required this.id,
    required this.namaProduk,
    required this.hargaProduk,
    required this.gambarProduk,
    required this.deskripsiProduk,
    required this.stok,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      namaProduk: json['nama_produk'],
      hargaProduk: double.parse(json['harga_produk'].toString()),
      stok: double.parse(json['stok'].toString()),
      gambarProduk: json['gambar_produk'],
      deskripsiProduk: json['deskripsi_produk'],
    );
  }
}