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
  final RxList<DeliveryAddress> defaultAddresses = RxList([]);
  final RxList<CartProduct> cartProductNeedCheckout = RxList([]);
  final RxList<Product> productInCheckoutList = RxList([]);
  final RxDouble totalPayment = RxDouble(0);

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    _sharedPreferencesManager = await SharedPreferencesManager.instance;
    currentUser = _sharedPreferencesManager.getCurrentUser();
    print(currentUser!.uid);
    initListener(currentUser!.uid);
    super.onInit();
  }

  setCartProductNeedCheckout(List<CartProduct> list) {
    cartProductNeedCheckout.assignAll(list);
  }

  refreshCartProduct() {
    cartProductNeedCheckout.clear();
  }

  Future<void> initListener(String? documentId) async {
    listener = _fireStore
        .collection("User")
        .doc(documentId)
        .collection("DeliveryAddress")
        .where("is_default", isEqualTo: true)
        .snapshots()
        .listen((snapshot) {
      if(snapshot.docs.isNotEmpty) {
        // List<DeliveryAddress> addresses = [];
        // addresses.assignAll(snapshot.docs.map((e) => DeliveryAddress.fromSnapshot(e)).toList());
        defaultAddresses.assignAll(snapshot.docs.map((e) => DeliveryAddress.fromSnapshot(e)).toList());
      }
    });
  }
}