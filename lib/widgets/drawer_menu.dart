import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({Key? key, required this.drawerController}) : super(key: key);

  final ZoomDrawerController drawerController;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                DrawerHeader(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 40),
                        child: const CircleAvatar(
                          maxRadius: 40,
                          backgroundColor: Colors.deepOrange,
                          child: Icon(
                            Icons.store,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            const Divider(
              thickness: 1,
            ),

          ],
        ),
      ),
    );
  }

}

