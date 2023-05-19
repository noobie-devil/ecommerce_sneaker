import 'package:auto_size_text/auto_size_text.dart';
import 'package:ecommerce_sneaker/controllers/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:badges/badges.dart' as badges;


class MyBottomNavBar extends StatelessWidget {

  void Function(int)? onTabChange;

  MyBottomNavBar({super.key, required this.onTabChange});

  final CartController _cartController = Get.put(CartController());
  final _selectedIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: GNav(
        color: Colors.grey[400],
        activeColor: Colors.grey.shade700,
        padding: const EdgeInsets.all(15),
        tabActiveBorder: Border.all(color: Colors.white),
        tabBackgroundColor: Colors.grey.shade100,
        mainAxisAlignment: MainAxisAlignment.center,
        tabBorderRadius: 16,
        onTabChange: (value) {
          onTabChange!(value);
          _selectedIndex.value = value;
        },
        gap: 8,
        tabs: [
          const GButton(
            icon: Icons.home,
            text: "Shop",
          ),
          GButton(
            icon: Icons.shopping_bag_rounded,
            text: "Cart",
            leading: _cartController.cartTotalQuantity == 0 ? null : badges.Badge(
              showBadge: true,
              ignorePointer: false,
              onTap: (){},
              badgeContent: Obx(() => AutoSizeText(
                _cartController.cartTotalQuantity.toString(),
                style: const TextStyle(
                    color: Colors.white
                ),
              ),
              ),
              badgeAnimation: const badges.BadgeAnimation.slide(
                animationDuration: Duration(milliseconds: 500),
                colorChangeAnimationDuration: Duration(milliseconds: 500),
                loopAnimation: false,
                curve: Curves.fastOutSlowIn,
                colorChangeAnimationCurve: Curves.easeInCubic,
              ),
              badgeStyle: const badges.BadgeStyle(
                  shape: badges.BadgeShape.circle,
                  badgeColor: Colors.redAccent,
                  elevation: 0
              ),
              child: Icon(Icons.shopping_bag_rounded, color: _selectedIndex.value == 1 ? Colors.grey[400] : Colors.grey.shade700,),
            ),
          ),
          const GButton(
            icon: FontAwesomeIcons.heart,
            text: "Wishlist",
          )
        ],
      ),
    );
  }

}