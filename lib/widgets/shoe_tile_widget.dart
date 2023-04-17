import 'package:ecommerce_sneaker/models/product_model.dart';
import 'package:flutter/material.dart';

class ShoeTile extends StatelessWidget {
  ProductModel productModel;

  // const ShoeTile({Key? key, required this._productModel}) : super(key: key);
  ShoeTile({Key? key, required this.productModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 25),
      width: 280,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(height: 20,),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(productModel.image),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Text(
              productModel.description,
              style: TextStyle(color: Colors.grey[600]),
            ),
          )
          ,
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(productModel.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                    const SizedBox(height: 5,),
                    Text("\$ ${productModel.price}", style: const TextStyle(color: Colors.grey),)
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(color: Colors.black, borderRadius: BorderRadius.only(topLeft: Radius.circular(12), bottomRight: Radius.circular(12))),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
