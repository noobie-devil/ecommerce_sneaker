import 'package:auto_size_text/auto_size_text.dart';
import 'package:ecommerce_sneaker/controllers/address_controller.dart';
import 'package:ecommerce_sneaker/pages/my_address/new_address_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';

class MyAddressPage extends StatelessWidget {
  MyAddressPage({Key? key}) : super(key: key);
  final AddressController addressController = Get.put(AddressController());

  @override
  Widget build(BuildContext context) {
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
          child: Text("My address"),
        ),
        actions: [
          Opacity(
            opacity: 0,
            child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.more_horiz,
                  size: 20,
                )),
          )
        ],
      ),
      body: SafeArea(
        child: Container(
          width: Get.width,
          height: Get.height,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
          ),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: AutoSizeText(
                    "Address",
                    minFontSize: 16,
                    style: TextStyle(color: Colors.grey.shade800),
                  ),
                ),
              ),
              Obx(() => SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final address = addressController.addressList.elementAt(index);
                    return Container(
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                        border: Border(top: BorderSide(color: Colors.grey.shade200))
                      ),
                      child: Material(
                        color: Colors.white,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    child: NewAddressPage(currentAddress: address,)
                                )
                            ).then((value) => addressController.resetInitFormFieldValue());
                          },
                          highlightColor: Colors.grey.shade200,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
                            child: FractionallySizedBox(
                              alignment: Alignment.topLeft,
                              widthFactor: 0.85,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    right: BorderSide(
                                                      color: Colors.grey.shade800,
                                                    )
                                                )
                                            ),
                                            child: AutoSizeText(
                                              address.fullName,
                                              overflow: TextOverflow.ellipsis,
                                              minFontSize: 16,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w400
                                              ),
                                            ),
                                          ),
                                        ),

                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 8.0),
                                            child: AutoSizeText(
                                              address.phoneNumber,
                                              minFontSize: 16,
                                              style: TextStyle(
                                                  color: Colors.grey.shade700
                                              ),
                                            ),
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: AutoSizeText(
                                      address.address,
                                      minFontSize: 16,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.grey.shade700
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          border: Border.fromBorderSide(BorderSide(color: address.isDefaultAddress ? Colors.redAccent.shade200 : Colors.grey, width: 1))
                                      ),
                                      child: Text(
                                        'Default',
                                        style: TextStyle(
                                            color: address.isDefaultAddress ? Colors.redAccent : Colors.grey
                                        ),
                                      ),
                                    ),
                                  )

                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                    childCount: addressController.addressList.length
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                    decoration: BoxDecoration(
                      border: Border(top: BorderSide(color: Colors.grey.shade400, width: 0.8)),
                      color: Colors.transparent
                    ),
                    child: Material(
                      color: Colors.white,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: NewAddressPage()
                            )
                          ).then((value) {
                            addressController.resetInitFormFieldValue();
                          });
                        },
                        highlightColor: Colors.grey.shade200,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.add_box_rounded,
                                  color: Colors.redAccent,
                                  size: 30,
                                ),
                              ),
                              const AutoSizeText(
                                "Add New Address",
                                minFontSize: 16,
                                style: TextStyle(
                                  color: Colors.redAccent,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
              )
            ],
          )
        ),
      ),
    );
  }
}
