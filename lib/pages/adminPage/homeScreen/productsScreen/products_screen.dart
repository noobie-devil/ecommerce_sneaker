import 'package:ecommerce_sneaker/constants/admin/const.dart';
import 'package:ecommerce_sneaker/pages/adminPage/homeScreen/productsScreen/add_product_screen.dart';
import 'package:ecommerce_sneaker/pages/adminPage/homeScreen/productsScreen/product_detail_screen.dart';
import 'package:ecommerce_sneaker/widgets/admin/appbar_widget.dart';
import 'package:ecommerce_sneaker/widgets/admin/dashboard_button.dart';
import 'package:ecommerce_sneaker/widgets/admin/text_style.dart';
import 'package:intl/intl.dart' as intl;
import 'package:get/get.dart';
class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(()=>AddProductScreen());
          },
          child: Icon(Icons.add),
        ),
        appBar: appbarWidget(products),
        body: Padding(
          padding: EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                15,
                (index) => ListTile(
                  onTap: () {
                    Get.to(()=>ProductDetailScreen());
                  },
                  leading: Image.asset(
                    'assets/shoes_1.png',
                    width: 100,
                    height: 100,
                    fit: BoxFit.contain,
                  ),
                  title: boldText(text: 'Product title', color: darkGrey),
                  subtitle: Row(
                      children: [
                        normalText(
                          text: 'description here',
                          color: darkGrey
                        ),
                      10.widthBox,
                        boldText(text: 'Featured', color: green),
                    ],
                  ),
                  trailing: VxPopupMenu(
                    arrowSize: 0.0,
                    clickType: VxClickType.singleClick,
                    child: Icon(Icons.more_vert_rounded),
                    menuBuilder: () => Column(
                      children: List.generate(
                          popupMenuTitles.length,
                          (index) => Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  children: [
                                    Icon(popupMenuIcons[index]),
                                    10.widthBox,
                                    normalText(
                                        text: popupMenuTitles[index],
                                        color: darkGrey)
                                  ],
                                ).onTap(() {}),
                              )),
                    ).box.white.rounded.width(200).make(),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
