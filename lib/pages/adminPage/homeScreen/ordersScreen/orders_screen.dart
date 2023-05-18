import 'package:ecommerce_sneaker/constants/admin/const.dart';
import 'package:ecommerce_sneaker/widgets/admin/dashboard_button.dart';
import 'package:ecommerce_sneaker/widgets/admin/text_style.dart';
import 'package:intl/intl.dart' as intl;
class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        title: boldText(text: products, color: darkGrey, size: 16.0),
        actions: [
          Center(
            child: boldText(text: intl.DateFormat('EEE, MMM d, ''yy').format(
                DateTime.now()),
                color: purpleColor),
          ),
          10.widthBox,
        ],
      ),
    );
  }
}
