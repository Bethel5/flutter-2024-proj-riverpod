// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class MyTextfield extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obsecureText;


  const MyTextfield({super.key, 
  required this.controller,
  required this.hintText,
  required this.obsecureText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextField(
        controller: controller,
        obscureText: obsecureText,
        decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black)),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black)),
            fillColor: Colors.grey[100],
            filled: true,
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey[400])),
      ),
    );
  }
}
