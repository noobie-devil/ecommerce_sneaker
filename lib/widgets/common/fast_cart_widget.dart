import 'package:ecommerce_sneaker/widgets/cart_item.dart';
import 'package:flutter/material.dart';

class FastCart extends StatelessWidget {

  const FastCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new)
          ),
        ),
        title: const Center(
          child: Text("Cart",),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_horiz,
              size: 30,
            )
          )
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 15),
                child: Column(
                  children: [
                    CartItem(),
                    const SizedBox(height: 15,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Select All",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                          Checkbox(
                            activeColor: Color(0xFFFd725A),
                            value: true,
                            onChanged: (value) {}
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Total Payment:",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600
                            ),
                          ),
                          Text(
                            "\$300.54",
                            style: TextStyle(
                                color: Color(0xFFFD725A),
                                fontSize: 20,
                                fontWeight: FontWeight.w600
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 30,),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => FastCart(),
                        ));
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 100),
                        decoration: BoxDecoration(
                            color: Color(0xFFFD725A),
                            borderRadius: BorderRadius.circular(30)
                        ),
                        child: Text(
                          "Checkout",
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1,
                              color: Colors.white.withOpacity(0.9)
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30,)
                  ],
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}
