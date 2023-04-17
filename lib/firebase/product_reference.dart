import 'package:ecommerce_sneaker/models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<Product>> getProductList() async {
  var list = List<Product>.empty(growable: true);
  QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance.collection("Products").get();
  querySnapshot.docs.forEach((element) {
    Map<String, dynamic> data = element.data();
    list.add(Product.fromMap(data));
  });
  return list;
}