import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_sneaker/constants/fonts.dart';
import 'package:ecommerce_sneaker/controllers/product_controller.dart';
import 'package:ecommerce_sneaker/models/product_model.dart';
import 'package:ecommerce_sneaker/widgets/list_products_widget.dart';
import 'package:ecommerce_sneaker/widgets/search_bar_widget.dart';
import 'package:ecommerce_sneaker/widgets/shoe_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:get/get.dart';
import '../../data.dart';
import '../details/details_page.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({Key? key}) : super(key: key);

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  final ProductController _productController = Get.put(ProductController());



  @override
  void initState() {
    _productController.getProducts();

    super.initState();
  }

  List<Widget> buildCategories() {
    return Data.generateCategories()
        .map((e) =>
        Container(
          padding: const EdgeInsets.only(right: 15, bottom: 10),
          child: ElevatedButton(
            onPressed: () {},
            style: ButtonStyle(
                // foregroundColor: MaterialStateProperty.all<Color>(
                //     e.id == 1 ? Colors.white : const Color(0xff365b6d)),
                backgroundColor: MaterialStateProperty.all<Color>(
                    e.id == 1 ? const Color(0xff8c52ff) : Colors.white),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)))),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  ClipRRect(
                    child: Image.asset(e.brandImage, width: 45,),
                  )
                ],
              ),
            ),
          ),
        ))
        .toList();
  }
  
  

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _productController.refreshProducts,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  SearchBar(),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: Get.height * 0.3,
              width: double.infinity,
              child: FractionallySizedBox(
                widthFactor: 0.95,
                child: Container(
                  alignment: Alignment.bottomLeft,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/banner.png"),
                        fit: BoxFit.fill
                      ),
                    borderRadius: BorderRadius.all(Radius.circular(14))
                  ),
                  child: FractionallySizedBox(
                    widthFactor: 0.45,
                    heightFactor: 0.25,
                    alignment: Alignment.center,
                    child: Container(
                      padding: const EdgeInsets.only(left: 14, bottom: 12),
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(
                                const Color(0xff365b6d)),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.white),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)))
                        ),
                        child: AutoSizeText(
                            "Explore Now".toUpperCase()
                        ),
                      ),
                    ),
                  )

                ),
              )
            )
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: Get.height * 0.1,
              width: double.infinity,
              child: FractionallySizedBox(
                widthFactor: 0.95,
                heightFactor: 0.75,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: buildCategories(),
                ),
              )
            ),
          ),
          ListProducts()
          // SliverPadding(
          //   padding: const EdgeInsets.symmetric(horizontal: 12),
          //   sliver: SliverGrid(
          //     gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          //       maxCrossAxisExtent: 300,
          //       mainAxisSpacing: 10,
          //       crossAxisSpacing: 10,
          //       childAspectRatio: 0.75
          //     ),
          //     delegate: SliverChildBuilderDelegate(
          //       (context, index) {
          //         return Column(
          //           children: [
          //             Expanded(
          //               flex: 5,
          //               child: ClipRRect(
          //                 borderRadius: BorderRadius.circular(24),
          //                 child: Material(
          //                   color: const Color(0xffF6F6F6),
          //                   child: InkWell(
          //                     child: Container(
          //                       alignment: Alignment.bottomRight,
          //                       decoration: const BoxDecoration(
          //                         image: DecorationImage(
          //                           image: CachedNetworkImageProvider("https://sneakerdaily.vn/wp-content/uploads/2021/04/Giay-nam-Puma-Suede-Classic-Castor-%E2%80%98Gray-365347-05.jpg"),
          //                           fit: BoxFit.fitHeight
          //                         ),
          //                         color: Colors.white
          //                       ),
          //                       child: Transform.translate(
          //                         offset: const Offset(-25, -10),
          //                         child: CachedNetworkImage(
          //                           imageUrl: "https://firebasestorage.googleapis.com/v0/b/sneakerstore-ec4f7.appspot.com/o/puma_brand.png?alt=media&token=28d39975-9025-4831-80b8-eff647903a10",
          //                           height: 29,
          //                           width: 47,
          //                         ),
          //                       ),
          //                     ),
          //                   ),
          //                 ),
          //               ),
          //             ),
          //             Expanded(
          //               flex: 2,
          //               child: Container(
          //                 width: double.infinity,
          //                 child: const Center(
          //                   child: AutoSizeText(
          //                     'Giày Puma Shuffle White Peacoat 309668-01',
          //                     style: TextStyle(
          //                       fontWeight: FontWeight.w400,
          //                     ),
          //                     overflow: TextOverflow.ellipsis,
          //                     maxLines: 2,
          //                     textAlign: TextAlign.center,
          //                     minFontSize: 14,
          //                   ),
          //                 )
          //               ),
          //             ),
          //             const Expanded(
          //               flex: 1,
          //               child: SizedBox(
          //                 width: double.infinity,
          //                 child: AutoSizeText(
          //                   "1.690.000đ",
          //                   minFontSize: 16,
          //                   style: TextStyle(
          //                     fontWeight: FontWeight.bold
          //                   ),
          //                   maxLines: 1,
          //                   overflow: TextOverflow.ellipsis,
          //                   textAlign: TextAlign.left,
          //                 ),
          //               ),
          //             ),
          //
          //           ],
          //         );
          //       },
          //       childCount: 5
          //     ),
          //
          //   ),
          // )
        ],
      ),
    );
    return SingleChildScrollView(
      // physics: AlwaysScrollableScrollPhysics(),

      child: Column(

        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            // padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.symmetric(horizontal: 10),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                SearchBar(),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Image.asset("assets/banner.png"),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 135,),
                      ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(
                                const Color(0xff365b6d)),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.white),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)))
                        ),
                        child: Text("Explore Now".toUpperCase()),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),

          SizedBox(
            height: 60,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: buildCategories(),
            ),
          ),

          ListProducts()

        ],
      ),
    );
      SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            // padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.symmetric(horizontal: 10),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                SearchBar(),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Image.asset("assets/banner.png"),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 135,),
                      ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(
                                const Color(0xff365b6d)),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.white),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)))
                        ),
                        child: Text("Explore Now".toUpperCase()),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),

          SizedBox(
            height: 60,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: buildCategories(),
            ),
          ),

          ListProducts()

        ],
      ),
    );
  }
}
