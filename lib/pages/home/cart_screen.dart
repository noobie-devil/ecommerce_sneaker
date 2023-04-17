import 'package:ecommerce_sneaker/data.dart';
import 'package:ecommerce_sneaker/models/product_model.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  Widget buildCarts(ProductModel productModel) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.grey[100],
          borderRadius: BorderRadius.circular(8)
        ),
        margin: const EdgeInsets.only(bottom: 10),
        child: ListTile(
          leading: Image.asset(productModel.image),
          title: Text(productModel.title),
          subtitle: Text("\$ ${productModel.price}"),
          trailing: IconButton(onPressed: (){}, icon: Icon(Icons.delete)),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "My Cart",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: Data.generateProducts().length,
              itemBuilder: (context, index) {
                ProductModel product = Data.generateProducts()[index];
                return buildCarts(product);
              },
            ),
          )
        ],
      ),
    );
    // return const Center(
    //   child: Text("cart"),
    // );
  }
}
