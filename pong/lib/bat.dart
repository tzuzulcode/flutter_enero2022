import 'package:flutter/material.dart';

class Bat extends StatelessWidget {
  final double width;
  final double height;

  const Bat(Key? key,this.width,this.height) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.blue[700]
      ),
    );
  }
}