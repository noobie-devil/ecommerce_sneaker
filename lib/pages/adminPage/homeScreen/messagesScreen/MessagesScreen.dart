import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_sneaker/constants/admin/const.dart';
import 'package:ecommerce_sneaker/pages/adminPage/homeScreen/messagesScreen/chat_screen.dart';
import 'package:ecommerce_sneaker/service/admin/store_service.dart';
import 'package:ecommerce_sneaker/widgets/admin/appbar_widget.dart';
import 'package:ecommerce_sneaker/widgets/admin/dashboard_button.dart';
import 'package:ecommerce_sneaker/widgets/admin/loading_indicator.dart';
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
      body: StreamBuilder(
        stream: StoreService.getMessages(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData){
            return loadingIndicator();
          }else {
            var data = snapshot.data!.docs;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: List.generate(
                    data.length, (index) {
                      var time = intl.DateFormat("h:mma").format(data[index]['created_on'].toDate());
                      return ListTile(
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
                        title: boldText(text:"${data[index]['sender_name']}", color: fontGrey),
                        subtitle: normalText(text: "${data[index]['last_msg']}", color: darkGrey),
                        trailing: normalText(text: time, color: darkGrey),
                      );
                  }
                  ),
                ),
              ),
            );
          }
        },
      ),
      /*body: Padding(
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
      ),*/
    );
  }
}
