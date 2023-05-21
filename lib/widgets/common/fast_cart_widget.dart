import 'package:auto_size_text/auto_size_text.dart';
import 'package:ecommerce_sneaker/controllers/cart_controller.dart';
import 'package:ecommerce_sneaker/controllers/product_controller.dart';
import 'package:ecommerce_sneaker/pages/checkout/checkout_page.dart';
import 'package:ecommerce_sneaker/widgets/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/fonts.dart';
import '../../controllers/checkout_controller.dart';
import '../../models/models.dart';

class FastCart extends StatefulWidget {
  const FastCart({Key? key}) : super(key: key);

  @override
  State<FastCart> createState() => _FastCartState();
}

class _FastCartState extends State<FastCart> {
  final CartController cartController = Get.put(CartController());
  final ProductController productController = Get.put(ProductController());
  final totalPayment = RxDouble(0);
  bool triggerFlag = true;

  double updateTotalPayment(List<CartProduct> setItem) {
    double sum = 0;
    for (var element in setItem) {
      int index = productController.productList
          .indexWhere((p) => p.id == element.productId);
      if (index != -1) {
        sum += productController.productList[index].price * element.quantity;
      }
    }
    return double.parse(sum.toStringAsFixed(2));
  }

  void updateSelectedItem(List<CartProduct> listUpdate) {
    print("size: ${cartController.cartCheckedItemObservable.length}");
    // if(cartController.cartCheckedItemObservable.isEmpty) {
    //   print("cartCheckedItem.isEmpty");
    //   cartController.cartCheckedItemObservable.assignAll(listUpdate);
    // } else {
    //   List<CartProduct> temp = [];
    //   for (var element in listUpdate) {
    //     int index = cartController.cartCheckedItemObservable.indexWhere((e) => e.productId == element.productId);
    //     if(index != - 1) {
    //       print("add element: ${element.toJson()}");
    //       temp.add(element);
    //     }
    //   }
    //   // cartController.cartCheckedItemObservable.clear();
    //   cartController.cartCheckedItemObservable.assignAll(temp);
    List<CartProduct> tempList = [];
    for (var element in listUpdate) {
      int index = cartController.cartCheckedItemObservable
          .indexWhere((e) => e.productId == element.productId);
      if (index != -1) {
        print("add element: ${element.toJson()}");
        tempList.add(element);
      }
    }
    cartController.cartCheckedItemObservable.assignAll(tempList);
    triggerFlag = true;
  }

  @override
  void initState() {
    super.initState();
    ever(
        cartController.cartCheckedItemObservable,
        (callback) =>
            {totalPayment.value = updateTotalPayment(callback.toList())});
    cartController.cartCheckedItemObservable
        .assignAll(cartController.cartProductList);

    // ever(selectedItem, (callback) => {
    //   totalPayment.value = updateTotalPayment(callback.toList())
    // });
    ever(cartController.cartProductObservable, (callback) {
      if (triggerFlag) {
        triggerFlag = !triggerFlag;
        updateSelectedItem(callback);
      }
    });

    // cartController.cartCheckedItemObservable.addAll(cartController.cartProductList);
  }

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
          child: Text(
            "Cart",
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.more_horiz,
                size: 30,
              ))
        ],
      ),
      body: SingleChildScrollView(
          child: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 15),
              child: Column(
                children: [
                  Obx(() => Column(
                      children: cartController.cartProductList
                          .map((e) => CartItem(
                                e,
                                onQuantityChanged: (id, quantity) async {
                                  await cartController.updateCartProduct(
                                      id, quantity);
                                  totalPayment.value = updateTotalPayment(
                                      cartController.cartCheckedItem);
                                  print(
                                      "OnQuantityChanged: ${cartController.cartCheckedItem.toString()}");
                                },
                                onSelectChanged: (p0, isSelect) => {
                                  if (isSelect)
                                    {
                                      // cartController.cartCheckedItem.add(p0)
                                      cartController.cartCheckedItemObservable
                                          .add(p0)
                                    }
                                  else
                                    {
                                      cartController.cartCheckedItemObservable
                                          .remove(p0)
                                      // cartController.cartCheckedItem.remove(p0)
                                    }
                                },
                                cartController: cartController,
                              ))
                          .toList())),
                  // CartItem(),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const AutoSizeText(
                          "Select All",
                          minFontSize: 16,
                          style: TextStyle(fontFamily: gilroySemibold),
                        ),
                        Checkbox(
                            activeColor: const Color(0xFFFd725A),
                            value: true,
                            onChanged: (value) {})
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const AutoSizeText(
                          "Total Payment:",
                          minFontSize: 20,
                          style: TextStyle(fontFamily: gilroyBold),
                        ),
                        Obx(
                          () => AutoSizeText(
                            "\$${totalPayment.value}",
                            minFontSize: 20,
                            style: const TextStyle(
                                color: Color(0xFFFD725A),
                                fontFamily: gilroySemibold),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 50),
                    child: ElevatedButton(
                      onPressed: () {
                        List<CartProduct> listItemSelected = cartController.cartCheckedItem;
                        for(CartProduct cartProduct in listItemSelected) {
                          print(cartProduct.toJson().toString());
                        }
                        CheckoutController checkoutController = Get.put(CheckoutController());
                        checkoutController.setCartProductNeedCheckout(listItemSelected);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CheckoutPage(checkoutController: checkoutController,),
                            )).then((value) => checkoutController.refreshCartProduct());
                      },
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          padding: const EdgeInsets.symmetric(vertical: 20)),
                      child: AutoSizeText(
                        "Checkout",
                        minFontSize: 17,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1,
                            color: Colors.white.withOpacity(0.9)),
                      ),
                    ),
                  ),
                  // InkWell(
                  //   onTap: () {
                  //     // Navigator.push(
                  //     //     context,
                  //     //     MaterialPageRoute(
                  //     //       builder: (context) => FastCart(),
                  //     //     ));
                  //   },
                  //   child: Container(
                  //     padding: const EdgeInsets.symmetric(
                  //         vertical: 20, horizontal: 100),
                  //     decoration: BoxDecoration(
                  //         color: const Color(0xFFFD725A),
                  //         borderRadius: BorderRadius.circular(30)),
                  //     child: Text(
                  //       "Checkout",
                  //       style: TextStyle(
                  //           fontSize: 17,
                  //           fontWeight: FontWeight.w600,
                  //           letterSpacing: 1,
                  //           color: Colors.white.withOpacity(0.9)),
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(
                    height: 30,
                  )
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
