import 'package:flutter/material.dart';

class InfoButton extends StatelessWidget {
  final Function onPress;
  final String name;
  final Color buttonColor, textColor;

    const InfoButton({
    this.onPress,
    this.name,
    this.textColor,
    this.buttonColor,
  });

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onPress,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      color: buttonColor,
      child: Text(
        name,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 16.0,
          color: textColor,
        ),
      ),
    );
  }
}
