import 'package:ecommerce_sneaker/constants/admin/const.dart';
import 'package:ecommerce_sneaker/widgets/admin/appbar_widget.dart';
import 'package:ecommerce_sneaker/widgets/admin/custom_TextField.dart';
import 'package:ecommerce_sneaker/widgets/admin/dashboard_button.dart';
import 'package:ecommerce_sneaker/widgets/admin/text_style.dart';
import 'package:intl/intl.dart' as intl;

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: boldText(text: editProfile, size: 16.0, color: fontGrey),
        actions: [
          TextButton(onPressed:  (){}, child: normalText(text: save, color: fontGrey))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Image.network(icAdmin, width: 150,).box.roundedFull.clip(Clip.antiAlias).make(),
            10.heightBox,
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: white
              ),
              onPressed: () {},
              child: normalText(text: changeImage, color: fontGrey),
            ),
            10.heightBox,
            const Divider(color: white,),
            customTextField(label: nameHint),
            10.heightBox,
            customTextField(label: nameHint),
            10.heightBox,
            customTextField(label: nameHint),
          ],
        ),
      ),
    );
  }
}
