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


class UserManagementPage extends StatefulWidget {
  @override
  _UserManagementPageState createState() => _UserManagementPageState();
}

class _UserManagementPageState extends State<UserManagementPage> {
  List<User> users = [
    User(name: 'John Doe', email: 'john.doe@example.com', enabled: true),
    User(name: 'Jane Smith', email: 'jane.smith@example.com', enabled: false),
    // Thêm các người dùng khác vào đây...
  ];

  List<User> filteredUsers = [];

  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    filteredUsers = users;
  }

  void searchUsers(String query) {
    setState(() {
      searchQuery = query;
      filteredUsers = users
          .where((user) =>
      user.name.toLowerCase().contains(query.toLowerCase()) ||
          user.email.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quản lý người dùng'),
      ),
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
                      labelText: 'Tìm kiếm',
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
            child: ListView.builder(
              itemCount: filteredUsers.length,
              itemBuilder: (context, index) {
                final user = filteredUsers[index];
                return ListTile(
                  title: Text(user.name),
                  subtitle: Text(user.email),
                  trailing: Switch(
                    value: user.enabled,
                    onChanged: (value) {
                      setState(() {
                        user.enabled = value;
                      });
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class User {
  final String name;
  final String email;
  bool enabled;

  User({
    required this.name,
    required this.email,
    required this.enabled,
  });
}