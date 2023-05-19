import 'package:auto_size_text/auto_size_text.dart';
import 'package:ecommerce_sneaker/controllers/sign_up_controller.dart';
import 'package:ecommerce_sneaker/widgets/common/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({Key? key}) : super(key: key);
  final SignUpController signUpController = Get.put(SignUpController());

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        title: const AutoSizeText(
          "Sign Up",
          minFontSize: 24,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            // decoration: const BoxDecoration(
            //     gradient: LinearGradient(colors: [
            //   Color(0xFF8A54FE),
            //   Color(0xff7691F3),
            //   Color(0xff5CDFE6),
            // ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
            child: SingleChildScrollView(
                child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(
                children: <Widget>[
                  StreamBuilder(
                    stream: widget.signUpController.usernameSubject,
                    builder: (context, snapshot) => primaryTextFormField(
                        "Username",
                        Icons.person_outline,
                        TextInputType.text,
                        snapshot,
                        (value) =>
                            widget.signUpController.usernameSink.add(value)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  StreamBuilder(
                      stream: widget.signUpController.emailSubject,
                      builder: (context, snapshot) => primaryTextFormField(
                          "Email",
                          Icons.email_outlined,
                          TextInputType.emailAddress,
                          snapshot,
                          (value) =>
                              widget.signUpController.emailSink.add(value))),
                  const SizedBox(
                    height: 20,
                  ),
                  StreamBuilder(
                      stream: widget.signUpController.passwordSubject,
                      builder: (context, snapshot) => primaryTextFormField(
                          "Password",
                          Icons.lock_outlined,
                          TextInputType.visiblePassword,
                          snapshot,
                              (value) =>
                              widget.signUpController.passwordSink.add(value))),
                  const SizedBox(
                    height: 20,
                  ),
                  StreamBuilder(
                      stream: widget.signUpController.confirmPasswordSubject,
                      builder: (context, snapshot) => primaryTextFormField(
                          "Confirm password",
                          Icons.lock_outlined,
                          TextInputType.visiblePassword,
                          snapshot,
                              (value) =>
                              widget.signUpController.confirmPasswordSink.add(value))),
                  Container(
                    width: Get.size.width,
                    height: 50,
                    margin: const EdgeInsets.fromLTRB(0, 40, 0, 20),
                    child: Obx(() => ElevatedButton(
                        onPressed: widget.signUpController.isFormValid.value ? () {
                          FocusScope.of(context).unfocus();
                          widget.signUpController.signUpHandler(); } : null,
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))
                        ),
                        child: const AutoSizeText("Sign up"),
                      ),
                    ),
                  )
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  // reusableTextField("UserName", Icons.person_outline, false,
                  //     _userNameTextController),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  // reusableTextField(
                  //     "Email", Icons.person_outline, false, _emailTextController),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  // reusableTextField("Password", Icons.lock_outlined, true,
                  //     _passwordTextController),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  // reusableTextField("Confirm password", Icons.lock_outlined, true,
                  //     _passwordTextController),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  // firebaseUIButton(context, "Sign Up", () {
                  //   FirebaseAuth.instance
                  //       .createUserWithEmailAndPassword(
                  //           email: _emailTextController.text,
                  //           password: _passwordTextController.text)
                  //       .then((value) {
                  //     print("Created New Account");
                  //     Navigator.push(context,
                  //         MaterialPageRoute(builder: (context) => HomePage()));
                  //   }).onError((error, stackTrace) {
                  //     print("Error ${error.toString()}");
                  //   });
                  // })
                ],
              ),
            ))),
      ),
    );
  }
}
