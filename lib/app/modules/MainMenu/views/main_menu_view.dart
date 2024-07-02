import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mafahim_app/app/modules/home/views/home_view.dart';
import 'package:mafahim_app/app/modules/produk/views/produk_view.dart';
import 'package:mafahim_app/app/modules/profile/views/profile_view.dart';
import '../controllers/main_menu_controller.dart';

class MainMenuView extends StatelessWidget {
  const MainMenuView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainMenuController>(
      builder: (controller) => Scaffold(
        body: SafeArea(
          child: IndexedStack(
            index: controller.tabIndex.value,
            children: const [
              HomeView(),
              ProdukView(),
              ProfileView(),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: const Color(0xFF1B1B1B),
          selectedItemColor: Colors.black,
          onTap: controller.changeTabIndex,
          currentIndex: controller.tabIndex.value,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          items: [
            _bottomNavigationBarItem(
              icon: Icons.home,
              label: 'Home',
            ),
            _bottomNavigationBarItem(
              icon: Icons.shopping_bag,
              label: 'Produk',
            ),
            _bottomNavigationBarItem(
              icon: Icons.person,
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem _bottomNavigationBarItem({
    required IconData icon,
    required String label,
  }) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: label,
    );
  }
}
