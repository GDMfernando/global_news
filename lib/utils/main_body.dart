import 'package:flutter/material.dart';

import '../widgets/bottom_navbar.dart';

class MainBody extends StatefulWidget {
  const MainBody({
    super.key,
    required this.title,
    this.appBarColor,
    required this.body,
    this.titleTextColor,
    this.backGroundColor,
    this.centerTitle,
    this.drawer,
    this.autoLeadingIcon = true,
    this.iconThemeColor,
    this.floatingActionButton,
  });
  final String title;
  final Color? appBarColor;
  final Color? titleTextColor;
  final Widget body;
  final Color? backGroundColor;
  final Widget? centerTitle;
  final Widget? drawer;
  final bool autoLeadingIcon;
  final Color? iconThemeColor;
  final Widget? floatingActionButton;
  @override
  State<MainBody> createState() => _MainBodyState();
}

class _MainBodyState extends State<MainBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: widget.drawer,
      appBar: AppBar(
        automaticallyImplyLeading: widget.autoLeadingIcon,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: widget.iconThemeColor ?? Colors.white,
        ),
        titleTextStyle: TextStyle(
            fontSize: 20,
            color: widget.titleTextColor ?? Colors.white,
            fontWeight: FontWeight.bold),
        leading: widget.centerTitle,
        backgroundColor: widget.appBarColor ?? Colors.black,
        title:
            Text(
              widget.title,
            ),
      ),
      backgroundColor:
      widget.backGroundColor ?? const Color.fromARGB(255, 236, 236, 236),
      body: Stack(
        children: [
          widget.body,
          if (widget.floatingActionButton != null)
            Positioned(
              bottom: 16.0,
              right: 16.0,
              child: widget.floatingActionButton!,
            ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
