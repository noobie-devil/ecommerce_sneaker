import 'package:ecommerce_sneaker/pages/adminPage/homeScreen/home.dart';
import 'package:ecommerce_sneaker/pages/auth/login_screen.dart';
import 'package:ecommerce_sneaker/pages/home/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/sign_in_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: "Sneaker app",
    options: const FirebaseOptions(apiKey: "AIzaSyCXJN-D5g-IapLQjh-koC39yqHnmNoZHrY", appId: "1:203061677786:android:375ffa171da0775fbcdfe3", messagingSenderId: "", projectId: "sneakerstore-ec4f7")
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
            return HomeAdmin();
          } else {
            return LoginScreen(signInController: signInController,);
          }
        },
      ),
    );
  }
}

