import 'package:flutter/material.dart';
import 'package:personal_expenses/app_logic/app_logic.dart';

import '../utils.dart';

class SocialIcons extends StatelessWidget {
  final AppLogic data;

  SocialIcons({
    this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MaterialButton(
          child: Image.asset(
            'assets/images/facebook.png',
            width: 40.0,
            height: 40.0,
          ),
          onPressed: () {
            data.getUserFromSocial(type: SignMethod.FACEBOOK);
          },
        ),
        MaterialButton(
            child: Image.asset(
              'assets/images/google.png',
              width: 40.0,
              height: 40.0,
            ),
            onPressed: () {
              data.getUserFromSocial(type: SignMethod.GOOGLE);
            }),
      ],
    );
  }
}
