import 'package:flutter/material.dart';

class OrWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            height: 10.0,
            thickness: 1.5,
            color: Colors.black,
            endIndent: 20.0,
            indent: 20.0,
          ),
        ),
        const Text(
          'OR',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.0,
            fontWeight: FontWeight.w800,
          ),
        ),
        Expanded(
          child: Divider(
            height: 10.0,
            thickness: 1.5,
            endIndent: 20.0,
            indent: 20.0,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
