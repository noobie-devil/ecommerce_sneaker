import 'package:ecommerce_sneaker/constants/admin/const.dart';
import 'package:ecommerce_sneaker/pages/adminPage/homeScreen/ordersScreen/order_detail_screen.dart';
import 'package:ecommerce_sneaker/widgets/admin/appbar_widget.dart';
import 'package:ecommerce_sneaker/widgets/admin/dashboard_button.dart';
import 'package:ecommerce_sneaker/widgets/admin/text_style.dart';
import 'package:intl/intl.dart' as intl;
import 'package:get/get.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarWidget(orders),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(15, (index) => ListTile(
            onTap:() {
              Get.to(()=> OrderDetailScreen());
            },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              tileColor: Colors.black12,
            title: boldText(text: 'MSD-252771-Airforce', color: purpleColor),
            subtitle: Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.calendar_month_rounded, color: fontGrey),
                    10.widthBox,
                    boldText(text: intl.DateFormat().add_yMd().format(DateTime.now()),
                        color: fontGrey),
                  ],
                ),

                Row(
                  children: [
                    Icon(Icons.payment, color: fontGrey),
                    10.widthBox,
                    boldText(text: unpaid,
                        color: red),
                  ],
                ),
              ],
            ),

              trailing: boldText(text: '\$40.0', color: purpleColor, size: 16.0),
            ).box.margin(const EdgeInsets.only(bottom: 4)).make(),
          ),
      ),
        ),
    )
    );
  }
}
