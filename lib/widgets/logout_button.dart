import 'package:flutter/material.dart';
import 'package:personal_expenses/app_logic/app_logic.dart';
import 'package:personal_expenses/app_logic/auth.dart';
import 'package:personal_expenses/screen/check_email.dart';

import 'info_button.dart';

class LogoutButton extends StatelessWidget {
  final AppLogic data;

  LogoutButton({
    this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
         InfoButton(
          name: 'Logout',
          buttonColor: Colors.red,
          textColor: Colors.white,
          onPress: () async {
            data.setChecking(true);
            String msg = await data.signOut();
            if (msg == Auth.SUCCESS_MSG) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                CheckEmail.id,
                (route) => false,
              );
              await data.clearUser();
            } else {
            }
            data.setChecking(false);
          },
        ),
      ],
    );
  }
}
