import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_sneaker/constants/fonts.dart';
import 'package:ecommerce_sneaker/controllers/cart_controller.dart';
import 'package:ecommerce_sneaker/models/models.dart';
import 'package:ecommerce_sneaker/widgets/common/fast_cart_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../controllers/product_controller.dart';

class CartScreen extends StatefulWidget {
  const CartScreen(
      {Key? key, required this.cartController, required this.productController})
      : super(key: key);

  final CartController cartController;
  final ProductController productController;

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget buildCarts(CartProduct cartProduct, Product product) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: SizedBox(
              height: 100,
              width: 100,
              child: CachedNetworkImage(imageUrl: product.imagePath),
            ),
          ),
          Expanded(
            flex: 7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 6,
                      child: AutoSizeText(
                        product.productName,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black.withOpacity(0.7)),
                        minFontSize: 16,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        onPressed: () {
                          // isChecked.value = (cartController.cartCheckedItemObservable.indexWhere((element) => element.productId == _cartProduct.productId) != -1);
                          widget.cartController.updateCartProduct(
                              cartProduct.productId, -cartProduct.quantity);
                        },
                        color: Colors.redAccent,
                        icon: const Icon(Icons.delete),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 2,
                      child: AutoSizeText(
                        "\$${product.price}",
                        style: const TextStyle(
                            color: Color(0xFFFD725A),
                            fontWeight: FontWeight.bold),
                        minFontSize: 16,
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () => {
                              widget.cartController
                                  .updateCartProduct(cartProduct.productId, -1)
                            },
                            color: const Color(0xFFF7F8FA),
                            disabledColor: Colors.black12,
                            icon: const FaIcon(
                              FontAwesomeIcons.minus,
                              size: 18,
                              color: Color(0xFFFD725A),
                            ),
                          ),
                          AutoSizeText(
                            cartProduct.quantity.toString(),
                            style: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w400),
                          ),
                          IconButton(
                            onPressed: () {
                              widget.cartController
                                  .updateCartProduct(cartProduct.productId, 1);
                            },
                            color: const Color(0xFFF7F8FA),
                            disabledColor: Colors.black12,
                            icon: const FaIcon(
                              FontAwesomeIcons.plus,
                              size: 18,
                              color: Color(0xFFFD725A),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AutoSizeText(
                "My Cart",
                minFontSize: 45,
                style: TextStyle(
                    color: Colors.blueGrey.shade700,
                    fontFamily: gilroySemibold),
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FastCart(),
                        ));
                  },
                  child: const Text("Go To Details Cart"))
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: RefreshIndicator(
                onRefresh: () => widget.cartController.refreshListenCart(),
                child: Obx(
                  () {
                    if (widget.cartController.cartState == CartState.loading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (widget.cartController.cartState ==
                        CartState.error) {
                      return CustomScrollView(
                        scrollDirection: Axis.vertical,
                        slivers: [
                          SliverToBoxAdapter(
                            child: SizedBox(
                              height: Get.size.height * 0.5,
                              child: const Center(
                                child: AutoSizeText("Error loading cart"),
                              ),
                            ),
                          )
                        ],
                      );
                    } else if (widget.cartController.cartState ==
                        CartState.empty) {
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
                      return ListView.builder(
                        itemCount: widget.cartController.cartProductList.length,
                        itemBuilder: (context, index) {
                          // ProductModel product = Data.generateProducts()[index];
                          CartProduct cartProduct =
                              widget.cartController.cartProductList[index];
                          int indexProduct = widget
                              .productController.productList
                              .indexWhere((element) =>
                                  element.id == cartProduct.productId);
                          Product product = widget
                              .productController.productList[indexProduct];
                          return buildCarts(cartProduct, product);
                        },
                      );
                    }
                  },
                )
                // child: Obx(() => ListView.builder(
                //       itemCount: widget.cartController.cartProductList.length,
                //       itemBuilder: (context, index) {
                //         // ProductModel product = Data.generateProducts()[index];
                //         CartProduct cartProduct =
                //             widget.cartController.cartProductList[index];
                //         int indexProduct = widget.productController.productList
                //             .indexWhere((element) =>
                //                 element.id == cartProduct.productId);
                //         Product product =
                //             widget.productController.productList[indexProduct];
                //         return buildCarts(cartProduct, product);
                //       },
                //     ))
                ),
          ),
          // Obx(
          //   () => Expanded(
          //     child: ListView.builder(
          //       itemCount: widget.cartController.cartProductList.length,
          //       itemBuilder: (context, index) {
          //         // ProductModel product = Data.generateProducts()[index];
          //         CartProduct cartProduct =
          //             widget.cartController.cartProductList[index];
          //         int indexProduct = widget.productController.productList
          //             .indexWhere(
          //                 (element) => element.id == cartProduct.productId);
          //         Product product =
          //             widget.productController.productList[indexProduct];
          //         return buildCarts(cartProduct, product);
          //       },
          //     ),
          //   ),
          // ),
        ],
      ),
    );
    // return const Center(
    //   child: Text("cart"),
    // );
  }
}
