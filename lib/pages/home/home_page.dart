import "package:auto_size_text/auto_size_text.dart";
import "package:ecommerce_sneaker/controllers/product_controller.dart";
import "package:ecommerce_sneaker/controllers/wish_list_controller.dart";
import 'package:ecommerce_sneaker/pages/home/cart_screen.dart';
import "package:ecommerce_sneaker/constants/colors.dart";
import 'package:ecommerce_sneaker/pages/home/shop_screen.dart';
import "package:ecommerce_sneaker/pages/home/wish_list_screen.dart";
import "package:ecommerce_sneaker/utils.dart";
import "package:ecommerce_sneaker/widgets/common/bottom_nav_bar.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "../../controllers/cart_controller.dart";
import '../../data.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final CartController cartController =
      Get.put(CartController());
  final ProductController productController =
      Get.put(ProductController());
  final WishListController wishListController =
      Get.put(WishListController());
  final _selectedIndex = 0.obs;

  void navigateBottomBar(int index) {
    _selectedIndex.value = index;
  }

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
    final List<Widget> pages = [
      ShopScreen(productController: productController),
      CartScreen(
        productController: productController,
        cartController: cartController,
      ),
      WishListScreen(
          productController: productController,
          wishListController: wishListController)
    ];

    return SafeArea(
        child: Scaffold(
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
        backgroundColor: Colors.grey.shade900,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                const DrawerHeader(
                    // child: Image.asset(
                    //     "assets/logo_in_dark_surface.png",
                    //   fit: BoxFit.fitWidth,
                    //   width: 400,
                    // ),
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
                Padding(
                    padding: const EdgeInsets.only(
                        top: 25, left: 25, bottom: 10, right: 25),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.grey.shade800,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12))),
                      child: const Center(
                        child: ListTile(
                          leading: Icon(
                            Icons.home,
                            color: Colors.white,
                          ),
                          title: Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: AutoSizeText('Home',
                                minFontSize: 16,
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ),
                    )),
                Padding(
                    padding: const EdgeInsets.only(left: 25, right: 25),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.grey.shade900,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          elevation: 0),
                      child: const Center(
                        child: ListTile(
                          leading: Icon(
                            Icons.info,
                            color: Colors.white,
                          ),
                          title: Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: AutoSizeText('About',
                                minFontSize: 16,
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ),
                    )),
              ],
            ),
            Container(
                padding: const EdgeInsets.only(left: 25, bottom: 25, right: 25),
                child: ElevatedButton(
                  onPressed: () async {
                    await signOut();
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.grey.shade800,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  child: const Center(
                    child: ListTile(
                      leading: Icon(
                        Icons.logout,
                        color: Colors.white,
                      ),
                      title: Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: AutoSizeText('Logout',
                            minFontSize: 16,
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ),
                )
                // child: ListTile(
                //   leading: Icon(Icons.logout, color: Colors.white),
                //   title: Text(
                //     'Logout',
                //     style: TextStyle(color: Colors.white),
                //   ),
                // ),
                ),
          ],
        ),
      ),
      backgroundColor: Colors.grey[300],
      bottomNavigationBar:
          MyBottomNavBar(onTabChange: (index) => navigateBottomBar(index)),
      body: Obx(() => pages[_selectedIndex.value]),
    ));
  }
}

// class _HomePageState extends State<HomePage> {
//   late final CartController cartController;
//   late final ProductController productController;
//
//   @override
//   void initState() {
//     super.initState();
//     cartController controller = Get.put(CartController(), permanent: true);
//
//     // FirebaseAuth.instance.authStateChanges().listen((User? user) {
//     //   if (user == null) {
//     //     // người dùng chưa đăng nhập
//     //     print('NOT Auth');
//     //   } else {
//     //     // người dùng đã đăng nhập
//     //     print(user);
//     //   }
//     // });
//
//   }
//
//   final _selectedIndex = 0.obs;
//
//   void navigateBottomBar(int index) {
//     _selectedIndex.value = index;
//   }
//
//
//   List<Widget> buildCategories() {
//     return Data.generateCategories()
//         .map((e) => Container(
//               padding: const EdgeInsets.only(left: 15, bottom: 10),
//               child: ElevatedButton(
//                 onPressed: () {},
//                 style: ButtonStyle(
//                     foregroundColor: MaterialStateProperty.all<Color>(
//                         e.id == 1 ? Colors.white : const Color(0xff365b6d)),
//                     backgroundColor: MaterialStateProperty.all<Color>(
//                         e.id == 1 ? const Color(0xff8c52ff) : Colors.white),
//                     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                         RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(30)))),
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Row(
//                     children: [
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(30),
//                         child: Container(
//                           color: MyColors.myBlack,
//                           child: Image.asset(e.image),
//                         ),
//                       ),
//                       const SizedBox(
//                         width: 10,
//                       ),
//                       Text(
//                         e.title,
//                         style: const TextStyle(fontSize: 14),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ))
//         .toList();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final List<Widget> pages = [ShopScreen(), CartScreen(), WishListScreen()];
//
//     return SafeArea(child: Scaffold(
//       appBar: AppBar(
//         leading: Builder(
//           builder: (context) => IconButton(
//               onPressed: () {
//                 Scaffold.of(context).openDrawer();
//               },
//               icon: const Padding(
//                   padding: EdgeInsets.only(right: 12.0),
//                   child: Icon(
//                     Icons.menu,
//                     color: Colors.black,
//                   ))),
//         ),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//       ),
//       drawer: Drawer(
//         backgroundColor: Colors.grey.shade900,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Column(
//               children: [
//                 const DrawerHeader(
//                   // child: Image.asset(
//                   //     "assets/logo_in_dark_surface.png",
//                   //   fit: BoxFit.fitWidth,
//                   //   width: 400,
//                   // ),
//                   child: Icon(
//                     Icons.store,
//                     color: Colors.white,
//                     size: 100,
//                   )
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 25.0),
//                   child: Divider(
//                     color: Colors.grey[800],
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 25,left: 25, bottom: 10, right: 25),
//                   child: ElevatedButton(
//                     onPressed: () {},
//                     style: ElevatedButton.styleFrom(
//                         foregroundColor: Colors.white,
//                         backgroundColor: Colors.grey.shade800,
//                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
//                     ),
//                     child: const Center(
//                       child: ListTile(
//                         leading: Icon(Icons.home, color: Colors.white,),
//                         title: Padding(
//                           padding: EdgeInsets.only(left: 20),
//                           child: AutoSizeText(
//                               'Home',
//                               minFontSize: 16,
//                               style: TextStyle(color: Colors.white)
//                           ),
//                         ),
//                       ),
//                     ),
//                   )
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 25, right: 25),
//                   child: ElevatedButton(
//                     onPressed: () {},
//                     style: ElevatedButton.styleFrom(
//                         foregroundColor: Colors.white,
//                         backgroundColor: Colors.grey.shade900,
//                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                         elevation: 0
//                     ),
//                     child: const Center(
//                       child: ListTile(
//                         leading: Icon(Icons.info, color: Colors.white,),
//                         title: Padding(
//                           padding: EdgeInsets.only(left: 20),
//                           child: AutoSizeText(
//                               'About',
//                               minFontSize: 16,
//                               style: TextStyle(color: Colors.white)
//                           ),
//                         ),
//                       ),
//                     ),
//                   )
//                 ),
//               ],
//             ),
//             Container(
//               padding: const EdgeInsets.only(left: 25, bottom: 25, right: 25),
//               child: ElevatedButton(
//                 onPressed: () async {
//                   await signOut();
//                 },
//                 style: ElevatedButton.styleFrom(
//                   foregroundColor: Colors.white,
//                   backgroundColor: Colors.grey.shade800,
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
//                 ),
//                 child: const Center(
//                   child: ListTile(
//                     leading: Icon(Icons.logout, color: Colors.white,),
//                     title: Padding(
//                       padding: EdgeInsets.only(left: 20),
//                       child: AutoSizeText(
//                           'Logout',
//                           minFontSize: 16,
//                           style: TextStyle(color: Colors.white)
//                       ),
//                     ),
//                   ),
//                 ),
//               )
//               // child: ListTile(
//               //   leading: Icon(Icons.logout, color: Colors.white),
//               //   title: Text(
//               //     'Logout',
//               //     style: TextStyle(color: Colors.white),
//               //   ),
//               // ),
//             ),
//           ],
//         ),
//       ),
//       backgroundColor: Colors.grey[300],
//       bottomNavigationBar:
//           MyBottomNavBar(onTabChange: (index) => navigateBottomBar(index)),
//       body: Obx(() => pages[_selectedIndex.value]),
//     ));
//
//   }
// }
