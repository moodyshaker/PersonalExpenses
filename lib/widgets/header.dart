import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String text;
  final Color color;
  final double size;
  final TextDecoration decoration;

  Header({
    this.text,
    this.color,
    this.size,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: color,
        fontWeight: FontWeight.w700,
        fontSize: size,
        decoration:
            decoration != null ? TextDecoration.underline : TextDecoration.none,
      ),
    );
  }
}
