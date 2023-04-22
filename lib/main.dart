import 'package:ecommerce_sneaker/pages/auth/login_screen.dart';
import 'package:ecommerce_sneaker/pages/home/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'pages/splash_creen.dart';

import 'constants/strings.dart';
//Thanh
import 'package:get/get_navigation/src/root/get_material_app.dart';

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
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const HomePage(),
      // home: const LoginScreen(),
    );
  }
}

