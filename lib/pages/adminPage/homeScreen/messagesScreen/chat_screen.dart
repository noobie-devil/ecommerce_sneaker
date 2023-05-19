import 'package:ecommerce_sneaker/constants/admin/const.dart';
import 'package:ecommerce_sneaker/widgets/admin/appbar_widget.dart';
import 'package:ecommerce_sneaker/widgets/admin/dashboard_button.dart';
import 'package:ecommerce_sneaker/widgets/admin/text_style.dart';
import 'package:intl/intl.dart' as intl;
import 'package:get/get.dart';

import 'component/chat_bubble.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

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
        title: boldText(text: "Chats", size: 16.0, color: fontGrey),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
                child:ListView.builder(
                  itemCount: 20,
                  itemBuilder: (
                      (context, index){
                        return chatBubble();
                      }
                  ),
                ),
            ),
            10.heightBox,
            SizedBox(
              height: 60,
              child: Row(
                children: [
                  Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          isDense: true,
                          hintText: 'Enter message',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: purpleColor
                            )
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: purpleColor
                              )
                          )
                        ),
                      ),
                  ),
                  IconButton(
                      onPressed: (){},
                      icon: Icon(Icons.send), color: purpleColor,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
