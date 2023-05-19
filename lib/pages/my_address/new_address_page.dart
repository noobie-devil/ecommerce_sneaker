import 'package:auto_size_text/auto_size_text.dart';
import 'package:ecommerce_sneaker/controllers/address_controller.dart';
import 'package:ecommerce_sneaker/models/models.dart';
import 'package:ecommerce_sneaker/widgets/common/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewAddressPage extends StatelessWidget {
  NewAddressPage({Key? key, this.currentAddress}) : super(key: key);
  final DeliveryAddress? currentAddress;
  final addressController = Get.put(AddressController());
  final RxBool setDefaultAddress = false.obs;
  @override
  Widget build(BuildContext context) {
    if(currentAddress != null) {
      addressController.setInitFormFieldValue(currentAddress!);
      setDefaultAddress.value = currentAddress!.isDefaultAddress;
    }

    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios_new)),
        ),
        title: Center(
          child: currentAddress != null ? const Text("Edit Address") : const Text("New Address"),
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
        child: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Container(
              width: Get.width,
              height: Get.height,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: AutoSizeText(
                        "Contact",
                        minFontSize: 16,
                        style: TextStyle(color: Colors.grey.shade800),
                      ),
                    ),
                    StreamBuilder(
                      stream: addressController.fullNameSubject,
                      builder: (context, snapshot) => secondaryTextFormField(
                          "Full Name",
                          currentAddress?.fullName,
                          TextInputType.name,
                          snapshot,
                          (value) => addressController.fullNameSink.add(value)),
                    ),
                    StreamBuilder(
                      stream: addressController.phoneNumberSubject,
                      builder: (context, snapshot) => secondaryTextFormField(
                          "Phone Number",
                          currentAddress?.phoneNumber,
                          TextInputType.phone,
                          snapshot,
                          (value) =>
                              addressController.phoneNumberSink.add(value)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: AutoSizeText(
                        "Address",
                        minFontSize: 16,
                        style: TextStyle(color: Colors.grey.shade800),
                      ),
                    ),
                    StreamBuilder(
                      stream: addressController.addressSubject,
                      builder: (context, snapshot) => secondaryTextFormField(
                          "Address",
                          currentAddress?.address,
                          TextInputType.streetAddress,
                          snapshot,
                          (value) => addressController.addressSink.add(value)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: AutoSizeText(
                        "Setting",
                        minFontSize: 16,
                        style: TextStyle(color: Colors.grey.shade800),
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                          border:
                              Border(bottom: BorderSide(color: Colors.grey)),
                          color: Colors.white),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const AutoSizeText(
                              "Set as default address",
                              minFontSize: 16,
                            ),
                            Obx(
                              () => Switch(
                                value:
                                    setDefaultAddress.value,
                                onChanged: (value) {
                                  setDefaultAddress.value =
                                          !setDefaultAddress.value;
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    SizedBox(
                      height: 50,
                      child: FractionallySizedBox(
                        widthFactor: 0.9,
                        child: Obx(
                          () => ElevatedButton(
                            onPressed: addressController.isFormValid.value
                                ? () async {
                                    FocusScope.of(context).unfocus();
                                    await addressController.addNewAddress(setDefaultAddress.value);
                                  }
                                : null,
                            style: ElevatedButton.styleFrom(
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero),
                            ),
                            child: const AutoSizeText(
                              "Complete",
                              minFontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
