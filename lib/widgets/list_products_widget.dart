import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rxdart/rxdart.dart';
import '../controllers/product_controller.dart';
import '../pages/details/details_page.dart';
import '../models/models.dart';

class ListProducts extends StatelessWidget {
  ListProducts({Key? key}) : super(key: key);
  final ProductController _productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if(_productController.isLoading.value) {
        return const SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          sliver: SliverToBoxAdapter(
            child: SizedBox(
              height: 130,
              child: Center(child: CircularProgressIndicator(),),
            ),
          ),
        );
      } else if(_productController.isError.value) {
        return const SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          sliver: SliverToBoxAdapter(
            child: SizedBox(
              height: 130,
              child: Center(child: Text('Error loading products')),
            ),
          ),
        );
      } else if(_productController.isEmpty.value) {
        return ListView(
          scrollDirection: Axis.vertical,
          physics: const AlwaysScrollableScrollPhysics(),
          children: const [
            Center(
              child: Text('No products found'),
            )
          ],
        );
      } else {
        return StreamBuilder<bool>(
          stream: CombineLatestStream.combine2(
            _productController.productListChanged,
            _productController.wishListChanged,
            (productsChanged, wishListChanged) => productsChanged || wishListChanged,
          ),
          builder: (context, snapshot) {
            return SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 300,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.75
                ),
                delegate: SliverChildBuilderDelegate(
                        (context, index) {
                      final Product product = _productController
                          .productList[index];
                      return Column(
                        children: [
                          Expanded(
                            flex: 5,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(24),
                              child: Material(
                                color: const Color(0xffF6F6F6),
                                child: InkWell(
                                  onTap: () => Navigator.push(
                                      context,
                                      PageTransition(
                                          type: PageTransitionType.rightToLeft,
                                          child: DetailsPage(product: product,))),
                                  child: Stack(
                                    children: [

                                      Container(
                                        alignment: Alignment.bottomRight,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: CachedNetworkImageProvider(product.imagePath),
                                                fit: BoxFit.fitHeight
                                            ),
                                            color: Colors.white
                                        ),
                                        child: Transform.translate(
                                          offset: const Offset(-25, -10),
                                          child: CachedNetworkImage(
                                            imageUrl: product.brand.brandImage,
                                            height: 29,
                                            width: 47,
                                          ),
                                        ),
                                      ),
                                      Positioned.fill(
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Obx(() {
                                            if(_productController.wishList.containsKey(product.id) && _productController.wishList.isNotEmpty) {
                                              return IconButton(
                                                icon: const FaIcon(FontAwesomeIcons.solidHeart, color: Colors.redAccent),
                                                style: IconButton.styleFrom(
                                                  shape: const CircleBorder(),
                                                ),
                                                onPressed: () => _productController.removeFromWishList(product.id),
                                              );
                                            } else {
                                              return IconButton(
                                                icon: const FaIcon(
                                                    FontAwesomeIcons.heart,
                                                    color: Colors.blueGrey),
                                                style: IconButton.styleFrom(
                                                  shape: const CircleBorder(),
                                                ),
                                                onPressed: () => _productController.addToWishList(product),
                                              );
                                            }

                                          }),
                                        ),
                                      ),
                                    ],
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
                                    product.productName,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                    minFontSize: 14,
                                  ),
                                )
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: SizedBox(
                              width: double.infinity,
                              child: AutoSizeText(
                                "\$ ${product.price}",
                                minFontSize: 16,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),

                        ],
                      );
                    },
                    childCount: _productController.productList.length
                ),

              ),
            );
          },
        );
        return SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 300,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 0.75
            ),
            delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  final Product product = _productController
                      .productList[index];
                  return Column(
                    children: [
                      Expanded(
                        flex: 5,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: Material(
                            color: const Color(0xffF6F6F6),
                            child: InkWell(
                              onTap: () => Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      child: DetailsPage(product: product,))),
                              child: Stack(
                                children: [

                                  Container(
                                    alignment: Alignment.bottomRight,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: CachedNetworkImageProvider(product.imagePath),
                                            fit: BoxFit.fitHeight
                                        ),
                                        color: Colors.white
                                    ),
                                    child: Transform.translate(
                                      offset: const Offset(-25, -10),
                                      child: CachedNetworkImage(
                                        imageUrl: product.brand.brandImage,
                                        height: 29,
                                        width: 47,
                                      ),
                                    ),
                                  ),
                                  Positioned.fill(
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Obx(() {
                                        if(_productController.wishList.containsKey(product.id)) {
                                          return IconButton(
                                            icon: const FaIcon(FontAwesomeIcons.solidHeart, color: Colors.redAccent),
                                            style: IconButton.styleFrom(
                                              shape: const CircleBorder(),
                                            ),
                                            onPressed: () {},
                                          );
                                        } else {
                                          return IconButton(
                                            icon: const FaIcon(
                                                FontAwesomeIcons.heart,
                                                color: Colors.blueGrey),
                                            style: IconButton.styleFrom(
                                              shape: const CircleBorder(),
                                            ),
                                            onPressed: () => _productController.addToWishList(product),
                                          );
                                        }

                                      }),
                                    ),
                                  ),
                                ],
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
                                product.productName,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                minFontSize: 14,
                              ),
                            )
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          width: double.infinity,
                          child: AutoSizeText(
                            "\$ ${product.price}",
                            minFontSize: 16,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),

                    ],
                  );
                },
                childCount: _productController.productList.length
            ),

          ),
        );

      }
    });

  }
}
