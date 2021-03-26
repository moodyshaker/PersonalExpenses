import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:personal_expenses/app_logic/app_logic.dart';
import 'package:personal_expenses/screen/login.dart';
import 'package:personal_expenses/screen/registration.dart';

import '../utils.dart';
import 'info_button.dart';

class CheckButton extends StatelessWidget {
  final AppLogic data;

  CheckButton({
    this.data,
  });

  @override
  Widget build(BuildContext context) {
    return data.checking
        ? CircularProgressIndicator()
        :  InfoButton(
            onPress: () async {
              if (EmailValidator.validate(data.emailCheckController.text)) {
                data.setChecking(true);
                UserState state =
                    await data.verifyEmail(data.emailCheckController.text);
                if (state == UserState.NOT_FOUND) {
                  data.setEmail(data.emailCheckController.text);
                  Navigator.pushReplacementNamed(context, Registration.id);
                } else if (state == UserState.REGISTER) {
                  data.setEmail(data.emailCheckController.text);
                  Navigator.pushReplacementNamed(context, Login.id);
                } else {
                  Fluttertoast.showToast(
                      msg: 'Please check your internet connection');
                }
                data.setChecking(false);
              }
            },
            name: 'CHECK',
            textColor: Colors.white,
            buttonColor: Colors.purple,
          );
  }
}
