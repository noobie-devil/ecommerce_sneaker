import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'auth/login_screen.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  //creating method to change sreen
  changeScreen(){
    Future.delayed(Duration(seconds: 3), (){
      Get.to(() => LoginScreen());
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    changeScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.blueGrey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: NetworkImage('https://firebasestorage.googleapis.com/v0/b/sneakerstore-ec4f7.appspot.com/o/splashscreen.png?alt=media&token=6a9418ca-8eb3-4cad-a664-44573a008a97'),
              width: 300,
              height: 300,
            ),

          ],
        ),
      ),
    );
  }
}