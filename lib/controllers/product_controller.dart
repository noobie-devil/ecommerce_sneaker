import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_sneaker/models/product_model.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final HashMap<String, Category> _categoryCache = HashMap();
  final HashMap<String, Brand> _brandCache = HashMap();
  final _productList = RxList<Product>([]);
  final RxBool isLoading = true.obs;
  final RxBool isEmpty = false.obs;
  final RxBool isError = false.obs;

  List<Product> get productList => _productList;

  Future<void> getProducts() async {
    try {
      isLoading.value = true;
      final productDocs = await _firestore.collection('Product').get();
      _productList.clear();

      for (final productDoc in productDocs.docs) {
        final product = Product.fromSnapshot(productDoc);
        // final categoryIds = List<String>.from(productDoc.data()['category_id']);
        final categoryIds = (productDoc.data()['category_id'] as Iterable<dynamic>).toList().cast<String>();

        final categoryFutures = categoryIds.map((categoryId) async {
          if (_categoryCache.containsKey(categoryId)) {
            product.categories.add(_categoryCache[categoryId]!);
          } else {
            final categoryDoc =
            await _firestore.collection('Category').doc(categoryId).get();
            if (categoryDoc.exists && categoryDoc.data() != null) {
              // final categoryData = categoryDoc.data() as Map<String, dynamic>?;
              // if (categoryData != null) {
              //   final category = Category.fromMap(categoryData);
              //   _categoryCache.putIfAbsent(categoryId, () => category);
              //   product.categories.add(category);
              // }
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
            // final brandData = brandDoc.data() as Map<String, dynamic>?;
            // if (brandData != null) {
            //   final brand = Brand.fromMap(brandData);
            //   _brandCache.putIfAbsent(brandId, () => brand);
            //   product.brand = brand;
            // }
            final brand = Brand.fromSnapshot(brandDoc);
            _brandCache.putIfAbsent(brandId, () => brand);
            product.brand = brand;
          }
        }

        _productList.add(product);
      }
      if(_productList.isEmpty) {
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
    getProducts();
  }
}