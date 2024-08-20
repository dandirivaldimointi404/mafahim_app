import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mafahim_app/app/modules/home/views/home_view.dart';
import 'package:mafahim_app/app/modules/keranjang/views/keranjang_view.dart';
import 'package:mafahim_app/app/modules/produk/views/produk_view.dart';
import 'package:mafahim_app/app/modules/profile/views/profile_view.dart';
import '../controllers/main_menu_controller.dart';

class MainMenuView extends StatelessWidget {
  const MainMenuView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainMenuController>(
      builder: (controller) {
        return Scaffold(
          body: SafeArea(
            child: IndexedStack(
              index: controller.tabIndex.value,
              children: const [
                HomeView(),
                ProdukView(),
                KeranjangView(),
                ProfileView(),
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            unselectedItemColor: const Color(0xFF1B1B1B),
            selectedItemColor: Colors.black,
            onTap: (index) => controller.changeTabIndex(index),
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
              _bottomNavigationBarItemWithBadge(
                icon: Icons.shopping_cart,
                label: 'Keranjang',
                badgeCount: controller.cartItemCount.value,
              ),
              _bottomNavigationBarItem(
                icon: Icons.person,
                label: 'Profile',
              ),
            ],
          ),
        );
      },
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

  BottomNavigationBarItem _bottomNavigationBarItemWithBadge({
    required IconData icon,
    required String label,
    required int badgeCount,
  }) {
    return BottomNavigationBarItem(
      icon: Stack(
        clipBehavior: Clip.none,
        children: [
          Icon(icon),
          if (badgeCount > 0) Positioned(
            right: 0,
            top: 0,
            child: Container(
              padding: const EdgeInsets.all(2.0),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              constraints: BoxConstraints(
                minWidth: 16,
                minHeight: 16,
              ),
              child: Center(
                child: Text(
                  badgeCount.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      label: label,
    );
  }
}
