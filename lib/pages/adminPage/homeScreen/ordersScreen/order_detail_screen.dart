import 'package:ecommerce_sneaker/constants/admin/const.dart';
import 'package:ecommerce_sneaker/pages/adminPage/homeScreen/ordersScreen/component/order_place.dart';
import 'package:ecommerce_sneaker/widgets/admin/appbar_widget.dart';
import 'package:ecommerce_sneaker/widgets/admin/dashboard_button.dart';
import 'package:ecommerce_sneaker/widgets/admin/our_button.dart';
import 'package:ecommerce_sneaker/widgets/admin/text_style.dart';
import 'package:intl/intl.dart' as intl;
import 'package:get/get.dart';

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({Key? key}) : super(key: key);

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
        title: boldText(text: orderDetails, size: 16.0, color: fontGrey),
      ),

      bottomNavigationBar: SizedBox(
        height: 60,
        width: context.screenWidth,
        child: ourButton(title: 'Confirm Order', onPress: () {}, color: green),
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              //order delivery status section
              Visibility(
                // visible: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    boldText(text: 'Order Status', color: fontGrey, size: 16.0),
                    SwitchListTile(
                      activeColor: green,
                        value: true,
                        onChanged: (value){},
                      title: boldText(text: 'Placed', color: fontGrey),
                    ),

                    SwitchListTile(
                      activeColor: green,
                      value: false,
                      onChanged: (value){},
                      title: boldText(text: 'Confirmed', color: fontGrey),
                    ),

                    SwitchListTile(
                      activeColor: green,
                      value: false,
                      onChanged: (value){},
                      title: boldText(text: 'on Delivery', color: fontGrey),
                    ),

                    SwitchListTile(
                      activeColor: green,
                      value: false,
                      onChanged: (value){},
                      title: boldText(text: 'Delivered', color: fontGrey),
                    )
                  ],
                ).box
                    .padding(const EdgeInsets.all(8.0))
                    .outerShadow.white.border(color: lightGrey).make(),
              ),


              //Order detail Section
              Column(
                children: [
                  orderPlaceDetails(
                    d1: 'data-order-code',
                    d2: 'data-shipping-method',
                    title1: 'Order Code',
                    title2: 'Shipping Method',
                  ),
                  orderPlaceDetails(
                    d1: DateTime.now(),
                    d2: 'data-payment-method',
                    title1: 'Order Date',
                    title2: 'Payment Method',
                  ),
                  orderPlaceDetails(
                    d1: "Unpaid",
                    d2: 'Order Placed',
                    title1: 'Payment Status',
                    title2: 'Delivery Status',
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //...
                            boldText(text: "Shipping Address", color: purpleColor),
                            'data-order-by-name'.text.make(),
                            'data-order-by-email'.text.make(),
                            'data-order-by-address'.text.make(),
                            'data-order-by-city'.text.make(),
                          ],
                        ),
                        SizedBox(
                          width: 130,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              boldText(text: 'Total Amount', color: purpleColor),
                              boldText(text: '\$45.000', color: red, size: 16.0),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ).box.outerShadow.white.border(color: lightGrey).make(),
              const Divider(),
              10.heightBox,
              boldText(text: 'Orderd Products', color: fontGrey, size: 16.0),
              10.heightBox,
              ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: List.generate(3, (index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      orderPlaceDetails(
                        title1: 'data-order-title',
                        title2: 'data-order-tprice',
                        d1: 'data-orders-qty',
                        d2: 'refundable'
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Container(
                          width: 30,
                          height: 20,
                          color: purpleColor,
                        ),
                      ),
                      const Divider(),
                    ],
                  );
                }).toList(),
              ).box.outerShadow.white.margin(const EdgeInsets.only(bottom: 4)).make(),
              20.heightBox,

            ],
          ),
        ),
      ),
    );
  }
}
