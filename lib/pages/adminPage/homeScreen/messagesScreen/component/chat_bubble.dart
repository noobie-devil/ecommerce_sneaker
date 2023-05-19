import 'package:ecommerce_sneaker/constants/admin/const.dart';
import 'package:ecommerce_sneaker/widgets/admin/appbar_widget.dart';
import 'package:ecommerce_sneaker/widgets/admin/dashboard_button.dart';
import 'package:ecommerce_sneaker/widgets/admin/text_style.dart';
import 'package:intl/intl.dart' as intl;

Widget chatBubble(){
  return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: purpleColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            normalText(text: 'Your messages here'),
            10.heightBox,
            normalText(text: '10:45PM'),
          ],
        ),
      ),
  );
}