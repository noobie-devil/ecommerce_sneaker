import 'models/product_model.dart';

class Data {

  static List categories = [
    'assets/nike_brand.png',
    'assets/adidas_brand.png',
    'assets/puma_brand.png',
    'assets/jordan_brand.png',
    'assets/adidas_brand.png',
    'assets/puma_brand.png',
    'assets/nike_brand.png',
  ];

  static List<ProductModel> generateProducts(){
    return [
      ProductModel(
          1,
          "assets/shoes_1.png",
          "Crater Impact",
          "Men's Shoes",
          "men shoes",
          99.56,
          "assets/nike_brand.png"
      ),
      ProductModel(
          2,
          "assets/shoes_2.png",
          "Air - Max Pre Day",
          "Men's Shoes",
          "men shoes",
          137.56,
          "assets/adidas_brand.png"
      ),
      ProductModel(
          3,
          "assets/shoes_3.png",
          "Air Max 51",
          "Men's Shoes",
          "men shoes",
          99.56,
          "assets/puma_brand.png"
      ),
      ProductModel(
          4,
          "assets/shoes_4.png",
          "EM Shoes",
          "Men's Shoes",
          "men shoes",
          212.56,
          "assets/nike_brand.png"
      ),
    ];
  }

  static List<ProductModel> generateCategories(){
    return [
      ProductModel(
          1,
          "assets/shoes_1.png",
          "Creter Impact",
          "Men's Shoes",
          "men shoes",
          99.56,
          "assets/nike_brand.png"
      ),
      ProductModel(
          2,
          "assets/shoes_2.png",
          "Air - Max Pre Day",
          "Men's Shoes",
          "men shoes",
          137.56,
          "assets/adidas_brand.png"
      ),
      ProductModel(
          3,
          "assets/shoes_3.png",
          "Air Max 51",
          "Men's Shoes",
          "men shoes",
          99.56,
          "assets/puma_brand.png"
      ),
      ProductModel(
          4,
          "assets/shoes_4.png",
          "EM Shoes",
          "Men's Shoes",
          "men shoes",
          212.56,
          "assets/nike_brand.png"
      ),
    ];
  }
}