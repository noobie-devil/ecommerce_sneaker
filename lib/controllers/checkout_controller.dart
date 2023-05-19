import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../models/models.dart';
import '../shared_preferences_manager.dart';

class CheckoutController extends GetxController {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  late final SharedPreferencesManager _sharedPreferencesManager;
  late final User? currentUser;
  late StreamSubscription<QuerySnapshot<Map<String, dynamic>>> listener;
  final Rx<DeliveryAddress?> defaultAddress = null.obs;



  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    _sharedPreferencesManager = await SharedPreferencesManager.instance;
    currentUser = _sharedPreferencesManager.getCurrentUser();
    print(currentUser!.uid);
    initListener(currentUser!.uid);
    super.onInit();
  }

  Future<void> initListener(String? documentId) async {
    listener = _fireStore
        .collection("User")
        .doc(documentId)
        .collection("DeliveryAddress")
        .where("is_default", isEqualTo: true)
        .snapshots()
        .listen((event) {
      if(event.docs.isNotEmpty) {
        print(event.docs.first.toString());
        print(event.docs.length);
        final DeliveryAddress? deliveryAddress = DeliveryAddress.fromSnapshot(event.docs.first);
        defaultAddress.value = deliveryAddress;
        print(deliveryAddress.toString());
      } else {
        defaultAddress.value = null;
      }
    });
  }
}