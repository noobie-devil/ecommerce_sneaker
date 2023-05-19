import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_sneaker/controllers/cart_controller.dart';
import 'package:ecommerce_sneaker/controllers/product_detail_controller.dart';
import 'package:ecommerce_sneaker/models/models.dart';
import 'package:ecommerce_sneaker/widgets/bottom_sheet.dart';
import 'package:ecommerce_sneaker/widgets/common/shake_transition.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart' as badges;
import '../../constants/fonts.dart';
import '../../widgets/common/fast_cart_widget.dart';

class DetailsPage extends StatelessWidget {
  DetailsPage({Key? key, required this.product}) : super(key: key);
  final Product product;
  final ProductDetailController productDetailController = Get.put(ProductDetailController(), permanent: false);
  final CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    productDetailController.updateProduct(product);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        elevation: 0,
        actions: [
          GestureDetector(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FastCart(),
                )),
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Center(
                child: badges.Badge(
                  showBadge: true,
                  ignorePointer: false,
                  onTap: (){},
                  badgeContent: Obx(() => AutoSizeText(
                      cartController.cartTotalQuantity.toString(),
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
                  child: const FaIcon(FontAwesomeIcons.cartShopping, color: Colors.white,),
                ),
              ),
            ),
          )

          // IconButton(
          //   onPressed: () {},
          //   icon: const Icon(
          //     Icons.more_horiz,
          //     size: 30,
          //   ),
          // )
        ],
      ),
      body: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: const ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  width: double.infinity,
                  height: Get.height * 0.4,
                  alignment: Alignment.bottomRight,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15)),
                      boxShadow: [
                        BoxShadow(color: Colors.blueGrey.shade200, blurRadius: 30)
                      ]),
                  child: Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        PageView.builder(
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            return Center(
                                child: ShakeTransition(
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(15),
                                            bottomRight: Radius.circular(15)),
                                      ),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                        product.imagePath,
                                        fit: BoxFit.fitHeight,
                                        width: double.infinity,
                                      ),
                                    )));
                          },
                        ),
                        Positioned.fill(
                          child: Align(
                              alignment: Alignment.topRight,
                              child: ShakeTransition(
                                child: Row(
                                  children: [
                                    const Spacer(
                                      flex: 3,
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: 15),
                                        child: CachedNetworkImage(imageUrl: product.brand.brandImage),
                                      ),
                                    )
                                  ],
                                ),
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: ShakeTransition(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              AutoSizeText(
                                product.productName,
                                maxLines: 2,
                                minFontSize: 24,
                                style: const TextStyle(
                                    fontFamily: gilroySemibold,
                                    letterSpacing: 0.25),
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: ShakeTransition(
                            child: AutoSizeText(
                              "\$${product.price}",
                              minFontSize: 18,
                              style: const TextStyle(
                                letterSpacing: 0.25,
                                color: Color.fromRGBO(0, 0, 0, 0.6),
                                fontFamily: gilroySemibold,
                              ),
                              maxLines: 1,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Expanded(
                            flex: 1,
                            child: ShakeTransition(
                              child: AutoSizeText(
                                "Quantity: 100",
                                minFontSize: 18,
                                style: TextStyle(
                                    letterSpacing: 0.25,
                                    color: Color.fromRGBO(0, 0, 0, 0.6),
                                    fontFamily: gilroySemibold),
                                maxLines: 1,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: ShakeTransition(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      Future<void> future = showModalBottomSheet(
                                          backgroundColor: Colors.transparent,
                                          context: context,
                                          builder: (context) {
                                            return CustomBottomSheet(productDetailController: productDetailController,);
                                          },
                                      );
                                      future.then((value) => productDetailController.onClose());
                                    },
                                    icon: const FaIcon(FontAwesomeIcons.cartPlus,
                                        size: 15),
                                    label: const AutoSizeText(
                                      "Add To Cart",
                                      minFontSize: 18,
                                      style: TextStyle(
                                        fontFamily: gilroySemibold,
                                      ),
                                    ),
                                    style: ButtonStyle(
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(8))),
                                        padding: MaterialStateProperty.all(
                                            const EdgeInsets.all(15))),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                  color: Colors.grey,
                                  width: 1.5,
                                ))),
                        child: const AutoSizeText(
                          "Description:",
                          minFontSize: 20,
                          style: TextStyle(
                              fontFamily: gilroySemibold,
                              letterSpacing: 0.25,
                              color: Color.fromRGBO(0, 0, 0, 0.4)),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12.0),
                        child: AutoSizeText.rich(
                          TextSpan(
                              text:
                              "Puma Suede Classic Castor ‘Gray’  Cập nhật nhanh nhất lịch ra mắt của các mẫu giày mới nhất bằng cách theo dõi Sneaker Daily trên Facebook hoặc Instagram."),
                          minFontSize: 15,
                          style: TextStyle(
                            color: Color.fromRGBO(0, 0, 0, 0.6),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )

      ),
    );
  }
}

//
// class DetailScreen extends StatefulWidget {
//   const DetailScreen({Key? key, required this.product}) : super(key: key);
//
//   final Product product;
//
//   @override
//   State<DetailScreen> createState() => _DetailScreenState();
// }
//
// class _DetailScreenState extends State<DetailScreen> {
//   List<ImageProvider> imageList = [];
//   int _selectedIndex = 0;
//   int? _value;
//
//   static List<Color> colors = const [
//     Color(0xff29695D),
//     Color(0xff5B8EA3),
//     Color(0xff746A36),
//     Color(0xff2E2E2E)
//   ];
//
//   bool autoRotate = false;
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(
//             Icons.arrow_back_ios,
//           ),
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//         ),
//         elevation: 0,
//         actions: [
//           IconButton(
//             onPressed: () {},
//             icon: const Icon(
//               Icons.more_horiz,
//               size: 30,
//             ),
//           )
//         ],
//       ),
//       body: SafeArea(
//           child: SingleChildScrollView(
//         scrollDirection: Axis.vertical,
//         physics: const ClampingScrollPhysics(),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Container(
//               width: double.infinity,
//               height: Get.height * 0.4,
//               alignment: Alignment.bottomRight,
//               decoration: BoxDecoration(
//                   borderRadius: const BorderRadius.only(
//                       bottomLeft: Radius.circular(15),
//                       bottomRight: Radius.circular(15)),
//                   boxShadow: [
//                     BoxShadow(color: Colors.blueGrey.shade200, blurRadius: 30)
//                   ]),
//               child: Center(
//                 child: Stack(
//                   alignment: Alignment.center,
//                   children: [
//                     PageView.builder(
//                       itemCount: 3,
//                       itemBuilder: (context, index) {
//                         return Center(
//                             child: ShakeTransition(
//                                 child: Container(
//                           decoration: const BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.only(
//                                 bottomLeft: Radius.circular(15),
//                                 bottomRight: Radius.circular(15)),
//                           ),
//                           child: CachedNetworkImage(
//                             imageUrl:
//                                 "https://sneakerdaily.vn/wp-content/uploads/2021/04/Giay-nam-Puma-Suede-Classic-Castor-%E2%80%98Gray-365347-05.jpg",
//                             fit: BoxFit.fitHeight,
//                             width: double.infinity,
//                           ),
//                         )));
//                       },
//                     ),
//                     Positioned.fill(
//                       child: Align(
//                           alignment: Alignment.topRight,
//                           child: ShakeTransition(
//                             child: Row(
//                               children: [
//                                 const Spacer(
//                                   flex: 3,
//                                 ),
//                                 Expanded(
//                                   flex: 1,
//                                   child: Padding(
//                                     padding: const EdgeInsets.only(right: 15),
//                                     child: Image.asset("assets/puma_brand.png"),
//                                   ),
//                                 )
//                               ],
//                             ),
//                           )),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.all(12),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 10),
//                     child: ShakeTransition(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.stretch,
//                         children: const [
//                           AutoSizeText(
//                             "Giày Puma Suede Classic 21 ‘High Risk Red’ 374915-02",
//                             maxLines: 2,
//                             minFontSize: 24,
//                             style: TextStyle(
//                                 fontFamily: gilroySemibold,
//                                 letterSpacing: 0.25),
//                             overflow: TextOverflow.ellipsis,
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                   const Padding(
//                     padding: EdgeInsets.only(bottom: 10),
//                     child: Align(
//                       alignment: Alignment.topLeft,
//                       child: ShakeTransition(
//                         child: AutoSizeText(
//                           "\$${239.8}",
//                           minFontSize: 18,
//                           style: TextStyle(
//                             letterSpacing: 0.25,
//                             color: Color.fromRGBO(0, 0, 0, 0.6),
//                             fontFamily: gilroySemibold,
//                           ),
//                           maxLines: 1,
//                         ),
//                       ),
//                     ),
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       const Expanded(
//                         flex: 1,
//                         child: ShakeTransition(
//                           child: AutoSizeText(
//                             "Quantity: 100",
//                             minFontSize: 18,
//                             style: TextStyle(
//                                 letterSpacing: 0.25,
//                                 color: Color.fromRGBO(0, 0, 0, 0.6),
//                                 fontFamily: gilroySemibold),
//                             maxLines: 1,
//                           ),
//                         ),
//                       ),
//                       Expanded(
//                         flex: 1,
//                         child: ShakeTransition(
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               ElevatedButton.icon(
//                                 onPressed: () {
//                                   showModalBottomSheet(
//                                     backgroundColor: Colors.transparent,
//                                     context: context,
//                                     builder: (context) {
//                                       return CustomBottomSheet();
//                                     }
//                                   );
//                                 },
//                                 icon: const FaIcon(FontAwesomeIcons.cartPlus,
//                                     size: 15),
//                                 label: const AutoSizeText(
//                                   "Add To Cart",
//                                   minFontSize: 18,
//                                   style: TextStyle(
//                                     fontFamily: gilroySemibold,
//                                   ),
//                                 ),
//                                 style: ButtonStyle(
//                                     shape: MaterialStateProperty.all<
//                                             RoundedRectangleBorder>(
//                                         RoundedRectangleBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(8))),
//                                     padding: MaterialStateProperty.all(
//                                         const EdgeInsets.all(15))),
//                               )
//                             ],
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                   Container(
//                     width: double.infinity,
//                     padding: const EdgeInsets.symmetric(vertical: 12),
//                     decoration: const BoxDecoration(
//                         border: Border(
//                             bottom: BorderSide(
//                       color: Colors.grey,
//                       width: 1.5,
//                     ))),
//                     child: const AutoSizeText(
//                       "Description:",
//                       minFontSize: 20,
//                       style: TextStyle(
//                           fontFamily: gilroySemibold,
//                           letterSpacing: 0.25,
//                           color: Color.fromRGBO(0, 0, 0, 0.4)),
//                     ),
//                   ),
//                   const Padding(
//                     padding: EdgeInsets.symmetric(vertical: 12.0),
//                     child: AutoSizeText.rich(
//                       TextSpan(
//                           text:
//                               "Puma Suede Classic Castor ‘Gray’  Cập nhật nhanh nhất lịch ra mắt của các mẫu giày mới nhất bằng cách theo dõi Sneaker Daily trên Facebook hoặc Instagram."),
//                       minFontSize: 15,
//                       style: TextStyle(
//                         color: Color.fromRGBO(0, 0, 0, 0.6),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             )
//             // const Padding(
//             //   padding: EdgeInsets.only(bottom: 10),
//             //   child: AutoSizeText(
//             //     "Quantity: 100",
//             //     minFontSize: 18,
//             //     style: TextStyle(
//             //         letterSpacing: 0.25,
//             //         color: Color.fromRGBO(0, 0, 0, 0.6),
//             //         fontFamily: gilroySemibold
//             //     ),
//             //     maxLines: 1,
//             //   ),
//             // )
//
//             // const Spacer(flex: 1,)
//             // Expanded(
//             //   flex: 1,
//             //   child: Column(
//             //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             //     crossAxisAlignment: CrossAxisAlignment.stretch,
//             //     children: [
//             //       ShakeTransition(
//             //         child: Column(
//             //           crossAxisAlignment: CrossAxisAlignment.stretch,
//             //           children: const [
//             //             AutoSizeText(
//             //               "Giày Puma Suede Classic 21 ‘High Risk Red’ 374915-02",
//             //               maxLines: 2,
//             //               minFontSize: 20,
//             //               style: TextStyle(
//             //                 fontFamily: gilroySemibold,
//             //                 letterSpacing: 0.25
//             //               ),
//             //               overflow: TextOverflow.ellipsis,
//             //             ),
//             //             SizedBox(
//             //               height: 12,
//             //             ),
//             //             Text(
//             //               "\$${239.8}",
//             //               style: TextStyle(
//             //                   fontSize: 18,
//             //                   letterSpacing: 0.25,
//             //                   color: Color.fromRGBO(0, 0, 0, 0.6),
//             //                   fontFamily: gilroySemibold
//             //               ),
//             //             )
//             //           ],
//             //         ),
//             //       ),
//             //       const ShakeTransition(
//             //         axis: Axis.vertical,
//             //         child: Text(
//             //           "Description here",
//             //           style: TextStyle(
//             //               fontSize: 15,
//             //               fontFamily: gilroySemibold,
//             //               letterSpacing: 0.25,
//             //               color: Color.fromRGBO(0, 0, 0, 0.4)
//             //           ),
//             //         ),
//             //       ),
//             //       Row(
//             //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             //         children: [
//             //           ShakeTransition(
//             //             child: InkWell(
//             //               onTap: () {},
//             //               child: Container(
//             //                 decoration: BoxDecoration(
//             //                     color: const Color(0xFFF7F8FA),
//             //                     borderRadius: BorderRadius.circular(30)
//             //                 ),
//             //                 child: const FaIcon(FontAwesomeIcons.cartShopping, size: 22, color: Color(0xFFFD725A),),
//             //               ),
//             //             ),
//             //           ),
//             //           ShakeTransition(
//             //             child: InkWell(
//             //               onTap: () {
//             //                 showModalBottomSheet(
//             //                     backgroundColor: Colors.transparent,
//             //                     context: context,
//             //                     builder: (context) {
//             //                       return CustomBottomSheet();
//             //                     }
//             //                 );
//             //               },
//             //               child: Container(
//             //                 padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 70),
//             //                 decoration: BoxDecoration(
//             //                     color: const Color(0xFFFD725A),
//             //                     borderRadius: BorderRadius.circular(30)
//             //                 ),
//             //                 child: Text("Buy Now", style: TextStyle(
//             //                     fontSize: 17,
//             //                     fontWeight: FontWeight.w600,
//             //                     letterSpacing: 1,
//             //                     color: Colors.white.withOpacity(0.8)
//             //                 ),),
//             //               ),
//             //             ),
//             //           ),
//             //
//             //         ],
//             //       ),
//             //
//             //
//             //       // const ShakeTransition(
//             //       //   axis: Axis.vertical,
//             //       //   child: ButtonStates(),
//             //       // ),
//             //       const SizedBox(height: 20, )
//             //     ],
//             //   ),
//             // ),
//           ],
//         ),
//       )
//           // child: Column(
//           //   crossAxisAlignment: CrossAxisAlignment.start,
//           //   children: [
//           //     Expanded(
//           //       child: Container(
//           //         margin: const EdgeInsets.only(left: 12),
//           //         width: double.infinity,
//           //         decoration: BoxDecoration(
//           //             color: Colors.grey.shade300,
//           //             borderRadius: BorderRadius.circular(20)),
//           //         child: Center(
//           //           child: Stack(
//           //             alignment: Alignment.center,
//           //             children: [
//           //               ShakeTransition(
//           //                 child: Image.asset(
//           //                   "assets/nike_brand.png",
//           //                   color: const Color.fromRGBO(0, 0, 0, 0.2),
//           //                 ),
//           //               ),
//           //               PageView.builder(
//           //                 itemCount: 3,
//           //                 itemBuilder: (context, index) {
//           //                   return Center(
//           //                       child: ShakeTransition(
//           //                           child: Image.asset("assets/shoes_1.png")));
//           //                 },
//           //               )
//           //             ],
//           //           ),
//           //         ),
//           //       ),
//           //     ),
//           //     Expanded(
//           //       child: Padding(
//           //         padding: const EdgeInsets.symmetric(horizontal: 35),
//           //         child: Column(
//           //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           //           crossAxisAlignment: CrossAxisAlignment.stretch,
//           //           children: [
//           //             ShakeTransition(
//           //               child: Column(
//           //                 crossAxisAlignment: CrossAxisAlignment.stretch,
//           //                 children: const [
//           //                   Text(
//           //                     "Air - Max Pre Day",
//           //                     style: TextStyle(
//           //                         fontSize: 25,
//           //                         letterSpacing: 0.25,
//           //                         fontFamily: gilroySemibold),
//           //                   ),
//           //                   SizedBox(
//           //                     height: 12,
//           //                   ),
//           //                   Text(
//           //                     "\$${239.8}",
//           //                     style: TextStyle(
//           //                         fontSize: 18,
//           //                         letterSpacing: 0.25,
//           //                         color: Color.fromRGBO(0, 0, 0, 0.6),
//           //                       fontFamily: gilroySemibold
//           //                     ),
//           //                   )
//           //                 ],
//           //               ),
//           //             ),
//           //             const ShakeTransition(
//           //               axis: Axis.vertical,
//           //               child: Text(
//           //                 "Description here",
//           //                 style: TextStyle(
//           //                   fontSize: 15,
//           //                   fontFamily: gilroySemibold,
//           //                   letterSpacing: 0.25,
//           //                   color: Color.fromRGBO(0, 0, 0, 0.4)
//           //                 ),
//           //               ),
//           //             ),
//           //             SizedBox(
//           //               height: 38,
//           //               child: Row(
//           //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           //                 children: [
//           //                   ListView.builder(
//           //                     shrinkWrap: true,
//           //                     primary: false,
//           //                     scrollDirection: Axis.horizontal,
//           //                     itemCount: colors.length,
//           //                     itemBuilder: (context, index) {
//           //                       return ShakeTransition(
//           //                         duration: const Duration(milliseconds: 1100),
//           //                         child: Padding(
//           //                           padding: const EdgeInsets.only(right: 5),
//           //                           child: GestureDetector(
//           //                             onTap: () {
//           //                               setState(() {
//           //                                 _selectedIndex = index;
//           //                               });
//           //                             },
//           //                             child: CircleAvatar(
//           //                               backgroundColor: colors[index],
//           //                               child: Center(
//           //                                 child: _selectedIndex == index ? const Icon(Icons.check, color: Colors.white,) : null,
//           //                               ),
//           //                             ),
//           //                           ),
//           //                         )
//           //                       );
//           //                     },
//           //                   ),
//           //                   ShakeTransition(
//           //                     child: Container(
//           //                       decoration: BoxDecoration(
//           //                         borderRadius: BorderRadius.circular(10.0),
//           //                       ),
//           //                       padding: const EdgeInsets.only(left: 10, right: 10),
//           //                       child: DropdownButtonHideUnderline(
//           //                         child: DropdownButton(
//           //                             value: _value,
//           //                             isExpanded: false,
//           //                             hint: const Text(
//           //                               "Choose size",
//           //                               style: TextStyle(
//           //                                 fontFamily: gilroySemibold,
//           //                                 fontSize: 15,
//           //                                 color: Color.fromRGBO(0, 0, 0, 0.6)
//           //                               ),),
//           //                             items: const [
//           //                               DropdownMenuItem(
//           //                                 value: 1,
//           //                                 child: Text("M 20"),
//           //                               ),
//           //                               DropdownMenuItem(
//           //                                 value: 2,
//           //                                 child: Text("L 16"),
//           //                               ),
//           //                               DropdownMenuItem(
//           //                                 value: 3,
//           //                                 child: Text("M 6"),
//           //                               ),
//           //                               DropdownMenuItem(
//           //                                 value: 4,
//           //                                 child: Text("S 12"),
//           //                               ),
//           //
//           //                             ],
//           //                             onChanged: (value){
//           //                               setState(() {
//           //                                 _value = value ?? 0;
//           //                               });
//           //                             }),
//           //                       ),
//           //                     ),
//           //                   )
//           //                 ],
//           //               ),
//           //             ),
//           //             Row(
//           //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           //               children: [
//           //                 ShakeTransition(
//           //                   child: InkWell(
//           //                     onTap: () {},
//           //                     child: Container(
//           //                       decoration: BoxDecoration(
//           //                           color: const Color(0xFFF7F8FA),
//           //                           borderRadius: BorderRadius.circular(30)
//           //                       ),
//           //                       child: const FaIcon(FontAwesomeIcons.cartShopping, size: 22, color: Color(0xFFFD725A),),
//           //                     ),
//           //                   ),
//           //                 ),
//           //                 ShakeTransition(
//           //                   child: InkWell(
//           //                     onTap: () {
//           //                       showModalBottomSheet(
//           //                         backgroundColor: Colors.transparent,
//           //                         context: context,
//           //                         builder: (context) {
//           //                           return CustomBottomSheet();
//           //                         }
//           //                       );
//           //                     },
//           //                     child: Container(
//           //                       padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 70),
//           //                       decoration: BoxDecoration(
//           //                           color: const Color(0xFFFD725A),
//           //                           borderRadius: BorderRadius.circular(30)
//           //                       ),
//           //                       child: Text("Buy Now", style: TextStyle(
//           //                         fontSize: 17,
//           //                         fontWeight: FontWeight.w600,
//           //                         letterSpacing: 1,
//           //                         color: Colors.white.withOpacity(0.8)
//           //                       ),),
//           //                     ),
//           //                   ),
//           //                 ),
//           //
//           //               ],
//           //             ),
//           //
//           //
//           //             // const ShakeTransition(
//           //             //   axis: Axis.vertical,
//           //             //   child: ButtonStates(),
//           //             // ),
//           //             const SizedBox(height: 20, )
//           //           ],
//           //         ),
//           //       ),
//           //     ),
//           //   ],
//           // ),
//           ),
//     );
//   }
// }
