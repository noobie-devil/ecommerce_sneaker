import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_sneaker/constants/admin/const.dart';

class StoreService{
  static getMessages(uid){
    return firestore.collection(chatCollection).where('toId', isEqualTo: uid).snapshots();
  }

  static getProducts(){
    return firestore.collection(productsCollection).snapshots();
  }

  static getBrandById(docId) {
    return firestore.collection(brandCollection).doc(docId).get();
  }
}