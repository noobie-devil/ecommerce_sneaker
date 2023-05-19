import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class SignUpController extends GetxController {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final _emailSubject = BehaviorSubject<String>.seeded('');
  final _usernameSubject = BehaviorSubject<String>.seeded('');
  final _passwordSubject = BehaviorSubject<String>.seeded('');
  final _confirmPasswordSubject = BehaviorSubject<String>.seeded('');

  final RxBool isFormValid = false.obs;

  get usernameSubject => _usernameSubject.stream;

  get emailSubject => _emailSubject.stream;

  get passwordSubject => _passwordSubject.stream;

  get confirmPasswordSubject => _confirmPasswordSubject.stream;

  Sink<String> get usernameSink => _usernameSubject.sink;

  Sink<String> get emailSink => _emailSubject.sink;

  Sink<String> get passwordSink => _passwordSubject.sink;

  Sink<String> get confirmPasswordSink => _confirmPasswordSubject.sink;

  Stream<bool> get isFormValidStream => CombineLatestStream.combine4(
          _usernameSubject.stream,
          _emailSubject.stream,
          _passwordSubject.stream,
          _confirmPasswordSubject.stream,
          (username, email, password, confirmPassword) {
        final emailValid = validateEmail(email) == null;
        final usernameValid = validateRequired(username) == null;
        final passwordValid = validatePassword(password) == null;
        final confirmPasswordValid =
            validateConfirmPassword(confirmPassword) == null;
        return emailValid &&
            usernameValid &&
            passwordValid &&
            confirmPasswordValid;
      });

  @override
  void onInit() {
    // TODO: implement onInit
    _usernameSubject.skip(1).listen((event) {
      final error = validateRequired(event);
      if (error != null) {
        _usernameSubject.addError(error);
      }
    });
    _emailSubject.skip(1).listen((event) {
      final error = validateEmail(event);
      if (error != null) {
        _emailSubject.addError(error);
      }
    });
    _passwordSubject.skip(1).listen((event) {
      final error = validatePassword(event);
      if(error != null) {
        _passwordSubject.addError(error);
      }
    });
    _confirmPasswordSubject.skip(1).listen((event) {
      final error = validateConfirmPassword(event);
      if(error != null) {
        _confirmPasswordSubject.addError(error);
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
    _usernameSubject.close();
    _emailSubject.close();
    _passwordSubject.close();
    _confirmPasswordSubject.close();
    super.onClose();
  }

  Future<void> signUpHandler() async {
    final email = _emailSubject.value;
    final username = _usernameSubject.value;
    final password = _passwordSubject.value;
    Get.dialog(
        const Center(
          child: CircularProgressIndicator(),
        ),
        barrierDismissible: false);
    final emailExists = await _auth
        .fetchSignInMethodsForEmail(email)
        .then((value) => value.isNotEmpty);
    if (emailExists) {
      // throw Exception("Email already registered");
      Get.back();
      Get.snackbar("Registration Failed", "Email already registered",
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2));
      return;
    }
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final uid = userCredential.user?.uid;
      if (uid == null) {
        Get.back();
        Get.snackbar("Registration Failed",
            "An error occurred during registration. Please try again later.",
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 2));
        return;
      }

      final userRef = _fireStore.collection("User").doc(uid);
      final data = {'username': username, 'email': email, 'role': 'user'};
      await userRef.set(data);
      Get.back();
      Get.back();
      Get.snackbar(
          "Registration Successful", "Your account has been registered!",
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2));
    } on FirebaseAuthException catch (e) {
      Get.back();
      Get.snackbar("Registration Failed", e.message ?? "Unknown Error",
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2));
    }
  }

  bool isValidEmail(String email) {
    String value =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = RegExp(value);

    return regExp.hasMatch(email);
  }

  String? validateRequired(String? value) {
    if (value == null || value.isEmpty) {
      return "This field is required";
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "This field is required";
    } else if (value.trim().length < 8) {
      return "Password must be greater than 8 characters";
    }
    if (_confirmPasswordSubject.value.trim().isNotEmpty) {
      final confirmPassword = _confirmPasswordSubject.value;
      if (value.isNotEmpty) {
        if (confirmPassword != value) {
          _confirmPasswordSubject.addError("Password do not match");
        } else {
          _confirmPasswordSubject.addError("");
        }
      }
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value != null && value != _passwordSubject.value) {
      return "Password do not match";
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "This field is required";
    } else if (!isValidEmail(value)) {
      return "This email is invalid";
    }
    return null;
  }

}
