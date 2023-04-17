import 'package:flutter/material.dart';

import '../data.dart';

class TopBrandsItem extends StatelessWidget {
  const TopBrandsItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: Data.categories
        .map((e) => Padding(
          padding: const EdgeInsets.only(left: 33),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Material(
              color: const Color(0xffEEEEEE),
              child: InkWell(
                onTap: (){},
                child: SizedBox(
                  height: 73,
                  width: 70,
                  child: Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: Image.asset(
                      e,
                      height: 12,
                      width: 35,
                    ),
                  ),
                ),
              ),
            ),
          ),
        )).toList(),
      ),
    );
    return const Placeholder();
  }
}
