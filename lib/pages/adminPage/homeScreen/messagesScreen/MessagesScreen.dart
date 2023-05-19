import 'package:ecommerce_sneaker/constants/admin/const.dart';
import 'package:ecommerce_sneaker/pages/adminPage/homeScreen/messagesScreen/chat_screen.dart';
import 'package:ecommerce_sneaker/widgets/admin/appbar_widget.dart';
import 'package:ecommerce_sneaker/widgets/admin/dashboard_button.dart';
import 'package:ecommerce_sneaker/widgets/admin/text_style.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: darkGrey,),
          onPressed: () {
            Get.back();
          },
        ),
        title: boldText(text: messages, size: 16.0, color: fontGrey),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
            child: Column(
              children: List.generate(
                20, (index)=>ListTile(
                onTap: () {
                  Get.to(ChatScreen());
                },
                leading: const CircleAvatar(
                  backgroundColor: purpleColor,
                  child: Icon(
                      Icons.person,
                    color: white,
                  ),
                ),
                title: boldText(text: 'username', color: fontGrey),
                subtitle: normalText(text: 'Last message...', color: darkGrey),
                trailing: normalText(text: '10:45PM', color: darkGrey),
                ),
              ),
            ),
        ),
      ),
    );
  }
}
