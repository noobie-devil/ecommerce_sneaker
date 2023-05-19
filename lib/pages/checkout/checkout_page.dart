import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_sneaker/constants/fonts.dart';
import 'package:ecommerce_sneaker/controllers/checkout_controller.dart';
import 'package:ecommerce_sneaker/pages/my_address/my_address_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';

class CheckoutPage extends StatelessWidget {
  CheckoutPage({Key? key}) : super(key: key);

  final CheckoutController checkoutController = Get.put(CheckoutController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Builder(
            builder: (context) => IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios_new)),
          ),
          title: const Center(
            child: Text("Checkout"),
          ),
          actions: [
            Opacity(
              opacity: 0,
              child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.more_horiz,
                    size: 20,
                  )),
            )
          ],
        ),
        body: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      child: Ink(
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.shade800, blurRadius: 5),
                              const BoxShadow(
                                  color: Colors.white,
                                  blurRadius: 5,
                                  offset: Offset(0, 5))
                            ]),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  child: MyAddressPage()
                                )
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 15.0),
                            child: CustomPaint(
                              painter: DashedLinePainter(),
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: ListTile(
                                  leading: const Icon(
                                    Icons.location_on_outlined,
                                    size: 25,
                                    color: Colors.blueGrey,
                                  ),
                                  title: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        flex: 10,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8.0),
                                              child: Text(
                                                "Delivery Address",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors
                                                        .blueGrey.shade800,
                                                    fontSize: 14),
                                              ),
                                            ),
                                            Obx(() => Text(
                                                "${checkoutController.defaultAddress.value?.fullName} | ${checkoutController.defaultAddress.value?.phoneNumber}",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(fontSize: 14),
                                              ),
                                            ),
                                            Obx(() => Text(
                                                "${checkoutController.defaultAddress.value?.address}",
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(fontSize: 14),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: const Icon(
                                                Icons.chevron_right_outlined)),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 4, bottom: 4),
                      height: Get.height * 0.15,
                      decoration: BoxDecoration(color: Colors.grey.shade300),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: CachedNetworkImage(
                                  imageUrl:
                                      "https://sneakerdaily.vn/wp-content/uploads/2021/04/Giay-nam-Puma-Suede-Classic-Castor-%E2%80%98Gray-365347-05.jpg.webp"),
                            ),
                          ),
                          Expanded(
                            flex: 7,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const AutoSizeText(
                                  "Giày nam Puma Suede Classic Castor ‘Gray’ 365347-05",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  minFontSize: 16,
                                ),
                                AutoSizeText(
                                  "Brand: Puma",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  minFontSize: 14,
                                  style: TextStyle(color: Colors.grey.shade800),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: const [
                                    AutoSizeText(
                                      "\$100.1",
                                      minFontSize: 16,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: 8.0),
                                      child: AutoSizeText(
                                        "x2",
                                        minFontSize: 16,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 4, bottom: 4),
                      height: Get.height * 0.15,
                      decoration: BoxDecoration(color: Colors.grey.shade300),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: CachedNetworkImage(
                                  imageUrl:
                                      "https://sneakerdaily.vn/wp-content/uploads/2021/04/Giay-nam-Puma-Suede-Classic-Castor-%E2%80%98Gray-365347-05.jpg.webp"),
                            ),
                          ),
                          Expanded(
                            flex: 7,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const AutoSizeText(
                                  "Giày nam Puma Suede Classic Castor ‘Gray’ 365347-05",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  minFontSize: 16,
                                ),
                                AutoSizeText(
                                  "Brand: Puma",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  minFontSize: 14,
                                  style: TextStyle(color: Colors.grey.shade800),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: const [
                                    AutoSizeText(
                                      "\$100.1",
                                      minFontSize: 16,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: 8.0),
                                      child: AutoSizeText(
                                        "x2",
                                        minFontSize: 16,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 4, bottom: 4),
                      height: Get.height * 0.15,
                      decoration: BoxDecoration(color: Colors.grey.shade300),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: CachedNetworkImage(
                                  imageUrl:
                                      "https://sneakerdaily.vn/wp-content/uploads/2021/04/Giay-nam-Puma-Suede-Classic-Castor-%E2%80%98Gray-365347-05.jpg.webp"),
                            ),
                          ),
                          Expanded(
                            flex: 7,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const AutoSizeText(
                                  "Giày nam Puma Suede Classic Castor ‘Gray’ 365347-05",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  minFontSize: 16,
                                ),
                                AutoSizeText(
                                  "Brand: Puma",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  minFontSize: 14,
                                  style: TextStyle(color: Colors.grey.shade800),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: const [
                                    AutoSizeText(
                                      "\$100.1",
                                      minFontSize: 16,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: 8.0),
                                      child: AutoSizeText(
                                        "x2",
                                        minFontSize: 16,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: Get.height * 0.08,
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(color: Colors.grey.shade800, blurRadius: 5)
                    ]),
                    width: double.infinity,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          flex: 7,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AutoSizeText(
                                  "Total payment",
                                  minFontSize: 16,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey.shade900,
                                  ),
                                ),
                                const AutoSizeText(
                                  "\$100.1",
                                  minFontSize: 19,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFFFD725A),
                                      fontFamily: gilroySemibold),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.zero)),
                            child: const AutoSizeText(
                              "Order",
                              minFontSize: 20,
                              style: TextStyle(fontFamily: gilroySemibold),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    final paintWithFirstColor = Paint()
      ..color = Colors.blueGrey
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.square;

    final paintWithSecondColor = Paint()
      ..color = Colors.redAccent
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.square;

    const dashWidth = 30;
    const dashSpace = 15;
    double startX = 0;
    int count = 1;
    while (startX < size.width) {
      if (count % 2 == 0) {
        canvas.drawLine(Offset(startX, size.height),
            Offset(startX + dashWidth, size.height), paintWithSecondColor);
      } else {
        canvas.drawLine(Offset(startX, size.height),
            Offset(startX + dashWidth, size.height), paintWithFirstColor);
      }
      startX += dashWidth + dashSpace;
      count++;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}
