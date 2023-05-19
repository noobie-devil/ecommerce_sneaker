import 'package:ecommerce_sneaker/constants/admin/const.dart';
import 'package:ecommerce_sneaker/pages/adminPage/homeScreen/ordersScreen/order_detail_screen.dart';
import 'package:ecommerce_sneaker/widgets/admin/appbar_widget.dart';
import 'package:ecommerce_sneaker/widgets/admin/dashboard_button.dart';
import 'package:ecommerce_sneaker/widgets/admin/text_style.dart';
import 'package:intl/intl.dart' as intl;
import 'package:get/get.dart';


Widget productDropdown(){
  return DropdownButtonHideUnderline(
    child: DropdownButton<String>(
      hint: normalText(text: "choose Brand", color: fontGrey),
      value: null,
      isExpanded: true,
      items: const [],
      onChanged: (value){},
    ),
  ).box.white.padding(const EdgeInsets.symmetric(horizontal: 4))
  .roundedSM.make();
}