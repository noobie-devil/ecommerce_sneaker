import 'package:ecommerce_sneaker/constants/admin/const.dart';
import 'package:ecommerce_sneaker/pages/adminPage/homeScreen/ordersScreen/order_detail_screen.dart';
import 'package:ecommerce_sneaker/widgets/admin/appbar_widget.dart';
import 'package:ecommerce_sneaker/widgets/admin/dashboard_button.dart';
import 'package:ecommerce_sneaker/widgets/admin/text_style.dart';
import 'package:intl/intl.dart' as intl;
import 'package:get/get.dart';

Widget productImages({required label, onPress}){
  return '$label'.text.bold.color(fontGrey).size(16.0).makeCentered()
      .box.color(lightGrey).size(100, 100).roundedSM.make();
}