import 'package:ecommerce_sneaker/constants/fonts.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        color: const Color(0xffEEEEEE),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Center(
        child: TextFormField(
          decoration: const InputDecoration(
            border:InputBorder.none,
            prefixIcon: Padding(
              padding: EdgeInsets.symmetric(vertical: 14, horizontal: 10),
              child: FaIcon(FontAwesomeIcons.magnifyingGlass),
            ),
            hintText:"Search",
            hintStyle: TextStyle(
              fontSize:18,
              fontFamily:gilroySemibold,
              color: Color.fromRGBO(0, 0, 0, 0.4)
            )
          ),
        ),
      ),
    );
  }
}
