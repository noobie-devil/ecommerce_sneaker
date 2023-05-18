import 'package:ecommerce_sneaker/constants/admin/const.dart';
import 'package:ecommerce_sneaker/widgets/admin/dashboard_button.dart';
import 'package:ecommerce_sneaker/widgets/admin/text_style.dart';
import 'package:intl/intl.dart' as intl;
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        title: boldText(text: dashboard, color: darkGrey, size: 16.0),
        actions: [
          Center(
            child: boldText(text: intl.DateFormat('EEE, MMM d, ''yy').format(DateTime.now()),
                color: purpleColor),
          ),
          10.widthBox,
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                dashboardButton(context, title: products, count: '75', icon: icProduct),
                dashboardButton(context, title: orders, count: '100', icon: icOrder),
              ],
            ),
            10.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                dashboardButton(context, title: 'Users', count: '75' , icon: icProduct),
                dashboardButton(context, title: 'Total Sales', count: '100', icon: icProduct),
              ],
            ),
            10.heightBox,
            const Divider(

            ),
            10.heightBox,
            boldText(text: popularProduct, color: fontGrey, size: 16.0),
            20.heightBox,
            Expanded(
              child: Container(
                color: Colors.black12,
                // constraints: BoxConstraints(
                //   maxHeight: 300, // Đặt chiều cao tối đa cho Container
                // ),
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: List.generate(15, (index) => ListTile(
                    onTap:() {

                    },
                    leading: Container(
                      width: 100, // Điều chỉnh kích thước hình ảnh theo ý muốn
                      height: 100,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1.0), // Đặt border cho container
                        borderRadius: BorderRadius.circular(25), // Điều chỉnh bo tròn viền theo ý muốn
                      ),
                      child: Image.asset('assets/shoes_1.png', width: 100, height: 100, fit: BoxFit.contain,),
                    ),
                    // leading: Image.asset('assets/shoes_1.png', width: 100, height: 100, fit: BoxFit.contain,),
                    title: boldText(text: 'Product title', color: darkGrey),
                    subtitle: normalText(text: 'description here to show the detail!', color: darkGrey),
                  )
                  )
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
