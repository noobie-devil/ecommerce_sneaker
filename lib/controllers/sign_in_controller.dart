import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_sneaker/pages/adminPage/homeScreen/home.dart';
import 'package:ecommerce_sneaker/shared_preferences_manager.dart';
import 'package:ecommerce_sneaker/models/models.dart' as model;
import 'package:ecommerce_sneaker/pages/home/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

import '../utils.dart';

class SignInController extends GetxController {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late final SharedPreferencesManager _preferencesManager;
  final _emailSubject = BehaviorSubject<String>.seeded('');
  final _passwordSubject = BehaviorSubject<String>.seeded('');
  final RxBool isSignedIn = true.obs;
  final RxBool isFormValid = false.obs;

  get emailSubject => _emailSubject.stream;

  get passwordSubject => _passwordSubject.stream;

  Sink<String> get emailSink => _emailSubject.sink;

  Sink<String> get passwordSink => _passwordSubject.sink;

  Stream<bool> get isFormValidStream => CombineLatestStream.combine2(
      _emailSubject.stream,
      _passwordSubject.stream,
          (email, password) {
        final emailValid = validateEmail(email) == null;
        final passwordValid = validatePassword(password) == null;
        return emailValid && passwordValid;
      });

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    _preferencesManager = await SharedPreferencesManager.instance;
    _emailSubject.skip(1).listen((event) {
      final error = validatePassword(event);
      if(error != null) {
        _emailSubject.addError(error);
      }
    });
    _passwordSubject.skip(1).listen((event) {
      final error = validatePassword(event);
      if(error != null) {
        _passwordSubject.addError(error);
      }
    });

    isFormValidStream.listen((isValid) {
      isFormValid.value = isValid;
    });

    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    _emailSubject.close();
    _passwordSubject.close();
    super.onClose();
  }

  Future<void> signInHandler() async {
    final email = _emailSubject.value;
    final password = _passwordSubject.value;
    Get.dialog(
      const Center(child: CircularProgressIndicator(),),
      barrierDismissible: false
    );
    try {
      isSignedIn.value = false;
      final userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      final uid = userCredential.user?.uid;
      if (uid == null) {
        Get.back();
        Get.snackbar(
          "Login Failed",
          "An error occurred during login. Please try again later.",
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
        );
        return;
      }
      final userRef = _fireStore.collection("User").doc(uid);
      final snapshot = await userRef.get();
      if(snapshot.exists) {
        final user = model.User.fromSnapshot(snapshot);
        bool saveResult = await _preferencesManager.saveUser(user);
        print("dont saveResult");
        if(saveResult) {
          print("back");
          Get.back();
          if(user.role == 'admin') {
            Get.offAll(() => const HomeAdmin());
          } else {
            Get.offAll(() => HomePage());
          }
          isSignedIn.value = true;
        } else {
          signOut();
          Get.snackbar(
            "Login Failed","Unknown Error",
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 2),
          );
        }
      } else {
        Get.back();
        Get.snackbar(
          "Login Failed",
          "User not found.",
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
        );
      }

    } on FirebaseAuthException catch(e) {
      Get.back();
      Get.snackbar(
        "Login Failed",
        e.message ?? "Unknown Error",
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    }
  }

  String? validateRequired(String? value) {
    if (value == null || value.isEmpty) {
      return "This field is required";
    }
    return null;
  }

  bool isValidEmail(String email) {
    String value =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = RegExp(value);

    return regExp.hasMatch(email);
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "This field is required";
    } else if (!isValidEmail(value)) {
      return "This email is invalid";
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "This field is required";
    } else if (value.trim().length < 8) {
      return "Password must be greater than 8 characters";
    }
    return null;
  }
}