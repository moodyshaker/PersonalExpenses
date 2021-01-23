
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:personal_expenses/app_logic/app_logic.dart';
import 'package:personal_expenses/widgets/check_button.dart';
import 'package:personal_expenses/widgets/input_field.dart';
import 'package:personal_expenses/widgets/or_widget.dart';
import 'package:personal_expenses/widgets/social_icons.dart';
import 'package:provider/provider.dart';

class CheckEmail extends StatefulWidget {
  static const String id = 'CHECK_EMAIL';

  @override
  _CheckEmailState createState() => _CheckEmailState();
}

class _CheckEmailState extends State<CheckEmail> {
  FocusNode _focusNode;
  bool _checkEmailHasFocus = false;
  AppLogic _logic;
  String _errorMsg;

  @override
  void initState() {
    super.initState();
    _logic = Provider.of<AppLogic>(context, listen: false);
    _logic.initEmailCheckingControllers();
    _logic.emailCheckController.addListener(() {
      setState(() {
        EmailValidator.validate(_logic.emailCheckController.text)
            ? _errorMsg = null
            : _errorMsg = 'Please enter valid email';
      });
    });
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {
        _checkEmailHasFocus = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _logic.emailCheckControllerDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Consumer<AppLogic>(
            builder: (context, data, child) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InputField(
                  isPassword: false,
                  preIcon: Icons.mail_outline,
                  focusNode: _focusNode,
                  errorMsg: _errorMsg,
                  isFocused: _checkEmailHasFocus,
                  controller: data.emailCheckController,
                  labelText: 'Enter your email',
                  type: TextInputType.emailAddress,
                ),
                SizedBox(
                  height: 20.0,
                ),
                OrWidget(),
                SizedBox(
                  height: 20.0,
                ),
                SocialIcons(
                  data: data,
                ),
                SizedBox(
                  height: 20.0,
                ),
                CheckButton(
                  data: data,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
