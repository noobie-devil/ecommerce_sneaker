import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_sneaker/shared_preferences_manager.dart';
import 'package:ecommerce_sneaker/models/models.dart';
import 'package:get/get.dart';

enum CartState { loaded, loading, empty, error }

class CartController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late final SharedPreferencesManager _preferencesManager;
  late final User? currentUser;
  final _cartState = CartState.loading.obs;
  final _cartProductList = RxList<CartProduct>([]);
  final _cartTotalQuantity = RxInt(0);
  final _cartTotalPayment = RxDouble(0);
  final _cartCheckedItem = RxList<CartProduct>([]);
  late StreamSubscription<QuerySnapshot<Map<String, dynamic>>> listenCart;

  get cartTotalPayment => _cartTotalPayment;

  List<CartProduct> get cartProductList => _cartProductList;

  RxList<CartProduct> get cartProductObservable => _cartProductList;

  RxList<CartProduct> get cartCheckedItemObservable => _cartCheckedItem;

  get cartCheckedItem => _cartCheckedItem;

  CartState get cartState => _cartState.value;

  get cartStateObservable => _cartState;

  int get cartTotalQuantity => _cartTotalQuantity.value;

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    _preferencesManager =  await SharedPreferencesManager.instance;
    currentUser = _preferencesManager.getCurrentUser();
    initListen(currentUser?.uid);
    // SharedPreferencesManager.instance.then((preferencesManager) {
    //   if(preferencesManager != null) {
    //     _preferencesManager = preferencesManager;
    //     final String? userJson = preferencesManager.getString("current_user");
    //     if(userJson != null) {
    //       final Map<String, dynamic> userMap = jsonDecode(userJson);
    //       currentUser = User.fromJson(userMap);
    //       initListen(currentUser?.uid);
    //     }
    //   }
    // }).catchError((error) => print(error));
    super.onInit();

    // ever(_cartProductList, (callback) => {
    //   // _cartCheckedItem.addAll(callback)
    //   updateCheckedItem(callback)
    // });
  }

  Future<void> initListen(String? documentId) async {
    final docSnapshot =
        await _firestore.collection('Cart').doc(documentId).get();
    if (!docSnapshot.exists) {
      Map<String, dynamic> data = {"uid": documentId};
      await _firestore.collection('Cart').doc(documentId).set(data);
    }

    listenCart = _firestore
        .collection('Cart')
        .doc(documentId)
        .collection("CartProduct")
        .snapshots()
        .listen((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        // List<CartProduct> updatedCarts = snapshot.docs.map((e) => CartProduct.fromSnapshot(e)).toList();
        // _cartProductList.value = updatedCarts;
        _cartProductList.assignAll(
            snapshot.docs.map((e) => CartProduct.fromSnapshot(e)).toList());
        print('listen _cartProductList ${_cartProductList.toJson()}');
        _cartState.value = CartState.loaded;
        _cartTotalQuantity.value = _cartProductList.fold(
            0, (sum, cartProduct) => sum + cartProduct.quantity);
      } else {
        _cartState.value = CartState.empty;
        _cartTotalQuantity.value = 0;
      }
    }, onError: (err) {
      _cartState.value = CartState.error;
      _cartTotalQuantity.value = 0;
    });
  }

  Future<void> refreshListenCart() async {
    await listenCart.cancel();
    _cartState.value = CartState.loading;
    initListen(currentUser!.uid);
  }

  Future<void> updateCartProduct(String productId, int quantity) async {
    final int index = _cartProductList
        .indexWhere((element) => element.productId == productId);
    if (index == -1 && quantity > 0) {
      final cartProduct = CartProduct(null, productId, quantity);
      FirebaseFirestore.instance
          .collection('Cart')
          .doc(currentUser!.uid)
          .collection("CartProduct")
          .add(cartProduct.toJson())
          .then((value) {
        // _cartProductList.add(CartProduct(value.id, productId, quantity));
        // _cartTotalQuantity.value += quantity;
        Get.snackbar("Thành công", "Thêm sản phẩm vào giỏ hàng thành công",
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 2));
        print("Cập nhật sản phẩm trong giỏ hàng thành công");
      }).catchError((error) {
        print("Có lỗi khi cập nhật sản phẩm trong giỏ hàng");
        Get.snackbar("Lỗi", "Có lỗi khi thêm sản phẩm vào giỏ hàng",
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 2));
      });
    } else if (index != -1) {
      final cartProduct = _cartProductList[index];
      quantity += cartProduct.quantity;
      if (quantity > 0) {
        FirebaseFirestore.instance
            .collection('Cart')
            .doc(currentUser!.uid)
            .collection("CartProduct")
            .doc(cartProduct.id)
            .update({"quantity": quantity}).then((value) {
          // cartProduct.quantity = quantity;
          // _cartTotalQuantity.value = _cartProductList.fold(0, (sum, cartProduct) => sum + cartProduct.quantity);
          Get.snackbar(
              "Thành công", "Cập nhật sản phẩm trong giỏ hàng thành công",
              snackPosition: SnackPosition.BOTTOM,
              duration: const Duration(seconds: 2));
          print("Cập nhật sản phẩm trong giỏ hàng thành công");
        }).catchError((error) {
          Get.snackbar("Lỗi", "Có lỗi khi cập nhật sản phẩm trong giỏ hàng",
              snackPosition: SnackPosition.BOTTOM,
              duration: const Duration(seconds: 2));
          print("Có lỗi khi cập nhật sản phẩm trong giỏ hàng");
        });
      } else {
        FirebaseFirestore.instance
            .collection('Cart')
            .doc(currentUser!.uid)
            .collection("CartProduct")
            .doc(cartProduct.id)
            .delete()
            .then((value) {
          // _cartProductList.removeWhere((cartProduct) => cartProduct.productId == productId);
          // _cartTotalQuantity.value = _cartProductList.fold(0, (sum, cartProduct) => sum + cartProduct.quantity);
          Get.snackbar("Thành công", "Xóa sản phẩm khỏi giỏ hàng thành công",
              snackPosition: SnackPosition.BOTTOM,
              duration: const Duration(seconds: 2));
          print("Xóa sản phẩm khỏi giỏ hàng thành công");
        }).catchError((error) {
          Get.snackbar("Lỗi", "Có lỗi khi xóa sản phẩm khỏi giỏ hàng",
              snackPosition: SnackPosition.BOTTOM,
              duration: const Duration(seconds: 2));
          print("Có lỗi khi xóa sản phẩm khỏi giỏ hàng");
        });
      }
    }
  }

  Future<bool> updateCartProductGetResult(
      String productId, int quantity) async {
    final int index = _cartProductList
        .indexWhere((element) => element.productId == productId);
    if (index == -1 && quantity > 0) {
      final cartProduct = CartProduct(null, productId, quantity);
      try {
        await FirebaseFirestore.instance
            .collection('Cart')
            .doc(currentUser!.uid)
            .collection("CartProduct")
            .add(cartProduct.toJson());
        print("Cập nhật sản phẩm trong giỏ hàng thành công");
        Get.snackbar("Thành công", "Thêm sản phẩm vào giỏ hàng thành công",
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 2));
        return true;
      } catch (e) {
        print(e.toString());
        Get.snackbar("Lỗi", "Có lỗi khi thêm sản phẩm vào giỏ hàng",
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 2));
        return false;
      }
    } else if (index != -1) {
      final cartProduct = _cartProductList[index];
      quantity += cartProduct.quantity;
      if (quantity > 0) {
        try {
          await _firestore.collection("Cart").doc(currentUser!.uid).collection("CartProduct")
              .doc(cartProduct.id)
              .update({"quantity": quantity});
          Get.snackbar(
              "Thành công", "Cập nhật sản phẩm trong giỏ hàng thành công",
              snackPosition: SnackPosition.BOTTOM,
              duration: const Duration(seconds: 2));
          print("Cập nhật sản phẩm trong giỏ hàng thành công");
          return true;
        } catch (e) {
          Get.snackbar("Lỗi", "Có lỗi khi cập nhật sản phẩm trong giỏ hàng",
              snackPosition: SnackPosition.BOTTOM,
              duration: const Duration(seconds: 2));
          print("Có lỗi khi cập nhật sản phẩm trong giỏ hàng");
          return false;
        }
      } else {
        try {
          await _firestore.collection("Cart").doc(currentUser!.uid)
              .collection("CartProduct")
              .doc(cartProduct.id)
              .delete();
          Get.snackbar("Thành công", "Xóa sản phẩm khỏi giỏ hàng thành công",
              snackPosition: SnackPosition.BOTTOM,
              duration: const Duration(seconds: 2));
          print("Xóa sản phẩm khỏi giỏ hàng thành công");
          return true;
        } catch (e) {
          Get.snackbar("Lỗi", "Có lỗi khi xóa sản phẩm khỏi giỏ hàng",
              snackPosition: SnackPosition.BOTTOM,
              duration: const Duration(seconds: 2));
          print("Có lỗi khi xóa sản phẩm khỏi giỏ hàng");
          return false;
        }
      }

    } else {
      return false;
    }
  }
}

// Future<void> updateCartProduct(String productId, int quantity) async {
//   final int index = _cartProductList
//       .indexWhere((element) => element.productId == productId);
//   if (index == -1 && quantity > 0) {
//     final cartProduct = CartProduct(null, productId, quantity);
//     try {
//       await FirebaseFirestore.instance
//           .collection('Cart')
//           .doc(currentUser!.uid)
//           .collection("CartProduct")
//           .add(cartProduct.toJson());
//       print("Cập nhật sản phẩm trong giỏ hàng thành công");
//       Get.snackbar("Thành công", "Thêm sản phẩm vào giỏ hàng thành công",
//           snackPosition: SnackPosition.BOTTOM,
//           duration: const Duration(seconds: 2));
//     } catch (e) {
//       print(e.toString());
//       Get.snackbar("Lỗi", "Có lỗi khi thêm sản phẩm vào giỏ hàng",
//           snackPosition: SnackPosition.BOTTOM,
//           duration: const Duration(seconds: 2));
//     }
//   } else if (index != -1 && quantity > 0) {
//     final cartProduct = _cartProductList[index];
//     try {
//       await _firestore
//           .collection('Cart')
//           .doc(currentUser!.uid)
//           .collection("CartProduct")
//           .doc(cartProduct.id)
//           .update({"quantity": quantity});
//       Get.snackbar(
//           "Thành công", "Cập nhật sản phẩm trong giỏ hàng thành công",
//           snackPosition: SnackPosition.BOTTOM,
//           duration: const Duration(seconds: 2));
//       print("Cập nhật sản phẩm trong giỏ hàng thành công");
//     } catch (e) {
//       print(e.toString());
//       Get.snackbar("Lỗi", "Có lỗi khi cập nhật sản phẩm trong giỏ hàng",
//           snackPosition: SnackPosition.BOTTOM,
//           duration: const Duration(seconds: 2));
//     }
//   } else if (index != -1 && quantity == 0) {
//     final cartProduct = _cartProductList[index];
//     try {
//       FirebaseFirestore.instance
//           .collection('Cart')
//           .doc(currentUser!.uid)
//           .collection("CartProduct")
//           .doc(cartProduct.id)
//           .delete();
//       Get.snackbar("Thành công", "Xóa sản phẩm khỏi giỏ hàng thành công",
//           snackPosition: SnackPosition.BOTTOM,
//           duration: const Duration(seconds: 2));
//       print("Xóa sản phẩm khỏi giỏ hàng thành công");
//     } catch (e) {
//       print(e.toString());
//       Get.snackbar("Lỗi", "Có lỗi khi xóa sản phẩm khỏi giỏ hàng",
//           snackPosition: SnackPosition.BOTTOM,
//           duration: const Duration(seconds: 2));
//     }
//   }
// }
