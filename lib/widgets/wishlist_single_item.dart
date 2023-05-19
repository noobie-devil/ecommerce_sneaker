import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_sneaker/models/models.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/product_detail_controller.dart';
import 'bottom_sheet.dart';

class WishListSingleItem extends StatelessWidget {
  const WishListSingleItem({Key? key, required this.wishListItem, required this.currentProduct, required this.onRemoveClicked, required this.onAddToCartSuccess}) : super(key: key);
  final WishListItem wishListItem;
  final Product currentProduct;
  final Function(String? wishListItemId) onRemoveClicked;
  final Function(String? wishListItemId) onAddToCartSuccess;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          Expanded(
            flex: 7,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Material(
                color: const Color(0xffF6F6F6),
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    alignment: Alignment.bottomRight,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: CachedNetworkImageProvider(currentProduct.imagePath),
                            fit: BoxFit.fitHeight),
                        color: Colors.white),
                    child: Transform.translate(
                      offset: const Offset(-25, -10),
                      child: CachedNetworkImage(
                        imageUrl: currentProduct.brand.brandImage,
                        height: 29,
                        width: 47,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: SizedBox(
                width: double.infinity,
                child: Center(
                  child: AutoSizeText(
                    currentProduct.productName,
                    style: TextStyle(
                        color: Colors.blueGrey.shade700,
                        fontWeight: FontWeight.w500),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    minFontSize: 18,
                  ),
                )),
          ),
          Expanded(
            flex: 2,
            child: SizedBox(
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AutoSizeText(
                    "\$ ${currentProduct.price}",
                    minFontSize: 16,
                    style: const TextStyle(
                        fontWeight: FontWeight.w400
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                  ),
                  GestureDetector(
                    onTap: () => onRemoveClicked(wishListItem.id),
                    child: AutoSizeText(
                      "Remove",
                      minFontSize: 16,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.blueGrey,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.indigo.shade800,

                      ),
                    ),
                  )
                  // TextButton(
                  //   onPressed: () {},
                  //   child: AutoSizeText(
                  //     "Remove",
                  //     minFontSize: 16,
                  //     style: TextStyle(
                  //       fontWeight: FontWeight.w400,
                  //       decoration: TextDecoration.underline,
                  //       decorationColor: Colors.indigo.shade800,
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: () {
                final ProductDetailController productDetailController = Get.put(ProductDetailController(), permanent: false);
                productDetailController.updateProduct(currentProduct);
                Future<void> future = showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (context) {
                    return CustomBottomSheet(productDetailController: productDetailController, addToCartCallback: () {
                      onAddToCartSuccess(wishListItem.id);

                    },);
                  },
                );
                future.then((value) => productDetailController.onClose());
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadiusDirectional.circular(
                        20)),
                padding: const EdgeInsets.symmetric(
                    horizontal: 30, vertical: 10),
              ),
              child: const AutoSizeText(
                "Add to cart",
                minFontSize: 16,
              ),
            ),
          )
        ],
      ),
    );
  }
}
