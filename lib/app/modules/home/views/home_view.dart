import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Logo Perusahaan
            Container(
              margin: const EdgeInsets.all(10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  "img/mafahim.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Mafahim didirikan pada tanggal 19 Desember 2016. '
                'Awalnya berbentuk industri kecil dan menengah (UIMKM) dengan nama Alfikroh. '
                'Produk awal Mafahim adalah teh daun sirsak, dikemas dalam bentuk serbuk '
                'di dalam kemasan plastik es batu tanpa izin resmi dan perkebunan sirsak. '
                'Seiring berjalannya waktu, Mafahim berusaha berinovasi di bidang pertanian, '
                'melibatkan diri dalam budidaya tanaman perkebunan dan hortikultura.',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 14),
              ),
            ),

            // Lensa Kegiatan
            _buildActivitySection(),
          ],
        ),
      ),
    );
  }

  Widget _buildActivitySection() {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Judul "Lensa Kegiatan"
          const Text(
            'Lensa Kegiatan',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 16),

          // Daftar gambar kegiatan
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildActivityImage('img/lensa1.jpg'),
              _buildActivityImage('img/lensa2.jpg'),
            ],
          ),

          const SizedBox(height: 16),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildActivityImage('img/lensa3.jpg'),
              _buildActivityImage('img/lensa4.jpg'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActivityImage(String imagePath) {
    return Expanded(
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
