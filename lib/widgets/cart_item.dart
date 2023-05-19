import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_sneaker/controllers/cart_controller.dart';
import 'package:ecommerce_sneaker/controllers/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../models/models.dart';

class CartItem extends StatelessWidget {
  // const CartItem({Key? key}) : super(key: key);
  const CartItem(this._cartProduct, {super.key, required this.onQuantityChanged, required this.onSelectChanged, required this.cartController});

  final CartProduct _cartProduct;
  final CartController cartController;
  final Function(String id, int quantity) onQuantityChanged;
  final Function(CartProduct, bool) onSelectChanged;

  @override
  Widget build(BuildContext context) {
    final ProductController productController = Get.put(ProductController());
    int indexProduct = productController.productList.indexWhere((element) => element.id == _cartProduct.productId);
    final Product product = productController.productList[indexProduct];
    final RxBool isChecked = (cartController.cartCheckedItemObservable.indexWhere((element) => element.productId == _cartProduct.productId) != -1).obs;
    ever(isChecked, (callback) {
      print("isChecked callback trigger");
      onSelectChanged(_cartProduct, isChecked.value);
    });

    return Column(
      children: [
        Container(
          height: 110,
          // margin: const EdgeInsets.symmetric(vertical: 10),
          padding: const EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10)
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Obx(() => Checkbox(
                    value: isChecked.value,//isChecked.value,
                    onChanged: (value) {
                      isChecked.value = value!;
                    },
                    activeColor: const Color(0xFFFD725A),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  height: 70,
                  width: 70,
                  margin: const EdgeInsets.only(right: 15),
                  decoration: BoxDecoration(
                      // color: const Color.fromARGB(255, 224, 224, 224),
                      borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade300, width: 1),
                  ),
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
                                color: Colors.black.withOpacity(0.7)
                            ),
                            minFontSize: 16,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: IconButton(
                            onPressed: () {
                              onQuantityChanged(product.id, -_cartProduct.quantity);
                              // isChecked.value = (cartController.cartCheckedItemObservable.indexWhere((element) => element.productId == _cartProduct.productId) != -1);
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
                                fontWeight: FontWeight.bold
                            ),
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
                                  onQuantityChanged(product.id, -1)
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
                                _cartProduct.quantity.toString(),
                                style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                              ),
                              IconButton(
                                onPressed: () {
                                  onQuantityChanged(product.id, 1);
                                  // isChecked.value = (cartController.cartCheckedItemObservable.indexWhere((element) => element.productId == _cartProduct.productId) != -1);

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
        )
      ],
    );
  }

}
