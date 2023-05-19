import 'package:ecommerce_sneaker/constants/admin/const.dart';

Widget loadingIndicator({Color circleColor = purpleColor}) {
  return Center(
    child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(circleColor),
    ),
  );
}