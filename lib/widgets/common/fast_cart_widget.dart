import 'package:auto_size_text/auto_size_text.dart';
import 'package:ecommerce_sneaker/controllers/cart_controller.dart';
import 'package:ecommerce_sneaker/controllers/product_controller.dart';
import 'package:ecommerce_sneaker/widgets/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/fonts.dart';
import '../../models/models.dart';

class FastCart extends StatelessWidget {
  FastCart({Key? key}) : super(key: key);

  final CartController cartController = Get.put(CartController());
  final ProductController productController = Get.put(ProductController());
  final selectedItem = RxSet<CartProduct>();

  double updateTotalPayment(List<CartProduct> setItem) {
    double sum = 0;
    for (var element in setItem) {
      int index = productController.productList.indexWhere((p) => p.id == element.productId);
      if(index != -1) {
        sum += productController.productList[index].price * element.quantity;
      }
    }
    return double.parse(sum.toStringAsFixed(2));
  }

  // void updateSelectedItem(List<CartProduct> listUpdate){
  //   List<CartProduct> updateSelectedItem = [];
  //   for (var element in selectedItem) {
  //     print("element: ${element.toJson()}");
  //     print(listUpdate.toString());
  //     int index = listUpdate.indexWhere((e) => e.productId == element.productId);
  //     if(index != -1) {
  //       print("element in index $index: ${listUpdate[index]}");
  //       updateSelectedItem.add(listUpdate[index]);
  //     }
  //   }
  //   selectedItem.clear();
  //   selectedItem.addAll(updateSelectedItem);
  //   print(selectedItem);
  // }

  @override
  Widget build(BuildContext context) {

    final totalPayment = RxDouble(0);
    final RxBool isSelectedAll = true.obs;

    ever(cartController.cartCheckedItemObservable, (callback) => {
      totalPayment.value = updateTotalPayment(callback)
    });
    // ever(selectedItem, (callback) => {
    //   totalPayment.value = updateTotalPayment(selectedItem)
    // });
    // ever(cartController.cartProductObservable, (callback) => {
    //   updateSelectedItem(callback)
    // });
    cartController.cartCheckedItemObservable.addAll(cartController.cartProductList);
    // selectedItem.addAll(cartController.cartProductList);

    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) =>
              IconButton(
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
                      Obx(() =>
                          Column(
                              children: cartController.cartProductList
                                  .map((e) =>
                                  CartItem(
                                    e,
                                    onQuantityChanged: (id, quantity) async {
                                      await cartController.updateCartProduct(
                                          id, quantity);
                                      totalPayment.value = updateTotalPayment(cartController.cartCheckedItem);
                                    },
                                    onSelectChanged: (p0, isSelect) =>
                                    {
                                      if(isSelect) {
                                        cartController.cartCheckedItem.add(p0)
                                      } else
                                      {
                                        cartController.cartCheckedItem.remove(p0)
                                      }
                                    },
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
                              style: TextStyle(
                                fontFamily: gilroySemibold
                              ),
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
                            Obx(() =>
                                AutoSizeText(
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
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FastCart(),
                              ));
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 100),
                          decoration: BoxDecoration(
                              color: const Color(0xFFFD725A),
                              borderRadius: BorderRadius.circular(30)),
                          child: Text(
                            "Checkout",
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1,
                                color: Colors.white.withOpacity(0.9)),
                          ),
                        ),
                      ),
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
