import 'package:flutter/material.dart';
import 'package:personal_expenses/widgets/header.dart';

class EmptyContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/box.png',
            height: size.height * 0.2,
            width: size.width * 0.2,
          ),
          SizedBox(
            height: 20.0,
          ),
          Header(
            text: 'No Content',
            size: 30.0,
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}
