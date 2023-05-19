import 'package:ecommerce_sneaker/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<Product>> getProductList() async {
  var list = List<Product>.empty(growable: true);
  QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance.collection("Products").get();
  for (var element in querySnapshot.docs) {
    Map<String, dynamic> data = element.data();
    list.add(Product.fromMap(data));
  }
  return list;
}