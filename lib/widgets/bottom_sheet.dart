import 'package:auto_size_text/auto_size_text.dart';
import 'package:ecommerce_sneaker/pages/home/cart_screen.dart';
import 'package:ecommerce_sneaker/constants/fonts.dart';
import 'package:ecommerce_sneaker/widgets/common/fast_cart_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomBottomSheet extends StatelessWidget {
  List sizes = [39, 40, 41, 42, 43, 44, 45];

  CustomBottomSheet({super.key});

  // const CustomBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 4,
            width: 50,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 223, 221, 221),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Size:",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
              const SizedBox(
                width: 30,
              ),
              Expanded(
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: sizes
                      .map((size) => Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: const Color(0xFFF7F8FA),
                                borderRadius: BorderRadius.circular(30)),
                            child: Text(size.toString()),
                          ))
                      .toList(),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const Text(
                "Color:",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                width: 30,
              ),
              Container(
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.all(13),
                decoration: BoxDecoration(
                    color: const Color(0xFF031C3C),
                    borderRadius: BorderRadius.circular(20)),
              ),
              Container(
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.all(13),
                decoration: BoxDecoration(
                    color: Colors.red, borderRadius: BorderRadius.circular(20)),
              ),
              Container(
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.all(13),
                decoration: BoxDecoration(
                    color: Colors.deepPurpleAccent,
                    borderRadius: BorderRadius.circular(20)),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const Text(
                "Total:",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                width: 30,
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFF7F8FA),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const FaIcon(
                  FontAwesomeIcons.minus,
                  size: 18,
                  color: Colors.redAccent,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              const Text(
                "01",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                width: 8,
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFF7F8FA),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const FaIcon(
                  FontAwesomeIcons.plus,
                  size: 18,
                  color: Colors.redAccent,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "Total Payment:",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              Text(
                "\$300.54",
                style: TextStyle(
                    color: Color(0xFFFD725A),
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FastCart(),
                    ));
              },
            style: ButtonStyle(
                shape: MaterialStateProperty.all<
                    RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(10))),
              padding: MaterialStateProperty.all(
                const EdgeInsets.symmetric(vertical: 13, horizontal: 20)
              )
            ),
              child: const AutoSizeText(
                "Checkout",
                style: TextStyle(fontFamily: gilroySemibold),
                minFontSize: 20,
              ),
          )
        ],
      ),
    );
  }
}
