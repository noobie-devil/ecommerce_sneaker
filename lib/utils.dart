
import 'dart:convert';

import 'package:ecommerce_sneaker/controllers/sign_in_controller.dart';
import 'package:ecommerce_sneaker/main.dart';
import 'package:ecommerce_sneaker/pages/auth/login_screen.dart';
import 'package:ecommerce_sneaker/shared_preferences_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/models.dart' as model;

Future<void> saveUser(model.User user) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String userJson = jsonEncode(user.toJson());
  await prefs.setString('current_user', userJson);
}

Future<model.User?> getCurrentUser() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? userJson = prefs.getString('current_user');
  if(userJson != null) {
    final Map<String, dynamic> userMap = jsonDecode(userJson);
    return model.User.fromJson(userMap);
  }
  return null;
}

Future<bool> existsCurrentUser() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final bool exists = prefs.containsKey('current_user');
  return exists;
}

Future<void> signOut() async {
  await FirebaseAuth.instance.signOut().then((value) async {
    final prefs = await SharedPreferencesManager.instance;
    prefs.clear();
    Get.offAll(() => LoginScreen(signInController: Get.put(SignInController())));
  }, onError: (error) {
    print('Error signing out: $error');
  });
}

