import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mafahim_app/app/routes/app_pages.dart';
import 'package:sp_util/sp_util.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Stack(
              children: [
                const CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage('https://www.example.com/profile.jpg'), // Replace with actual image URL
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.edit, color: Colors.white),
                      onPressed: () {
                        // Add your onPressed logic here
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            buildListTitle(Icons.person, 'Nama Pengguna', '${SpUtil.getString("name")}'),
            const SizedBox(height: 10),
            buildListTitle(Icons.email, 'Email', '${SpUtil.getString("username")}'),
            const SizedBox(height: 10),
            buildListTitle(Icons.phone, 'Nomor Telepon', '${SpUtil.getString("no_hp")}'),
            const SizedBox(height: 10),
            buildListTitle(Icons.location_on, 'Alamat', '${SpUtil.getString("alamat")}'),
              const SizedBox(height: 30),
            buildLogoutButton(context),
          ],
        ),
      ),
    );
  }

  Widget buildListTitle(IconData icon, String title, String subtitle) {
    return ListTile(
      leading: Icon(icon, color: Colors.green),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(subtitle),
      onTap: () {
        // Add your onTap logic here
      },
    );
  }
  
  buildLogoutButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // Add your logout logic here
          SpUtil.clear();
          Get.offAllNamed(Routes.LOGIN);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: const Text(
          'Logout',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal, color: Colors.white),
        ),
      ),
    );
  }
}
