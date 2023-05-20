import 'package:ecommerce_sneaker/constants/admin/const.dart';
import 'package:ecommerce_sneaker/pages/adminPage/homeScreen/messagesScreen/MessagesScreen.dart';
import 'package:ecommerce_sneaker/pages/adminPage/homeScreen/settingsScreen/edit_profile_screen.dart';
import 'package:ecommerce_sneaker/widgets/admin/appbar_widget.dart';
import 'package:ecommerce_sneaker/widgets/admin/dashboard_button.dart';
import 'package:ecommerce_sneaker/widgets/admin/text_style.dart';
import 'package:intl/intl.dart' as intl;
import 'package:get/get.dart';

import '../../../../utils.dart';
import '../shopScreen/shop_settings_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: purpleColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        title: boldText(text: settings, size: 16.0),
        actions: [
          IconButton(
              onPressed: (){
                Get.to(() => EditProfileScreen());
              },
              icon: const Icon(Icons.edit)
          ),
          TextButton(onPressed:  () async {
            await signOut();

          }, child: normalText(text: logout))
        ],
      ),
      body: Column(
        children: [
          ListTile(
            leading: Image.network(icAdmin).box.roundedFull.clip(Clip.antiAlias).make(),
            title: boldText(text: 'Admin'),
            subtitle: normalText(text: 'admin@ttshoesstore.com'),
          ),
          const Divider(),
          10.heightBox,
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: List.generate(
                profileButtonTitles.length,
                  (index) => ListTile(
                    onTap: (){
                      switch(index){
                        case 0:
                          Get.to(ShopSettingsScreen());
                          break;
                        case 1:
                          Get.to(MessagesScreen());
                          break;
                      }

                    },
                    leading: Icon(profileButtonIcons[index], color: white,),
                    title: normalText(text: profileButtonTitles[index]),
                  ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
