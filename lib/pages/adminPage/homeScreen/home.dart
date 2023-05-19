import 'package:ecommerce_sneaker/constants/admin/const.dart';
import 'package:ecommerce_sneaker/controllers/admin/home_controller.dart';
import 'package:ecommerce_sneaker/pages/adminPage/homeScreen/dashboard_screen.dart';
import 'package:ecommerce_sneaker/pages/adminPage/homeScreen/ordersScreen/orders_screen.dart';
import 'package:ecommerce_sneaker/pages/adminPage/homeScreen/productsScreen/products_screen.dart';
import 'package:ecommerce_sneaker/pages/adminPage/homeScreen/settingsScreen/profile_screen.dart';
import 'package:ecommerce_sneaker/pages/adminPage/homeScreen/usersScreen/user_screen.dart';
import 'package:ecommerce_sneaker/widgets/admin/text_style.dart';
import 'package:get/get.dart';
class HomeAdmin extends StatelessWidget {
  const HomeAdmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());
    var navScreens = [
      const DashboardScreen(),
      const ProductsScreen(),
      const OrdersScreen(),
      const UserScreen(),
      const ProfileScreen()

    ];

    var bottomNavbar = [
      const BottomNavigationBarItem(icon: Icon(Icons.home), label: dashboard),
      const BottomNavigationBarItem(icon: ImageIcon(NetworkImage(icProduct)), label: products ),
      const BottomNavigationBarItem(icon: ImageIcon(NetworkImage(icOrder)), label: orders ),
      const BottomNavigationBarItem(icon: ImageIcon(NetworkImage(icUser)), label: usersTitle ),
      const BottomNavigationBarItem(icon: ImageIcon(NetworkImage(icGeneralSetting)), label: settings ),

    ];
    return Scaffold(
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   title: boldText(text: dashboard, color: fontGrey, size: 18.0),
      // ),
      bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            onTap: (index) {
              controller.navIndex.value = index;
            },
            currentIndex: controller.navIndex.value,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: primaryColor,
            // selectedItemColor: purpleColor,
            unselectedItemColor: darkGrey,
            items: bottomNavbar,
          )
      ),
      body: Obx(
          () => Column(
            children: [
              Expanded(
                child: navScreens.elementAt(controller.navIndex.value),
              )
            ],
          )
      ),
    );
  }
}
