import 'package:flutter/material.dart';
import 'package:dashboard/config/palette.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  String titlePage;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Palette.primaryColor,
      elevation: 0.0,
      title: Text(titlePage),
      // leading: IconButton(
      //    icon: const Icon(Icons.menu),
      //    iconSize: 28.0,
      //    onPressed: () {},
      //  ),
      //  actions: <Widget>[
      //    IconButton(
      //     icon: const Icon(Icons.notifications_none),
      //     iconSize: 28.0,
      //     onPressed: () {},
      //   ),
      //  ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
