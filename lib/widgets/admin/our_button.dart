import 'package:ecommerce_sneaker/constants/admin/const.dart';
import 'text_style.dart';
Widget outButton({title, color = purpleColor , onPress}){
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      primary: color,
      padding: EdgeInsets.all(12)
    ),
      onPressed: onPress,
      child: boldText(text: title, size: 16));
}