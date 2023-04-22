import 'package:ecommerce_sneaker/pages/home/cart_screen.dart';
import "package:ecommerce_sneaker/constants/colors.dart";
import 'package:ecommerce_sneaker/pages/home/shop_screen.dart';
import "package:ecommerce_sneaker/widgets/common/bottom_nav_bar.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:flutter_zoom_drawer/config.dart";
import "package:flutter_zoom_drawer/flutter_zoom_drawer.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:page_transition/page_transition.dart";

import '../../data.dart';
import '../details/details_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        // người dùng chưa đăng nhập
        print('NOT Auth');
      } else {
        // người dùng đã đăng nhập
        print(user);
      }
    });
  }
  final drawerZoomController = ZoomDrawerController();

  int _selectedIndex = 0;

  void navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [const ShopScreen(), const CartScreen()];

  List<Widget> buildCategories() {
    return Data.generateCategories()
        .map((e) => Container(
              padding: const EdgeInsets.only(left: 15, bottom: 10),
              child: ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(
                        e.id == 1 ? Colors.white : const Color(0xff365b6d)),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        e.id == 1 ? const Color(0xff8c52ff) : Colors.white),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          color: MyColors.myBlack,
                          child: Image.asset(e.image),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        e.title,
                        style: const TextStyle(fontSize: 14),
                      )
                    ],
                  ),
                ),
              ),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Padding(
                  padding: EdgeInsets.only(right: 12.0),
                  child: Icon(
                    Icons.menu,
                    color: Colors.black,
                  ))),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      drawer: Drawer(
        backgroundColor: Colors.grey[900],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const DrawerHeader(
                    child: Icon(
                  Icons.store,
                  color: Colors.white,
                  size: 100,
                )),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Divider(
                    color: Colors.grey[800],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 25),
                  child: ListTile(
                    leading: Icon(Icons.home, color: Colors.white),
                    title: Text(
                      'Home',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 25),
                  child: ListTile(
                    leading: Icon(Icons.info, color: Colors.white),
                    title: Text(
                      'About',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(left: 25, bottom: 25),
              child: ListTile(
                leading: Icon(Icons.logout, color: Colors.white),
                title: Text(
                  'Logout',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.grey[300],
      bottomNavigationBar:
          MyBottomNavBar(onTabChange: (index) => navigateBottomBar(index)),
      body: _pages[_selectedIndex],
    ));

  }
}
