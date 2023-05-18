import 'package:ecommerce_sneaker/constants/admin/const.dart';
import 'package:ecommerce_sneaker/widgets/admin/dashboard_button.dart';
import 'package:ecommerce_sneaker/widgets/admin/text_style.dart';
import 'package:intl/intl.dart' as intl;
class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){

        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        title: boldText(text: products, color: darkGrey, size: 16.0),
        actions: [
          Center(
            child: boldText(text: intl.DateFormat('EEE, MMM d, ''yy').format(
                DateTime.now()),
                color: purpleColor),
          ),
          10.widthBox,
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(15, (index) => ListTile(
                onTap:() {
                },
                leading: Container(
                  width: 100, // Điều chỉnh kích thước hình ảnh theo ý muốn
                  height: 100,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1.0), // Đặt border cho container
                    borderRadius: BorderRadius.circular(25), // Điều chỉnh bo tròn viền theo ý muốn
                  ),
                  child: Image.asset('assets/shoes_1.png', width: 100, height: 100, fit: BoxFit.contain,),
                ),
                // leading: Image.asset('assets/shoes_1.png', width: 100, height: 100, fit: BoxFit.contain,),
                title: boldText(text: 'Product title', color: darkGrey),
                subtitle: normalText(text: 'description here to show the detail!', color: darkGrey),
              ),
            ),
          ),
        ),
      )
    );
  }
}
