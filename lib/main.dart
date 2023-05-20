import 'package:ecommerce_sneaker/constants/admin/const.dart';
import 'package:ecommerce_sneaker/models/models.dart' as models;
import 'package:ecommerce_sneaker/pages/adminPage/homeScreen/home.dart';
import 'package:ecommerce_sneaker/pages/auth/login_screen.dart';
import 'package:ecommerce_sneaker/pages/home/home_page.dart';
import 'package:ecommerce_sneaker/shared_preferences_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/sign_in_controller.dart';


late final SharedPreferencesManager preferencesManager;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: "Sneaker app",
    options: const FirebaseOptions(apiKey: "AIzaSyCXJN-D5g-IapLQjh-koC39yqHnmNoZHrY", appId: "1:203061677786:android:375ffa171da0775fbcdfe3", messagingSenderId: "", projectId: "sneakerstore-ec4f7")
  );
  preferencesManager = await SharedPreferencesManager.instance;
  runApp(MyApp());
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     final SignInController signInController = Get.put(SignInController());
//
//     return GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blueGrey,
//       ),
//       // home: const HomePage(),
//       home: StreamBuilder(
//         stream: FirebaseAuth.instance.authStateChanges(),
//         builder: (context, snapshot) {
//           print("authStateChanges with snapshot: ${snapshot.data}");
//           if(snapshot.connectionState == ConnectionState.waiting) {
//             return const CircularProgressIndicator();
//           }
//           if (snapshot.hasData && signInController.isSignedIn.isTrue) {
//             final user = prefe
//             final user = models.User.fromSnapshot(snapshot);
//             return HomeAdmin();
//           } else {
//             return LoginScreen(signInController: signInController,);
//           }
//         },
//       ),
//     );
//   }
// }

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);
  // late final SharedPreferencesManager preferencesManager;
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {



  @override
  Widget build(BuildContext context) {
    final SignInController signInController = Get.put(SignInController());

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      // home: const HomePage(),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          print("authStateChanges with snapshot: ${snapshot.data}");
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          if (snapshot.hasData && signInController.isSignedIn.isTrue) {
            final user = preferencesManager.getCurrentUser();
            if(user != null) {
              if(user.role == 'admin') {
                print(user.toJson());
                return const HomeAdmin();
              } else {
                return HomePage();
              }
            } else {
              print('user is null');
              return HomePage();
            }
          } else {
            return LoginScreen(signInController: signInController,);
          }
        },
      ),
    );
  }

  // @override
  // Future<void> initState() {
  //   // widget.preferencesManager = await SharedPreferencesManager.instance;
  //   super.initState();
  // }
}


