// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  final double height;
  final double width;
  final Color myColor;
  final void Function()? onTap;
  const MyButton(
      {super.key,
      required this.text,
      required this.onTap,
      this.height = 80,
      this.width = 250,
      this.myColor = const Color.fromRGBO(255, 183, 77, 1)});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: myColor, borderRadius: BorderRadius.circular(15)),
        // padding: EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //text
            Text(
              text,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
