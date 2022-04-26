import 'package:flutter/material.dart';

class Txf extends StatelessWidget {
  final h;
  final w;
  final color;
  final hintText;
  final labelText;
  final keyboardType;
  final icon;
  final hide;
  final lengh;
  final controller;
  final validator;
  final onPress;

  const Txf({
    Key? key,
    this.h,
    this.w,
    this.color,
    this.hintText,
    this.labelText,
    this.icon,
    this.keyboardType,
    this.hide,
    this.lengh,
    this.controller,
    this.validator,
    this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Container(
      height: h,
      width: w,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(45)),
      child: Center(
        child: TextField(
          decoration: InputDecoration(
            hintText: hintText,
            labelText: labelText,
            prefixIcon: icon,
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(left: 25),
            hintStyle: TextStyle(color: Colors.grey),
          ),
        ),
      ),
    );
  }
}
