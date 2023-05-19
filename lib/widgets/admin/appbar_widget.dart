import 'package:ecommerce_sneaker/constants/admin/const.dart';
import 'package:ecommerce_sneaker/widgets/admin/dashboard_button.dart';
import 'package:ecommerce_sneaker/widgets/admin/text_style.dart';
import 'package:intl/intl.dart' as intl;

AppBar appbarWidget(title){
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0.0,
    automaticallyImplyLeading: false,
    title: boldText(text: title, color: darkGrey, size: 16.0),
    actions: [
      Center(
        child: boldText(text: intl.DateFormat('EEE, MMM d, ''yy').format(
        DateTime.now()),
        color: purpleColor),
      ),
      10.widthBox,
    ],
  );
}