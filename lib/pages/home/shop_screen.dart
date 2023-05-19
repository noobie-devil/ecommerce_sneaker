import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_sneaker/controllers/product_controller.dart';
import 'package:ecommerce_sneaker/widgets/list_products_widget.dart';
import 'package:ecommerce_sneaker/widgets/search_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({Key? key, required this.productController}) : super(key: key);
  final ProductController productController;
  
  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {

  @override
  void initState() {
    super.initState();
  }

  List<Widget> buildCategories() {
    // return widget.productController.brandList
    //   .map((e) {
    //
    // }).toList();
    return widget.productController.brandList
        .map((e) => Container(
              padding: const EdgeInsets.only(right: 15, bottom: 10),
              child: ElevatedButton(
                onPressed: () {
                  if(widget.productController.brandFilterSelected.value == e.id) {
                    widget.productController.brandFilterSelected.value = "";
                  } else {
                    widget.productController.brandFilterSelected.value = e.id;
                  }
                  setState(() {

                  });
                },
                // style: ElevatedButton.styleFrom(
                //   shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(30)
                //   ),
                // )
                style: ButtonStyle(
                  // foregroundColor: MaterialStateProperty.all<Color>(
                  //     e.id == 1 ? Colors.white : const Color(0xff365b6d)),
                  //   backgroundColor: MaterialStateProperty.all<Color>(
                  //       e.id == 1 ? const Color(0xff8c52ff) : Colors.white),
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    if (widget.productController.brandFilterSelected.value == e.id) {
                      return const Color(0xff8c52ff);
                    } else if (states.contains(MaterialState.pressed) ||
                        states.contains(MaterialState.focused) ||
                        states.contains(MaterialState.selected) ||
                        states.contains(MaterialState.focused)) {
                      return const Color(0xff8c52ff);
                    } else {
                      return Colors.white;
                    }
                  }),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30))),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      ClipRRect(
                          // child: Image.asset(e.brandImage, width: 45,),
                          child: CachedNetworkImage(
                        imageUrl: e.brandImage,
                        width: 45,
                      ))
                    ],
                  ),
                ),
              ),
            ))
        .toList();
    // return Data.generateCategories()
    //     .map((e) => Container(
    //           padding: const EdgeInsets.only(right: 15, bottom: 10),
    //           child: ElevatedButton(
    //             onPressed: () {},
    //             style: ButtonStyle(
    //                 // foregroundColor: MaterialStateProperty.all<Color>(
    //                 //     e.id == 1 ? Colors.white : const Color(0xff365b6d)),
    //                 backgroundColor: MaterialStateProperty.all<Color>(
    //                     e.id == 1 ? const Color(0xff8c52ff) : Colors.white),
    //                 shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    //                     RoundedRectangleBorder(
    //                         borderRadius: BorderRadius.circular(30)))),
    //             child: Padding(
    //               padding: const EdgeInsets.all(8.0),
    //               child: Row(
    //                 children: [
    //                   ClipRRect(
    //                     child: Image.asset(
    //                       e.brandImage,
    //                       width: 45,
    //                     ),
    //                   )
    //                 ],
    //               ),
    //             ),
    //           ),
    //         ))
    //     .toList();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: widget.productController.refreshProducts,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  // SearchBar(),
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
                                fit: BoxFit.fill),
                            borderRadius:
                                BorderRadius.all(Radius.circular(14))),
                        child: FractionallySizedBox(
                          widthFactor: 0.45,
                          heightFactor: 0.25,
                          alignment: Alignment.center,
                          child: Container(
                            padding:
                                const EdgeInsets.only(left: 14, bottom: 12),
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          const Color(0xff365b6d)),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30)))),
                              child: AutoSizeText("Explore Now".toUpperCase()),
                            ),
                          ),
                        )),
                  ))),
          SliverToBoxAdapter(
            child: SizedBox(
                height: Get.height * 0.1,
                width: double.infinity,
                child: FractionallySizedBox(
                  widthFactor: 0.95,
                  heightFactor: 0.75,
                  child: Obx(
                    () => ListView(
                      scrollDirection: Axis.horizontal,
                      children: buildCategories(),
                    ),
                  ),
                )),
          ),
          ListProducts()

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
                // SearchBar(),
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
                      const SizedBox(
                        height: 135,
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(
                                const Color(0xff365b6d)),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)))),
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
                // SearchBar(),
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
                      const SizedBox(
                        height: 135,
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(
                                const Color(0xff365b6d)),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)))),
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
