import 'package:ecommerce_sneaker/constants/admin/const.dart';
import 'package:ecommerce_sneaker/pages/adminPage/homeScreen/ordersScreen/order_detail_screen.dart';
import 'package:ecommerce_sneaker/pages/adminPage/homeScreen/productsScreen/component/product_dropdown.dart';
import 'package:ecommerce_sneaker/pages/adminPage/homeScreen/productsScreen/component/product_image.dart';
import 'package:ecommerce_sneaker/widgets/admin/appbar_widget.dart';
import 'package:ecommerce_sneaker/widgets/admin/custom_TextField.dart';
import 'package:ecommerce_sneaker/widgets/admin/dashboard_button.dart';
import 'package:ecommerce_sneaker/widgets/admin/text_style.dart';
import 'package:intl/intl.dart' as intl;
import 'package:get/get.dart';

class AddProductScreen extends StatelessWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: purpleColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,),
          onPressed: () {
            Get.back();
          },
        ),
        title: boldText(text: 'Add Product', size: 16.0),
        actions: [
          TextButton(onPressed: (){}, child: boldText(text: save, color: purpleColor)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customTextField(
                hint: 'eg. Air Force 1',
                label: 'Product name',
              ),
              10.heightBox,
              customTextField(
                hint: 'eg. Nice Product',
                label: 'Decription',
                isDesc: true
              ),
              10.heightBox,
              customTextField(
                  hint: '100',
                  label: 'Price',
              ),
              10.heightBox,
              customTextField(
                hint: '100',
                label: 'Quantity',
              ),
              10.heightBox,
              productDropdown(),
              10.heightBox,

              const Divider(color: white,),
              boldText(text: 'Choose Product Image'),
              10.heightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  1,
                  (index) => productImages(label: "${index + 1}"),
                ),
              ),
              5.heightBox,
              normalText(text: 'Display Image', color: lightGrey),

            ],
          ),
        ),
      ),
    );
  }
}
