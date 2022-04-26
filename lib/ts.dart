import 'package:flutter/material.dart';

class Ts extends StatelessWidget {
  final text;
  var size;
  final color;
  final weight;
  final height;
  final family;
  final latterspace;
  final wordSpace;
  final shadowcolor;
  final td;
  Ts(
      {Key? key,
      this.text,
      this.size,
      this.color,
      this.weight,
      this.height,
      this.family,
      this.latterspace,
      this.wordSpace,
      this.shadowcolor,
      this.td});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          letterSpacing: latterspace,
          wordSpacing: wordSpace,
          fontSize: size,
          fontWeight: weight,
          color: color,
          height: height,
          fontFamily: family,
          decoration: td),
    );
  }
}
