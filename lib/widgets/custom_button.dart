import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Function onPress;
  final String name;
  final Color color;

  CustomButton({this.onPress, this.name, this.color});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      onPressed: onPress,
      color: color,
      child: Text(
        name,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),
      ),
    );
  }
}
