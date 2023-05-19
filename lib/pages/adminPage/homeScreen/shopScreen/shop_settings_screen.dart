import 'package:ecommerce_sneaker/constants/admin/const.dart';
import 'package:ecommerce_sneaker/pages/adminPage/homeScreen/settingsScreen/edit_profile_screen.dart';
import 'package:ecommerce_sneaker/widgets/admin/appbar_widget.dart';
import 'package:ecommerce_sneaker/widgets/admin/dashboard_button.dart';
import 'package:ecommerce_sneaker/widgets/admin/text_style.dart';
import 'package:intl/intl.dart' as intl;
import 'package:get/get.dart';

class ShopSettingsScreen extends StatelessWidget {
  const ShopSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: purpleColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: boldText(text: shopSettings, size: 16.0),
        actions: [
          // TextButton(onPressed:  (){}, child: normalText(text: save, color: fontGrey))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
