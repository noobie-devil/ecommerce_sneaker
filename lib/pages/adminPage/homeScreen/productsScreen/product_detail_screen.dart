import 'package:ecommerce_sneaker/constants/admin/const.dart';
import 'package:ecommerce_sneaker/pages/adminPage/homeScreen/ordersScreen/order_detail_screen.dart';
import 'package:ecommerce_sneaker/service/admin/store_service.dart';
import 'package:ecommerce_sneaker/widgets/admin/appbar_widget.dart';
import 'package:ecommerce_sneaker/widgets/admin/dashboard_button.dart';
import 'package:ecommerce_sneaker/widgets/admin/text_style.dart';
import 'package:intl/intl.dart' as intl;
import 'package:get/get.dart';

class ProductDetailScreen extends StatelessWidget {
  final dynamic data;
  const ProductDetailScreen({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: darkGrey,),
          onPressed: () {
            Get.back();
          },
        ),
        title: boldText(text: data['product_name'], size: 16.0, color: fontGrey),
      ),
      
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VxSwiper.builder(
              autoPlay: true,
              height: 350,
              itemCount: 1,
              aspectRatio: 16 / 9,
              viewportFraction: 1.0,
              itemBuilder: (context, index) {
                return Image.network(
                    data['image_path'],
                  width: double.infinity,
                  fit: BoxFit.cover,
                );
              },
            ),
            10.heightBox,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  boldText(text: data['product_name'], color: fontGrey, size: 16.0),
                  10.heightBox,
                  Row(
                    children: [
                      boldText(text: "Nike", color: fontGrey, size: 16.0),

                    ],
                  ),
                  10.heightBox,
                  VxRating(
                    isSelectable: false,
                    onRatingUpdate: (value) {},
                    value: 5.0,
                    normalColor: textfieldGrey,
                    selectionColor: golden,
                    count: 5,
                    maxRating: 5,
                    size: 25,
                  ),
                  10.heightBox,
                  boldText(text: '\$${data['price']}', color: red, size: 16.0),
                  20.heightBox,

                  Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: boldText(text: 'Color', color: fontGrey),
                          ),
                          Row(
                            children: List.generate(
                              3,
                                (index) => VxBox().size(40, 40)
                                .roundedFull
                                .color(Vx.randomPrimaryColor)
                                .margin(const EdgeInsets.symmetric(horizontal: 4))
                                .make()
                                .onTap(() { }),
                            ),
                          ),
                        ],
                      ),

                      10.heightBox,

                      //quantity row
                      Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: boldText(text: 'Quantity', color: fontGrey),
                          ),
                          normalText(text: '20 items', color: fontGrey)
                        ],
                      ),
                    ],
                  ).box.white.padding(EdgeInsets.all(8.0)).make(),

                  const Divider(),
                  20.heightBox,

                  boldText(text: 'Description', color: fontGrey),
                  10.heightBox,
                  normalText(text: "${data['product_description']}", color: fontGrey),
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}
