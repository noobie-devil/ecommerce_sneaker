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
        categories =[],
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
