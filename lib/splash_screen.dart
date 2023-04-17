
import 'package:ecommerce_sneaker/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {

  const SplashScreen({Key? key}): super(key: key);



  @override
  State<StatefulWidget> createState() => _SplashScreenState();

}


class _SplashScreenState extends State<SplashScreen> {


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // TODO: implement build
    return Scaffold(
      body: Container(
        color: MyColors.myOrange,
        child: Stack(
          children: [
            Positioned(
              bottom: -250,
              child: Container(
                width: size.width,
                height: size.width + 250,
                decoration: const BoxDecoration(
                  gradient: RadialGradient(
                    radius: 0.65,
                    colors: [
                      MyColors.myOrange,
                      MyColors.myBlack
                    ]
                  )
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                padding: const EdgeInsets.all(50),
                width: size.width,
              ),
            )
          ],
        ),
      ),
    );
  }

}