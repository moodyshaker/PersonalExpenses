import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:personal_expenses/app_logic/app_logic.dart';
import 'package:personal_expenses/app_logic/auth.dart';
import 'package:personal_expenses/widgets/header.dart';
import 'package:personal_expenses/widgets/info_button.dart';
import 'package:personal_expenses/widgets/input_field.dart';
import 'package:provider/provider.dart';

import 'home.dart';

class Login extends StatefulWidget {
  static const String id = 'LOGIN';

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  FocusNode _loginEmailNode, _loginPasswordNode;
  bool _emailHasFocus = false;
  bool _passwordHasFocus = false;
  String _emailErrorMsg;
  String _passwordErrorMsg;
  AppLogic _appLogic;

  @override
  void initState() {
    super.initState();
    _appLogic = Provider.of<AppLogic>(context, listen: false);
    _loginEmailNode = FocusNode();
    _loginPasswordNode = FocusNode();
    _appLogic.initLoginControllers();
    _loginEmailNode.addListener(() {
      setState(() {
        _emailHasFocus = _loginEmailNode.hasFocus;
      });
    });
    _loginPasswordNode.addListener(() {
      setState(() {
        _passwordHasFocus = _loginPasswordNode.hasFocus;
      });
    });
    _appLogic.loginEmailController.addListener(() {
      setState(() {
        EmailValidator.validate(_appLogic.loginEmailController.text)
            ? _emailErrorMsg = null
            : _emailErrorMsg = 'Please enter valid email';
      });
    });
    _appLogic.loginPasswordController.addListener(() {
      setState(() {
        _appLogic.loginPasswordController.text.length < 6
            ? _passwordErrorMsg = 'Please enter al least 6 digit'
            : _passwordErrorMsg = null;
      });
    });
    _appLogic.loginEmailController.text = _appLogic.getUserEmail();
  }

  @override
  void dispose() {
    _loginEmailNode.dispose();
    _loginPasswordNode.dispose();
    _appLogic.loginDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        margin: EdgeInsets.only(
          top: size.height * 0.1,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(120),
          ),
          color: Colors.purple,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.08,
          vertical: size.height * 0.07,
        ),
        child: Consumer<AppLogic>(
          builder: (context, data, child) => SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Header(
                  text: 'LOGIN',
                  color: Colors.white,
                  size: 40.0,
                ),
                SizedBox(
                  height: size.height * 0.025,
                ),
                Card(
                  elevation: 6.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(
                      20.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InputField(
                          focusNode: _loginEmailNode,
                          controller: data.loginEmailController,
                          labelText: 'Enter Your Email',
                          errorMsg: _emailErrorMsg,
                          isFocused: _emailHasFocus,
                          isPassword: false,
                          preIcon: Icons.mail_outline,
                        ),
                        SizedBox(
                          height: size.height * 0.025,
                        ),
                        InputField(
                          focusNode: _loginPasswordNode,
                          controller: data.loginPasswordController,
                          errorMsg: _passwordErrorMsg,
                          labelText: 'Enter your password',
                          isFocused: _passwordHasFocus,
                          isPassword: true,
                          preIcon: Icons.lock,
                        ),
                        SizedBox(
                          height: size.height * 0.020,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                String msg = await data.forgetPassword(
                                    data.loginEmailController.text);
                                if (msg == Auth.SUCCESS_MSG) {
                                  Fluttertoast.showToast(
                                      msg: 'Email sent successfully');
                                } else {
                                  Fluttertoast.showToast(msg: msg);
                                }
                              },
                              child: Header(
                                text: 'forget password'.toUpperCase(),
                                size: 16.0,
                                color: Colors.grey[600],
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.025,
                        ),
                        data.checking
                            ? CircularProgressIndicator()
                            :  InfoButton(
                                onPress: () async {
                                  if (EmailValidator.validate(
                                          data.loginEmailController.text) &&
                                      data.loginPasswordController.text
                                              .length >=
                                          6) {
                                    data.setChecking(true);
                                    String msg = await data.userLogin(
                                        data.loginEmailController.text,
                                        data.loginPasswordController.text);
                                    if (msg == Auth.SUCCESS_MSG) {
                                      String msg = await data
                                          .saveUser(data.getCurrentUser);
                                      if (msg == Auth.SUCCESS_MSG) {
                                        Navigator.pushReplacementNamed(
                                            context, Home.id);
                                      }
                                    } else {
                                      Fluttertoast.showToast(msg: msg);
                                    }
                                    data.setChecking(false);
                                  }
                                },
                                buttonColor: Colors.purple,
                                textColor: Colors.white,
                                name: 'SIGN IN',
                              ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
