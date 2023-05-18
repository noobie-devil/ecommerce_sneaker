import 'package:ecommerce_sneaker/constants/admin/const.dart';
import 'text_style.dart';
Widget dashboardButton(context, {title, count, icon}){
  var size = MediaQuery.of(context).size;
  return  Row(
    children: [
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            boldText(text: title),
            boldText(text: count, size: 20.0)
          ],
        ),
      ),
      Image.network(icon, width: 40, color: white),
    ],
  ).box.color(purpleColor)
      .rounded.size(size.width * 0.4, 80)
      .padding(EdgeInsets.all(8))
      .make()
      ;

}