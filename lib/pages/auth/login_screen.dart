import 'package:auto_size_text/auto_size_text.dart';
import 'package:ecommerce_sneaker/controllers/sign_in_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/common/common_widgets.dart';
import 'signup_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key, required this.signInController}) : super(key: key);
  final SignInController signInController;

  Row signUpOption(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const AutoSizeText(
          "Don't have account?",
          // style: TextStyle(color: Colors.white70)
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignupScreen()));
          },
          child: const AutoSizeText(
            " Sign Up",

            style: TextStyle(
                color: Colors.blueGrey, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  Widget forgetPassword(BuildContext context) {
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width,
      height: 35,
      alignment: Alignment.bottomRight,
      child: TextButton(
          child: const Text(
            "Forgot Password?",
            // style: TextStyle(color: Colors.white70),
            textAlign: TextAlign.right,
          ),
          onPressed: () {}
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => ResetPassword())
        // ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery
              .of(context)
              .size
              .width,
          height: MediaQuery
              .of(context)
              .size
              .height,
          // decoration: const BoxDecoration(
          //     gradient: LinearGradient(colors: [
          //       Color(0xFF8A54FE),
          //       Color(0xff7691F3),
          //       Color(0xff5CDFE6),
          //     ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  20, Get.size.height * 0.1, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Image.asset(
                    "assets/logo.png",
                    fit: BoxFit.cover,
                    height: Get.size.height * 0.3,
                  ),
                  const SizedBox(height: 30,),
                  // Image.network(
                  //   'https://firebasestorage.googleapis.com/v0/b/sneakerstore-ec4f7.appspot.com/o/splashscreen-removebg.png?alt=media&token=6a9418ca-8eb3-4cad-a664-44573a008a97',
                  //   fit: BoxFit.fitWidth,
                  //   width: 300,
                  //   height: 300,
                  // ),
                  StreamBuilder(
                    stream: signInController.emailSubject,
                    builder: (context, snapshot) => primaryTextFormField(
                      "Email",
                      Icons.person_outline,
                      TextInputType.emailAddress,
                      snapshot,
                      (value) => signInController.emailSink.add(value)
                    ),
                  ),
                  const SizedBox(height: 20,),
                  StreamBuilder(
                      stream: signInController.passwordSubject,
                      builder: (context, snapshot) => primaryTextFormField(
                          "Password",
                          Icons.lock_outlined,
                          TextInputType.visiblePassword,
                          snapshot,
                              (value) =>
                              signInController.passwordSink.add(value))),
                  const SizedBox(
                    height: 20,
                  ),
                  // reusableTextField("Enter UserName", Icons.person_outline, false,
                  //     _emailTextController),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  // reusableTextField("Enter Password", Icons.lock_outline, true,
                  //     _passwordTextController),
                  // const SizedBox(
                  //   height: 5,
                  // ),
                  forgetPassword(context),
                  Container(
                    width: Get.size.width,
                    height: 50,
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                    child: Obx(() => ElevatedButton(
                        onPressed: signInController.isFormValid.value ? () {
                          FocusScope.of(context).unfocus();
                          signInController.signInHandler();
                        }: null,
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))
                        ),
                        child: const AutoSizeText(
                          "Sign In",
                          minFontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  // firebaseUIButton(context, "Sign In", () {
                  //   FirebaseAuth.instance
                  //       .signInWithEmailAndPassword(
                  //       email: _emailTextController.text,
                  //       password: _passwordTextController.text)
                  //       .then((value) {
                  //     print(value);
                  //     Navigator.push(context,
                  //         MaterialPageRoute(builder: (context) => HomePage()));
                  //   }).onError((error, stackTrace) {
                  //     print("Error ${error.toString()}");
                  //   });
                  // }),
                  signUpOption(context)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//
// class LoginScreen extends StatefulWidget {
//   const LoginScreen({Key? key}) : super(key: key);
//
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Container(
//           width: MediaQuery
//               .of(context)
//               .size
//               .width,
//           height: MediaQuery
//               .of(context)
//               .size
//               .height,
//           // decoration: const BoxDecoration(
//           //     gradient: LinearGradient(colors: [
//           //       Color(0xFF8A54FE),
//           //       Color(0xff7691F3),
//           //       Color(0xff5CDFE6),
//           //     ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
//           child: SingleChildScrollView(
//             child: Padding(
//               padding: EdgeInsets.fromLTRB(
//                   20, Get.size.height * 0.1, 20, 0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: <Widget>[
//                   Image.asset(
//                     "assets/logo.png",
//                     fit: BoxFit.cover,
//                     height: Get.size.height * 0.3,
//                   ),
//                   const SizedBox(height: 30,),
//                   // Image.network(
//                   //   'https://firebasestorage.googleapis.com/v0/b/sneakerstore-ec4f7.appspot.com/o/splashscreen-removebg.png?alt=media&token=6a9418ca-8eb3-4cad-a664-44573a008a97',
//                   //   fit: BoxFit.fitWidth,
//                   //   width: 300,
//                   //   height: 300,
//                   // ),
//
//                   TextFormField(
//                     decoration: InputDecoration(
//                       prefixIcon: const Icon(
//                         Icons.person_outline,
//                       ),
//                       filled: true,
//                       labelText: "Username",
//                       floatingLabelBehavior: FloatingLabelBehavior.never,
//                       enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(30),
//                           borderSide: const BorderSide(
//                               width: 0, style: BorderStyle.none)
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(30),
//                           borderSide: const BorderSide(
//                               width: 2, style: BorderStyle.solid, color: Colors
//                               .blueGrey)
//                       ),
//                     ),
//                     keyboardType: TextInputType.text,
//                   ),
//                   const SizedBox(height: 20,),
//                   TextFormField(
//                     decoration: InputDecoration(
//                       prefixIcon: const Icon(
//                         Icons.lock_outline,
//                       ),
//                       filled: true,
//                       labelText: "Password",
//                       floatingLabelBehavior: FloatingLabelBehavior.never,
//                       enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(30),
//                           borderSide: const BorderSide(
//                               width: 0, style: BorderStyle.none)
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(30),
//                           borderSide: const BorderSide(
//                               width: 2, style: BorderStyle.solid, color: Colors
//                               .blueGrey)
//                       ),
//                     ),
//                     keyboardType: TextInputType.text,
//                     obscureText: true,
//                   ),
//
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   // reusableTextField("Enter UserName", Icons.person_outline, false,
//                   //     _emailTextController),
//                   // const SizedBox(
//                   //   height: 20,
//                   // ),
//                   // reusableTextField("Enter Password", Icons.lock_outline, true,
//                   //     _passwordTextController),
//                   // const SizedBox(
//                   //   height: 5,
//                   // ),
//                   forgetPassword(context),
//                   Container(
//                     width: Get.size.width,
//                     height: 50,
//                     margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
//                     child: ElevatedButton(
//                       onPressed: () {},
//                       style: ElevatedButton.styleFrom(
//                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))
//                       ),
//                       child: const AutoSizeText(
//                           "Sign In",
//                         minFontSize: 16,
//                       ),
//                     ),
//                   ),
//                   // firebaseUIButton(context, "Sign In", () {
//                   //   FirebaseAuth.instance
//                   //       .signInWithEmailAndPassword(
//                   //       email: _emailTextController.text,
//                   //       password: _passwordTextController.text)
//                   //       .then((value) {
//                   //     print(value);
//                   //     Navigator.push(context,
//                   //         MaterialPageRoute(builder: (context) => HomePage()));
//                   //   }).onError((error, stackTrace) {
//                   //     print("Error ${error.toString()}");
//                   //   });
//                   // }),
//                   signUpOption()
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Row signUpOption() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         const AutoSizeText(
//           "Don't have account?",
//           // style: TextStyle(color: Colors.white70)
//         ),
//         GestureDetector(
//           onTap: () {
//             Navigator.push(context,
//                 MaterialPageRoute(builder: (context) => SignupScreen()));
//           },
//           child: const AutoSizeText(
//             " Sign Up",
//
//             style: TextStyle(
//                 color: Colors.blueGrey, fontWeight: FontWeight.bold),
//           ),
//         )
//       ],
//     );
//   }
//
//   Widget forgetPassword(BuildContext context) {
//     return Container(
//       width: MediaQuery
//           .of(context)
//           .size
//           .width,
//       height: 35,
//       alignment: Alignment.bottomRight,
//       child: TextButton(
//           child: const Text(
//             "Forgot Password?",
//             // style: TextStyle(color: Colors.white70),
//             textAlign: TextAlign.right,
//           ),
//           onPressed: () {}
//         // Navigator.push(
//         //     context, MaterialPageRoute(builder: (context) => ResetPassword())
//         // ),
//       ),
//     );
//   }
// }