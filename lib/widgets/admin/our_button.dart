import 'package:ecommerce_sneaker/constants/admin/const.dart';
import 'text_style.dart';
Widget ourButton({title, color = purpleColor , onPress}){
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      primary: color,
      padding: EdgeInsets.all(12.0)
    ),
      onPressed: onPress,
      child: boldText(text: title, size: 16.0)
  );
}