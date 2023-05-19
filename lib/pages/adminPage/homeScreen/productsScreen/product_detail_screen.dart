import 'package:ecommerce_sneaker/constants/admin/const.dart';
import 'package:ecommerce_sneaker/pages/adminPage/homeScreen/ordersScreen/order_detail_screen.dart';
import 'package:ecommerce_sneaker/widgets/admin/appbar_widget.dart';
import 'package:ecommerce_sneaker/widgets/admin/dashboard_button.dart';
import 'package:ecommerce_sneaker/widgets/admin/text_style.dart';
import 'package:intl/intl.dart' as intl;
import 'package:get/get.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({Key? key}) : super(key: key);

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
        title: boldText(text: 'Product Detail', size: 16.0, color: fontGrey),
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
                return Image.asset(
                    'assets/shoes_1.png',
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
                  boldText(text: 'Product name', color: fontGrey, size: 16.0),
                  10.heightBox,
                  Row(
                    children: [
                      boldText(text: 'Brand', color: fontGrey, size: 16.0),

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
                  boldText(text: '\$300.50', color: red, size: 16.0),
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
                  normalText(text: 'Description of this item...', color: fontGrey),
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}
