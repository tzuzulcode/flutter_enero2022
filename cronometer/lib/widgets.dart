import 'package:flutter/material.dart';

class ProductivityButton extends StatelessWidget {
  final Color color;
  final String text;
  final double size = 0.0;
  final VoidCallback onPressed;
  //Propiedad para el metod de acción
  
  const ProductivityButton({ 
    Key? key,
    required this.color,
    required this.text, 
    double? size,
    required this.onPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),

      ),
      onPressed: onPressed,
      color: color,
      minWidth: size,
    );
  }
}

class SettingsButton extends StatelessWidget {

  final Color color;
  final String text;
  final int value;
  const SettingsButton(Key? key ,this.color,this.text,this.value) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: ()=>null,
      child:Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
      color: color,
    );
  }
}