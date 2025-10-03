import 'package:e_blood_management/colors/my_colors.dart';
import 'package:flutter/material.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  var title;
  final List<Widget>? actions;
  bool centerTitle;

  MyAppBar({this.title, required this.centerTitle, this.actions});

  @override
  State<MyAppBar> createState() => _MyAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: widget.title,
      backgroundColor: MyColors.primaryColor,
      centerTitle: widget.centerTitle,
      actions: widget.actions,
    );
  }
}
