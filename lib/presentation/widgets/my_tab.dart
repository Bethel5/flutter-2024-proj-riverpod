import 'package:flutter/material.dart';

class MyTab extends StatelessWidget {
  final String iconPath;

  const MyTab({
    super.key,
    required this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return Tab(
      height: 70,
      child: Container(
          padding: EdgeInsets.all(2),
          decoration: BoxDecoration(
              color: Colors.grey[300], borderRadius: BorderRadius.circular(12)),
          child: Image.asset(
            iconPath,
            color: Colors.black,
          )),
    );
  }
}
