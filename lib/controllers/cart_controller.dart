import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_sneaker/models/models.dart';
import 'package:get/get.dart';

enum CartState { loaded, loading, empty, error }

class CartController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _cartState = CartState.loading.obs;
  final _cartProductList = RxList<CartProduct>([]);
  final _cartTotalQuantity = RxInt(0);
  final _cartTotalPayment = RxDouble(0);
  final _cartCheckedItem = RxList<CartProduct>([]);

  get cartTotalPayment => _cartTotalPayment;

  List<CartProduct> get cartProductList => _cartProductList;

  RxList<CartProduct> get cartProductObservable => _cartProductList;

  RxList<CartProduct> get cartCheckedItemObservable => _cartCheckedItem;

  CartState get cartState => _cartState.value;

  int get cartTotalQuantity => _cartTotalQuantity.value;

  get cartCheckedItem => _cartCheckedItem;


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    initListen('documentIdForTest');
    ever(_cartProductList, (callback) => {
      _cartCheckedItem.addAll(callback)
    });
  }

  List<CartProduct> updateCheckedItem(List<CartProduct> updateFromCart) {
    for(var item in updateFromCart) {
      print("updateCheckedItem ${item.toJson()}");
    }
    for(var item in cartCheckedItem) {
      print("cartCheckedItem ${item.toJson()}");
    }

    List<CartProduct> list = [];
    for(var item in cartCheckedItem) {
      int index = updateFromCart.indexWhere((element) => element.id == item.id);
      for(int i = 0; i < updateFromCart.length; i++) {
        print("updateFromCart[i]: ${updateFromCart[i].toJson()}");
        print("item: ${item.toJson()}");
        if(item.id == updateFromCart[i].id) {
          index = i;
          break;
        }
      }
      print("index: $index");
      print("item: ${item.toJson()}");
      if(index != -1) {
        list.add(updateFromCart[index]);
      }
    }
    print("as $list");
    return list;
  }


  Future<void> initListen(String documentId) async {
    final docSnapshot = await _firestore
        .collection('Cart')
        .doc(documentId)
        .get();
    if (!docSnapshot.exists) {
      Map<String, dynamic> data = {
        "uid": documentId
      };
      await _firestore
          .collection('Cart')
          .doc(documentId)
          .set(data);
    }

    _firestore
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

  // Future<void> updateCartProduct(String productId, int quantity) async {
  //   final int index = _cartProductList
  //       .indexWhere((element) => element.productId == productId);
  //   if (index == -1 && quantity > 0) {
  //     final cartProduct = CartProduct(null, productId, quantity);
  //     try {
  //       await FirebaseFirestore.instance
  //           .collection('Cart')
  //           .doc("documentIdForTest")
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
  //           .doc("documentIdForTest")
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
  //           .doc("documentIdForTest")
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

  Future<void> updateCartProduct(String productId, int quantity) async {
    final int index = _cartProductList
        .indexWhere((element) => element.productId == productId);
    if (index == -1 && quantity > 0) {
      final cartProduct = CartProduct(null, productId, quantity);
      FirebaseFirestore.instance
          .collection('Cart')
          .doc("documentIdForTest")
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
    } else if (index != -1 && quantity > 0) {
      final cartProduct = _cartProductList[index];
      FirebaseFirestore.instance
          .collection('Cart')
          .doc("documentIdForTest")
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
    } else if (index != -1 && quantity == 0) {
      final cartProduct = _cartProductList[index];
      FirebaseFirestore.instance
          .collection('Cart')
          .doc("documentIdForTest")
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
