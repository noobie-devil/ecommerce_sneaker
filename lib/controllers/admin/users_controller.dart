import 'package:get/get.dart';
class UsersController extends GetxController {
  // final List<User> users = [
  //   User(name: 'John Doe', email: 'john.doe@example.com', enabled: true),
  //   User(name: 'Jane Smith', email: 'jane.smith@example.com', enabled: false),
  //   // Thêm các người dùng khác vào đây...
  // ];
  var users = <User>[
    User(name: 'John Doe', email: 'john.doe@example.com', enabled: true),
    User(name: 'Jane Smith', email: 'jane.smith@example.com', enabled: false),
    // Thêm các người dùng khác vào đây...
  ].obs;

  void fetchUsers() {
    // users.value = [
    //   User(name: 'John Doe', email: 'john.doe@example.com', enabled: true),
    //   User(name: 'Jane Smith', email: 'jane.smith@example.com', enabled: false),
    //   // Thêm các người dùng khác vào đây...
    // ];
  }
}

class User {
  String name;
  String email;
  RxBool _enabled;

  User({required this.name, required this.email, required bool enabled})
      : _enabled = RxBool(enabled);

  bool get enabled => _enabled.value;
  set enabled(bool value) => _enabled.value = value;
}