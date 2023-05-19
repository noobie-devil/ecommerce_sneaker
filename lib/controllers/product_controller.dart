import 'dart:async';
import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_sneaker/models/models.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart' as rxdart;

import '../shared_preferences_manager.dart';

class ProductController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late final SharedPreferencesManager _preferencesManager;
  late User? currentUser;

  final HashMap<String, Category> _categoryCache = HashMap();
  final HashMap<String, Brand> _brandCache = HashMap();
  final _productList = RxList<Product>([]);
  final _wishList = Rx<HashMap<String, WishListItem>>(HashMap());
  late StreamSubscription<QuerySnapshot<Map<String, dynamic>>> listenerWishList;

  final RxBool isLoading = true.obs;
  final RxBool isEmpty = false.obs;
  final RxBool isError = false.obs;
  final _brandList = RxList<Brand>([]);
  final brandFilterSelected = "".obs;

  final productListChanged = rxdart.BehaviorSubject<bool>.seeded(false);
  final wishListChanged = rxdart.BehaviorSubject<bool>.seeded(false);

  List<Product> get productList => _productList;

  List<Brand> get brandList => _brandList;

  HashMap<String, WishListItem> get wishList => _wishList.value;

  get selectedBrands => brandFilterSelected;

  @override
  Future<void> onInit() async {
    _preferencesManager = await SharedPreferencesManager.instance;
    // _preferencesManager = (await SharedPreferencesManager.instance)!;
    currentUser = _preferencesManager.getCurrentUser();
    initListener(currentUser?.uid);
    print("currentUser: $currentUser");

    // SharedPreferences.getInstance().then((preference) {
    //   bool contains = preference.containsKey("current_user");
    //   print("contain current_user: $contains");
    //
    //   final String? userJson = preference.getString("current_user");
    //   print("userJson: $userJson");
    //   if(userJson != null) {
    //     final Map<String, dynamic> userMap = jsonDecode(userJson);
    //     currentUser = User.fromJson(userMap);
    //     initListener(currentUser?.uid);
    //   }
    // }).catchError((error) => print(error));
    // SharedPreferencesManager.instance.then((preferencesManager) {
    //
    //   if(preferencesManager != null) {
    //     print("preferencesManager: $preferencesManager");
    //
    //     _preferencesManager = preferencesManager;
    //     final String? userJson = preferencesManager.getString("current_user");
    //     print("userJson: $userJson");
    //
    //     if(userJson != null) {
    //       final Map<String, dynamic> userMap = jsonDecode(userJson);
    //       currentUser = User.fromJson(userMap);
    //       initListener(currentUser?.uid);
    //     }
    //   } else {
    //     print("preferencesManager: null");
    //
    //   }
    // }).catchError((error) => print(error));

    ever(brandFilterSelected, (callback) => refreshProducts());
    getProducts();

    super.onInit();
  }

  Future<void> initListener(String? documentId) async {
    // final doc
    print("documentId: $documentId");
    listenerWishList = _firestore
        .collection("User")
        .doc(documentId)
        .collection("WishList")
        .snapshots()
        .listen((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        _wishList.value.clear();
        for (var e in snapshot.docs) {
          final item = WishListItem.fromSnapshot(e);
          _wishList.value.putIfAbsent(item.productId, () => item);
        }
        wishListChanged.sink.add(true);
        _wishList.value.forEach((key, value) => print("$key: $value"));
      } else {
        _wishList.value.clear();
        wishListChanged.sink.add(true);
      }
    }, onError: (err) {
      print(err);
    });
  }

  Future<Product?> getProductById(String productId) async {
    final findIndexInCurrentList =
        _productList.indexWhere((element) => element.id == productId);
    if (findIndexInCurrentList != -1) {
      return _productList.elementAt(findIndexInCurrentList);
    } else {
      try {
        final productDoc =
            await _firestore.collection("Product").doc(productId).get();
        if (productDoc.exists && productDoc.data() != null) {
          final product = Product.fromSnapshot(productDoc);
          final categoryIds =
              (productDoc.data()!['category_id'] as Iterable<dynamic>)
                  .toList()
                  .cast<String>();
          final categoryFutures = categoryIds.map((categoryId) async {
            if (_categoryCache.containsKey(categoryId)) {
              product.categories.add(_categoryCache[categoryId]!);
            } else {
              final categoryDoc =
                  await _firestore.collection('Category').doc(categoryId).get();
              if (categoryDoc.exists && categoryDoc.data() != null) {
                final category = Category.fromSnapshot(categoryDoc);
                _categoryCache.putIfAbsent(categoryId, () => category);
                product.categories.add(category);
              }
            }
          });
          await Future.wait(categoryFutures);

          final brandId = productDoc['brand_id'];
          if (_brandCache.containsKey(brandId)) {
            product.brand = _brandCache[brandId]!;
          } else {
            final brandDoc =
                await _firestore.collection('Brand').doc(brandId).get();
            if (brandDoc.exists && brandDoc.data() != null) {
              final brand = Brand.fromSnapshot(brandDoc);
              _brandCache.putIfAbsent(brandId, () => brand);
              product.brand = brand;
            }
          }
          return product;
        }
      } catch (e) {
        print('Error getting product: $e');
      }
    }
    return null;
  }

  Future<void> addToWishList(Product product) async {
    _firestore
        .collection("User")
        .doc(currentUser!.uid)
        .collection("WishList")
        .add({"product_id": product.id}).then((value) {
      Get.snackbar("Thành công", "Thêm sản phẩm vào WishList thành công",
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2));
    }).catchError((error) {
      print(error);
      Get.snackbar("Lỗi", "Có lỗi khi thêm sản phẩm vào WishList",
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2));
    });
  }

  Future<void> removeFromWishList(String productId) async {
    late final String? id;
    if(_wishList.value.containsKey(productId)) {
      print("removeFromWishList: contains productId");
      id = _wishList.value[productId]?.id;
    } else {
      print("removeFromWishList: not contains productId");
    }
    if(id != null) {
      _firestore
          .collection("User")
          .doc(currentUser!.uid)
          .collection("WishList")
          .doc(id)
          .delete()
          .then((value) {

        Get.snackbar("Thành công", "Đã xóa sản phẩm khỏi WishList",
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 2));
      }).catchError((error) {
        print(error);
        Get.snackbar("Lỗi", "Không thể thực hiện thao tác lúc này",
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 2));
      });
    } else {
      return;
    }
  }

  Future<void> getProducts() async {
    try {
      isLoading.value = true;
      final QuerySnapshot<Map<String, dynamic>> productDocs;
      if (brandFilterSelected.value.isNotEmpty) {
        productDocs = await _firestore
            .collection('Product')
            .where("brand_id", isEqualTo: brandFilterSelected.value)
            .get();
      } else {
        productDocs = await _firestore.collection('Product').get();
      }
      _productList.clear();

      for (final productDoc in productDocs.docs) {
        final product = Product.fromSnapshot(productDoc);
        // final categoryIds = List<String>.from(productDoc.data()['category_id']);
        final categoryIds =
            (productDoc.data()['category_id'] as Iterable<dynamic>)
                .toList()
                .cast<String>();

        final categoryFutures = categoryIds.map((categoryId) async {
          if (_categoryCache.containsKey(categoryId)) {
            product.categories.add(_categoryCache[categoryId]!);
          } else {
            final categoryDoc =
                await _firestore.collection('Category').doc(categoryId).get();
            if (categoryDoc.exists && categoryDoc.data() != null) {
              final category = Category.fromSnapshot(categoryDoc);
              _categoryCache.putIfAbsent(categoryId, () => category);
              product.categories.add(category);
            }
          }
        });

        await Future.wait(categoryFutures);

        final brandId = productDoc['brand_id'];
        if (_brandCache.containsKey(brandId)) {
          product.brand = _brandCache[brandId]!;
        } else {
          final brandDoc =
              await _firestore.collection('Brand').doc(brandId).get();
          if (brandDoc.exists && brandDoc.data() != null) {
            final brand = Brand.fromSnapshot(brandDoc);
            _brandCache.putIfAbsent(brandId, () => brand);
            product.brand = brand;
          }
        }

        _productList.add(product);
      }
      productListChanged.sink.add(true);
      if (_brandCache.isNotEmpty) {
        _brandList.clear();
        _brandList.addAll(_brandCache.values);
      }
      if (_productList.isEmpty) {
        isEmpty.value = true;
      } else {
        isEmpty.value = false;
      }
    } catch (e) {
      isError.value = true;
      print('Error getting products: $e');
    }
    isLoading.value = false;
  }

  Future<void> refreshProducts() async {
    isError.value = false;
    await listenerWishList.cancel();
    initListener(currentUser!.uid);
    getProducts();
  }
}
