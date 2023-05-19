import 'package:auto_size_text/auto_size_text.dart';
import 'package:ecommerce_sneaker/constants/fonts.dart';
import 'package:ecommerce_sneaker/controllers/product_controller.dart';
import 'package:ecommerce_sneaker/controllers/wish_list_controller.dart';
import 'package:ecommerce_sneaker/widgets/wishlist_single_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/models.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({Key? key, required this.productController, required this.wishListController}) : super(key: key);
  final ProductController productController;
  final WishListController wishListController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AutoSizeText(
            "Wishlist",
            minFontSize: 45,
            style: TextStyle(
                color: Colors.blueGrey.shade700, fontFamily: gilroySemibold),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            width: double.infinity,
            child: Transform.translate(
              offset: const Offset(0, -10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    flex: 1,
                    child: AutoSizeText(
                      "Saved for later",
                      minFontSize: 17,
                      style: TextStyle(
                          color: Colors.blueGrey.shade700,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          AutoSizeText(
                            // "Add all to cart",
                            "",
                            minFontSize: 16,
                            style: TextStyle(
                              color: Colors.transparent,
                              fontWeight: FontWeight.w400,
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.indigo.shade800,
                              shadows: [
                                Shadow(
                                    color: Colors.blueGrey.shade700,
                                    offset: const Offset(0, -5))
                              ],
                            ),
                          ),
                          TextButton(
                            onPressed: () => wishListController.clearWishList(),
                            child: AutoSizeText(
                              "Clear all",
                              minFontSize: 16,
                              style: TextStyle(
                                color: Colors.transparent,
                                fontWeight: FontWeight.w400,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.indigo.shade800,
                                shadows: [
                                  Shadow(
                                      color: Colors.blueGrey.shade700,
                                      offset: const Offset(0, -5))
                                ],
                              ),
                            ),
                          )

                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
              child: RefreshIndicator(
            onRefresh: () => wishListController.refreshListener(),
            child: Obx(() {
              if (wishListController.wishListState == WishListState.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (wishListController.wishListState ==
                  WishListState.error) {
                return CustomScrollView(
                  scrollDirection: Axis.vertical,
                  slivers: [
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: Get.size.height * 0.5,
                        child: const Center(
                          child: AutoSizeText("Error loading wishlist items"),
                        ),
                      ),
                    )
                  ],
                );
              } else if (wishListController.wishListState ==
                  WishListState.empty) {
                return CustomScrollView(
                  scrollDirection: Axis.vertical,
                  slivers: [
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: Get.size.height * 0.5,
                        child: const Center(
                          child: AutoSizeText("No item found"),
                        ),
                      ),
                    )
                  ],
                );
              } else {
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 350,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 0.65),
                  itemBuilder: (context, index) {
                    final item = wishListController.wishList.elementAt(index);
                    return FutureBuilder<Product?>(
                      future: productController.getProductById(item.productId),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final product = snapshot.data!;
                          return WishListSingleItem(
                              wishListItem: item, 
                              currentProduct: product,
                              onRemoveClicked: (wishListItemId) async {
                                bool result = await wishListController.removeWishListItem(wishListItemId);
                                if(result) {
                                  Get.snackbar("Thành công", "Đã xóa sản phẩm khỏi wishlist!",
                                      snackPosition: SnackPosition.BOTTOM,
                                      duration: const Duration(seconds: 2));
                                } else {
                                  Get.snackbar("Lỗi", "Đã xảy ra lỗi!",
                                      snackPosition: SnackPosition.BOTTOM,
                                      duration: const Duration(seconds: 2));
                                }
                              },
                              onAddToCartSuccess: (String? wishListItemId) {
                                wishListController.removeWishListItem(wishListItemId);
                              },
                          );

                        }
                        else {
                          return const SizedBox(
                              height: 150,
                              width: double.infinity,
                              child: Center(child: CircularProgressIndicator(),));
                        }
                      },
                    );
                  },
                  itemCount: wishListController.wishList.length,
                );
              }
            }),
          )
              // GridView.builder(
              //   gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              //       maxCrossAxisExtent: 350,
              //       mainAxisSpacing: 10,
              //       crossAxisSpacing: 10,
              //       childAspectRatio: 0.65
              //   ),
              //   itemBuilder: (context, index) {
              //     return Padding(
              //       padding: const EdgeInsets.symmetric(vertical: 8.0),
              //       child: Column(
              //         children: [
              //           Expanded(
              //             flex: 7,
              //             child: ClipRRect(
              //               borderRadius: BorderRadius.circular(18),
              //               child: Material(
              //                 color: const Color(0xffF6F6F6),
              //                 child: InkWell(
              //                   onTap: (){},
              //                   child: Container(
              //                     alignment: Alignment.bottomRight,
              //                     decoration: const BoxDecoration(
              //                       image: DecorationImage(
              //                         image: CachedNetworkImageProvider(
              //                           "https://sneakerdaily.vn/wp-content/uploads/2021/04/Giay-nam-Puma-Suede-Classic-Castor-%E2%80%98Gray-365347-05.jpg"
              //                         ),
              //                         fit: BoxFit.fitHeight
              //                       ),
              //                       color: Colors.white
              //                     ),
              //                     child: Transform.translate(
              //                       offset: const Offset(-25, -10),
              //                       child: CachedNetworkImage(
              //                         imageUrl: "https://firebasestorage.googleapis.com/v0/b/sneakerstore-ec4f7.appspot.com/o/adidas_brand.png?alt=media&token=c6bf3b22-a676-4621-8b7b-ec89e3f6d95c",
              //                         height: 29,
              //                         width: 47,
              //                       ),
              //                     ),
              //                   ),
              //                 ),
              //               ),
              //             ),
              //           ),
              //           Expanded(
              //             flex: 2,
              //             child: SizedBox(
              //                 width: double.infinity,
              //                 child: Center(
              //                   child: AutoSizeText(
              //                     "product.productName",
              //                     style: TextStyle(
              //                       color: Colors.blueGrey.shade700,
              //                       fontWeight: FontWeight.w500
              //                     ),
              //                     overflow: TextOverflow.ellipsis,
              //                     maxLines: 1,
              //                     textAlign: TextAlign.center,
              //                     minFontSize: 18,
              //                   ),
              //                 )
              //             ),
              //           ),
              //           const Expanded(
              //             flex: 2,
              //             child: SizedBox(
              //               width: double.infinity,
              //               child: AutoSizeText(
              //                 "\$ product.price",
              //                 minFontSize: 16,
              //                 style: TextStyle(
              //                 ),
              //                 maxLines: 1,
              //                 overflow: TextOverflow.ellipsis,
              //                 textAlign: TextAlign.left,
              //               ),
              //             ),
              //           ),
              //           Expanded(
              //             flex: 2,
              //             child: ElevatedButton(
              //               onPressed: () {},
              //               style: ElevatedButton.styleFrom(
              //                 shape: RoundedRectangleBorder(
              //                   borderRadius: BorderRadiusDirectional.circular(20)
              //                 ),
              //                 padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              //               ),
              //               child: const AutoSizeText(
              //                   "Add to cart",
              //                 minFontSize: 16,
              //               ),
              //             ),
              //           )
              //         ],
              //       ),
              //     );
              //   },
              //   itemCount: 3,
              // )
              // GridView.count(
              //   primary: false,
              //   padding: const EdgeInsets.all(20),
              //   crossAxisSpacing: 10,
              //   mainAxisSpacing: 10,
              //   crossAxisCount: 2,
              //   children: <Widget>[
              //     Container(
              //       padding: const EdgeInsets.all(8),
              //       color: Colors.teal[100],
              //       child: const Text("He'd have you all unravel at the"),
              //     ),
              //     Container(
              //       padding: const EdgeInsets.all(8),
              //       color: Colors.teal[200],
              //       child: const Text('Heed not the rabble'),
              //     ),
              //     Container(
              //       padding: const EdgeInsets.all(8),
              //       color: Colors.teal[300],
              //       child: const Text('Sound of screams but the'),
              //     ),
              //     Container(
              //       padding: const EdgeInsets.all(8),
              //       color: Colors.teal[400],
              //       child: const Text('Who scream'),
              //     ),
              //     Container(
              //       padding: const EdgeInsets.all(8),
              //       color: Colors.teal[500],
              //       child: const Text('Revolution is coming...'),
              //     ),
              //     Container(
              //       padding: const EdgeInsets.all(8),
              //       color: Colors.teal[600],
              //       child: const Text('Revolution, they...'),
              //     ),
              //   ],
              // ),
              )
        ],
      ),
    );
  }
}
