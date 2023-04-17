import 'package:ecommerce_sneaker/data.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/product_model.dart';

class CartItem extends StatelessWidget {
  // const CartItem({Key? key}) : super(key: key);

  List<ProductModel> items = Data.generateProducts();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for(int i = 0; i < items.length; i++)
          Container(
            height: 110,
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10)
            ),
            child: Row(
              children: [
                Checkbox(
                  value: true,
                  onChanged: (value) {},
                  activeColor: Color(0xFFFD725A),
                ),
                Container(
                  height: 70,
                  width: 70,
                  margin: EdgeInsets.only(right: 15),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 224, 224, 224),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Image.asset(items[i].image),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        items[i].title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black.withOpacity(0.7)
                        ),
                      ),
                      Text(
                        "Best Selling",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black.withOpacity(0.6)
                        ),
                      ),
                      Text(
                        "\$${items[i].price}",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFFFD725A),
                          fontWeight: FontWeight.bold
                        ),
                      ),

                    ],
                  ),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.delete,
                        color: Colors.redAccent,
                      ),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Color(0xFFF7F8FA),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: FaIcon(
                              FontAwesomeIcons.minus,
                              size: 18,
                              color: Colors.redAccent,
                            ),
                          ),
                          SizedBox(width: 8,),
                          Text("01", style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w400
                          ),),
                          SizedBox(width: 8,),
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Color(0xFFF7F8FA),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: FaIcon(
                              FontAwesomeIcons.minus,
                              size: 18,
                              color: Colors.redAccent,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          )
      ],
    );
  }
}
