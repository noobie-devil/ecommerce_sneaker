import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  int id;
  String image;
  String title;
  String type;
  String description;
  double price;
  String brandImage;

  ProductModel(this.id, this.image, this.title, this.type, this.description,
      this.price, this.brandImage);
}

class Product {
  final String id;
  final String imagePath;
  final String productName;
  final String productDescription;
  final double price;
  final DateTime updatedAt;
  final DateTime createdAt;
  List<Category> categories;
  Brand brand;

  Product(this.id, this.imagePath, this.productName, this.productDescription,
      this.price, this.updatedAt, this.createdAt, this.categories, this.brand);

  Product.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        imagePath = map['image_path'],
        productName = map['product_name'],
        productDescription = map['product_description'],
        price = map['price'],
        updatedAt = map['updated_at'],
        createdAt = map['created_at'],
        categories = List<Category>.from(
          map['category_id']?.map(
                (categoryId) => Category(id: categoryId),
              ) ??
              [],
        ),
        brand = Brand(id: map['brand_id']);

  Product.fromSnapshot(DocumentSnapshot snapshot)
      : id = snapshot.id,
        imagePath = snapshot.get('image_path'),
        productName = snapshot.get('product_name'),
        productDescription = snapshot.get('product_description'),
        price = snapshot.get('price'),
        updatedAt = (snapshot.get('updated_at') as Timestamp).toDate(),
        createdAt = (snapshot.get('created_at') as Timestamp).toDate(),
        categories = [],
        brand = Brand(id: snapshot.get('brand_id'));
}

class Brand {
  final String id;
  final String brandImage;
  final String brandName;

  Brand({required this.id, this.brandImage = '', this.brandName = ''});

  Brand.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        brandImage = map['image_path'],
        brandName = map['name'];

  Brand.fromSnapshot(DocumentSnapshot snapshot)
      : id = snapshot.id,
        brandImage = snapshot.get('image_path'),
        brandName = snapshot.get('name');
}

class Category {
  final String id;
  final String name;

  Category({required this.id, this.name = ''});

  Category.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        name = map['name'];

  Category.fromSnapshot(DocumentSnapshot snapshot)
      : id = snapshot.id,
        name = snapshot.get('name');
}

class Cart {
  final String uid;
  final List<CartProduct> cartProducts;

  Cart(this.uid, this.cartProducts);

  Cart.fromSnapshot(DocumentSnapshot snapshot)
      : uid = snapshot.id,
        cartProducts = [];
}

class CartProduct {
  final String? id;
  final String productId;
  final int quantity;

  CartProduct(this.id, this.productId, this.quantity);

  CartProduct.fromSnapshot(DocumentSnapshot snapshot)
      : id = snapshot.id,
        productId = snapshot.get("product_id"),
        quantity = snapshot.get('quantity');

  Map<String, dynamic> toJson() =>
      {'product_id': productId, 'quantity': quantity};
}

class WishListItem {
  final String? id;
  final String productId;

  WishListItem(this.id, this.productId);

  WishListItem.fromSnapshot(DocumentSnapshot snapshot)
      : id = snapshot.id,
        productId = snapshot.get("product_id");

  Map<String, dynamic> toJson() => {'product_id': productId};
}

class DeliveryAddress {
  final String? id;
  final String fullName;
  final String phoneNumber;
  final String address;
  final bool isDefaultAddress;

  DeliveryAddress(this.id, this.fullName, this.phoneNumber, this.address,
      this.isDefaultAddress);

  DeliveryAddress.fromSnapshot(DocumentSnapshot snapshot)
      : id = snapshot.id,
        fullName = snapshot.get("full_name"),
        phoneNumber = snapshot.get("phone_number"),
        address = snapshot.get('address'),
        isDefaultAddress = snapshot.get("is_default");
}

class User {
  final String? uid;
  final String username;
  final String email;

  User(this.uid, this.username, this.email);

  User.fromSnapshot(DocumentSnapshot snapshot)
      : uid = snapshot.id,
        username = snapshot.get('username'),
        email = snapshot.get('email');

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'username': username,
      'email': email,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      json['uid'],
      json['username'],
      json['email'],
    );
  }
}

class RegisterRequest {
  final String username;
  final String email;
  final String password;

  RegisterRequest(this.username, this.email, this.password);

  Map<String, dynamic> toJson() =>
      {'username': username, 'email': email, 'password': password};
}
