import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;
User? currentUser = auth.currentUser;

//collections
const productsCollection = 'Product';
const brandCollection = 'Brand';
const cartCollection = 'Cart';
const dashboardCollection = 'Dashboard';
const userCollection = 'User';
const chatCollection = 'Chat';
const orderCollection = 'Order';