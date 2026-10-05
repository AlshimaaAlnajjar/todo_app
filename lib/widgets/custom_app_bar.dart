import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showBackButton;

  CustomAppBar({this.showBackButton = false});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xFF4DB8F5),
      automaticallyImplyLeading: showBackButton,
      title: Text(
        'Tudee',
        style: TextStyle(
          color: Colors.white,
          fontFamily: 'CherryBomb',
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}