import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_sneaker/shared_preferences_manager.dart';
import 'package:get/get.dart';

import '../models/models.dart';

enum WishListState { loaded, loading, empty, error }

class WishListController extends GetxController {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  late final SharedPreferencesManager _preferencesManager;
  late final User? currentUser;
  final _wishListItems = RxList<WishListItem>([]);
  final _products = RxList<Product>([]);
  final _wishListState = WishListState.loading.obs;
  late StreamSubscription<QuerySnapshot<Map<String, dynamic>>> listener;

  RxList<WishListItem> get wishList => _wishListItems;

  RxList<Product> get products => _products;

  WishListState get wishListState => _wishListState.value;

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    _preferencesManager = await SharedPreferencesManager.instance;
    currentUser = _preferencesManager.getCurrentUser();
    initListener(currentUser?.uid);
    // SharedPreferencesManager.instance.then((preferencesManager) {
    //   if(preferencesManager != null) {
    //     _preferencesManager = preferencesManager;
    //     final String? userJson = preferencesManager.getString("current_user");
    //     if(userJson != null) {
    //       final Map<String, dynamic> userMap = jsonDecode(userJson);
    //       currentUser = User.fromJson(userMap);
    //       initListener(currentUser?.uid);
    //     }
    //   }
    // }).catchError((error) => print(error));
    super.onInit();
  }

  Future<void> clearWishList() async {
    try {
      final QuerySnapshot querySnapshot = await _fireStore
          .collection("User")
          .doc(currentUser!.uid)
          .collection("WishList")
          .get();
      final List<Future<void>> futures = [];
      for (final doc in querySnapshot.docs) {
        futures.add(doc.reference.delete());
      }
      await Future.wait(futures);
      Get.snackbar("Thành công", "Đã xóa toàn bộ wishlist!",
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2));
    } catch (error) {
      print('Failed to clear wishlist: $error');
      Get.snackbar("Lỗi", "Đã xảy ra lỗi!",
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2));
    }
  }

  Future<bool> removeWishListItem(String? id) async {
    if(id != null) {
      try {
        await _fireStore
            .collection("User")
            .doc(currentUser!.uid)
            .collection("WishList")
            .doc(id)
            .delete();
        return true;
      } catch(error) {
        print("Failed to remove item from wishlist: $error");
        return false;
      }
      //
      //
      //     .then((value) {
      //   Get.snackbar("Thành công", "Đã xóa sản phẩm khỏi wishlist!",
      //       snackPosition: SnackPosition.BOTTOM,
      //       duration: const Duration(seconds: 2));
      // }).catchError((error) {
      //   print("Failed to remove item from wishlist: $error");
      //   Get.snackbar("Lỗi", "Đã xảy ra lỗi!",
      //       snackPosition: SnackPosition.BOTTOM,
      //       duration: const Duration(seconds: 2));
      // });
    } else {
      return false;
    }
  }


  Future<void> initListener(String? documentId) async {
    // final doc
    listener = _fireStore
        .collection("User")
        .doc(documentId)
        .collection("WishList")
        .snapshots()
        .listen((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        _wishListItems.assignAll(
            snapshot.docs.map((e) => WishListItem.fromSnapshot(e)).toList());
        _wishListState.value = WishListState.loaded;
      } else {
        _wishListState.value = WishListState.empty;
      }
    }, onError: (err) {
      print(err);
      _wishListState.value = WishListState.error;
    });
  }

  Future<void> refreshListener() async {
    await listener.cancel();
    _wishListState.value = WishListState.loading;
    await initListener(currentUser!.uid);
  }
}
