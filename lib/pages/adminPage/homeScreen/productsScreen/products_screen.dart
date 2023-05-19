import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_sneaker/constants/admin/const.dart';
import 'package:ecommerce_sneaker/pages/adminPage/homeScreen/productsScreen/add_product_screen.dart';
import 'package:ecommerce_sneaker/pages/adminPage/homeScreen/productsScreen/product_detail_screen.dart';
import 'package:ecommerce_sneaker/service/admin/store_service.dart';
import 'package:ecommerce_sneaker/widgets/admin/appbar_widget.dart';
import 'package:ecommerce_sneaker/widgets/admin/dashboard_button.dart';
import 'package:ecommerce_sneaker/widgets/admin/loading_indicator.dart';
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
        body: StreamBuilder(
          stream: StoreService.getProducts(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            if(!snapshot.hasData){
              return loadingIndicator();
            }else{
              var data = snapshot.data!.docs;
              return Padding(
                padding: EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                      data.length,
                          (index) => ListTile(
                        onTap: () {
                          Get.to(()=>ProductDetailScreen(data: data[index],));
                        },
                        leading: Image.network(
                          "${data[index]['image_path']}",
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                        title: boldText(text: '${data[index]['product_name']}', color: darkGrey),
                        subtitle: Row(
                          children: [
                            normalText(
                                text: '\$${data[index]['price']}',
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
              );
            }
          },
        ),

    );
  }
}
