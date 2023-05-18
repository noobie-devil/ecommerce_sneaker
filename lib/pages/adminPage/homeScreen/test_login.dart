import 'package:ecommerce_sneaker/constants/admin/const.dart';
import 'package:ecommerce_sneaker/widgets/admin/text_style.dart';

class TestLoginScreen extends StatelessWidget {
  const TestLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: purpleColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              30.heightBox,
              normalText(text: 'welcome')
            ],
          ),
        ),
      ),
    );
  }
}
