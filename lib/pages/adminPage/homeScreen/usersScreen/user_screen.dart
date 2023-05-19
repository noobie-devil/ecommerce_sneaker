import 'package:ecommerce_sneaker/constants/admin/const.dart';
import 'package:ecommerce_sneaker/controllers/admin/users_controller.dart';
import 'package:ecommerce_sneaker/widgets/admin/appbar_widget.dart';
import 'package:ecommerce_sneaker/widgets/admin/text_style.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../controllers/admin/home_controller.dart';
class UserScreen extends StatelessWidget {
  const UserScreen({Key? key}) : super(key: key);

  void searchUsers(String query) {
  }

  @override
  Widget build(BuildContext context) {
    print('rebuild');
    final UsersController _userController = Get.put(UsersController());
    _userController.fetchUsers();

    String searchQuery = '';
    return Scaffold(
      appBar: appbarWidget(usersTitle),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: searchUsers,
                    decoration: InputDecoration(
                      labelText: 'Search...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                ElevatedButton(
                  onPressed: () {
                    // Xử lý khi nhấn nút tìm kiếm
                  },
                  child: Icon(Icons.search),
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(()=> ListView.builder(
              itemCount: _userController.users.length,
              itemBuilder: (context, index) {
                final user = _userController.users[index];
                // print(user.name);
                return ListTile(
                  title: Text(user.name),
                  subtitle: Text(user.email),
                  trailing: Obx(()=> Switch(
                    value: user.enabled,
                    onChanged: (value) {
                      print('switch $value');
                      user.enabled = value;
                      print('${user.enabled}');
                    },
                  )),
                );
              },

            )),
          ),
        ],
      ),
    );
  }
}

