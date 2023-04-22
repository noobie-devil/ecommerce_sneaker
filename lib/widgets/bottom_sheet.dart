import 'package:auto_size_text/auto_size_text.dart';
import 'package:ecommerce_sneaker/controllers/cart_controller.dart';
import 'package:ecommerce_sneaker/controllers/product_detail_controller.dart';
import 'package:ecommerce_sneaker/pages/home/cart_screen.dart';
import 'package:ecommerce_sneaker/constants/fonts.dart';
import 'package:ecommerce_sneaker/widgets/common/fast_cart_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class CustomBottomSheet extends StatelessWidget {

  CustomBottomSheet({super.key, required this.productDetailController});

  final ProductDetailController productDetailController;

  // const CustomBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.put(CartController());
    return Container(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 4,
            width: 50,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 223, 221, 221),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Size:",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
              const SizedBox(
                width: 30,
              ),
              Expanded(
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: productDetailController.sizeList
                      .map((size) => GestureDetector(
                            onTap: () {
                              productDetailController.selectedSize.value = size;
                            },
                            child: Obx(
                              () => Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: const Color(0xFFF7F8FA),
                                    borderRadius: BorderRadius.circular(30),
                                    border: Border.all(
                                        color: productDetailController
                                                    .selectedSize.value ==
                                                size
                                            ? const Color(0xFFFD725A)
                                            : Colors.transparent,
                                        width: 1)),
                                child: AutoSizeText(size),
                              ),
                            ),
                          ))
                      .toList(),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const Text(
                "Color:",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                width: 30,
              ),
              Expanded(
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 10,
                  children: productDetailController.colorList
                      .map((e) => GestureDetector(
                            onTap: () {
                              productDetailController.selectedColor.value = e;
                            },
                            child: Obx(
                              () => CircleAvatar(
                                backgroundColor: Color(e),
                                radius: 15,
                                child: Center(
                                  child: productDetailController
                                              .selectedColor.value ==
                                          e
                                      ? const Icon(
                                          Icons.check,
                                          color: Colors.white,
                                        )
                                      : null,
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const Text(
                "Total:",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
              ),

              Obx(() => MaterialButton(
                  onPressed: productDetailController.selectedQuantity.value == 0 ? null : () => productDetailController.selectedQuantity.value-=1,
                  shape: const CircleBorder(),
                  color: const Color(0xFFF7F8FA),
                  disabledColor: Colors.black12,
                  child: FaIcon(
                    FontAwesomeIcons.minus,
                    size: 18,
                    color: productDetailController.selectedQuantity.value != 0 ? const Color(0xFFFD725A) : null,
                  ),

                ),
              ),
              Obx(() => AutoSizeText(
                  productDetailController.selectedQuantity.toString(),
                  style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                ),
              ),
              MaterialButton(
                onPressed: () => productDetailController.selectedQuantity.value += 1,
                shape: const CircleBorder(),
                color: const Color(0xFFF7F8FA),
                disabledColor: Colors.black12,
                child: const FaIcon(
                  FontAwesomeIcons.plus,
                  size: 18,
                  color: Color(0xFFFD725A),
                ),

              ),
              // InkWell(
              //   onTap: () => productDetailController.selectedQuantity.value +=1,
              //   child: Container(
              //     padding: const EdgeInsets.all(8),
              //     decoration: BoxDecoration(
              //       color: const Color(0xFFF7F8FA),
              //       borderRadius: BorderRadius.circular(20),
              //     ),
              //     child: const FaIcon(
              //       FontAwesomeIcons.plus,
              //       size: 18,
              //       color: Colors.redAccent,
              //     ),
              //   ),
              // ),
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Total Payment:",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              Obx(() => AutoSizeText(
                  "\$${productDetailController.cost}",
                  style: const TextStyle(
                      color: Color(0xFFFD725A),
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Obx(
            () => ElevatedButton(
                onPressed: !productDetailController.enableButton.value ? null : () {
                  Navigator.pop(context);
                  cartController.updateCartProduct(productDetailController.product.id, productDetailController.selectedQuantity.value);
                },
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => const FastCart(),
                //     )),
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(vertical: 13, horizontal: 20)),
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.disabled)) {
                          return Colors.black12;
                        }
                        return Colors.blueGrey;
                      }
                  )

                ),
                child: const AutoSizeText(
                  "Add",
                  style: TextStyle(fontFamily: gilroySemibold),
                  minFontSize: 20,
                ),
              ),
          ),
        ],
      ),
    );
  }
}
