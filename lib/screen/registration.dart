import 'dart:io';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:personal_expenses/app_logic/app_logic.dart';
import 'package:personal_expenses/app_logic/auth.dart';
import 'package:personal_expenses/utils.dart';
import 'package:personal_expenses/widgets/header.dart';
import 'package:personal_expenses/widgets/info_button.dart';
import 'package:personal_expenses/widgets/input_field.dart';
import 'package:provider/provider.dart';
import 'home.dart';

class Registration extends StatefulWidget {
  static const String id = 'REGISTRATION';

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final _picker = ImagePicker();
  String _imagePath;
  FocusNode _registerEmailNode,
      _registerPasswordNode,
      _registerConfirmEmailNode,
      _registerConfirmPasswordNode,
      _registerFirstNameNode,
      _registerLastNameNode;
  bool _emailHasFocus = false;
  bool _confirmEmailHasFocus = false;
  bool _passwordHasFocus = false;
  bool _confirmPasswordHasFocus = false;
  bool _firstNameHasFocus = false;
  bool _lastNameHasFocus = false;
  String _emailErrorMsg;
  String _confirmEmailErrorMsg;
  String _passwordErrorMsg;
  String _confirmPasswordErrorMsg;
  String _firstNameErrorMsg;
  String _lastNameErrorMsg;
  AppLogic _appLogic;

  @override
  void initState() {
    super.initState();
    _appLogic = Provider.of<AppLogic>(context, listen: false);
    _registerEmailNode = FocusNode();
    _registerConfirmEmailNode = FocusNode();
    _registerPasswordNode = FocusNode();
    _registerConfirmPasswordNode = FocusNode();
    _registerFirstNameNode = FocusNode();
    _registerLastNameNode = FocusNode();
    _appLogic.initRegistrationControllers();
    _registerEmailNode.addListener(() {
      setState(() {
        _emailHasFocus = _registerEmailNode.hasFocus;
      });
    });
    _registerConfirmEmailNode.addListener(() {
      setState(() {
        _confirmEmailHasFocus = _registerConfirmEmailNode.hasFocus;
      });
    });
    _registerPasswordNode.addListener(() {
      setState(() {
        _passwordHasFocus = _registerPasswordNode.hasFocus;
      });
    });
    _registerConfirmPasswordNode.addListener(() {
      setState(() {
        _confirmPasswordHasFocus = _registerConfirmPasswordNode.hasFocus;
      });
    });
    _registerFirstNameNode.addListener(() {
      setState(() {
        _firstNameHasFocus = _registerFirstNameNode.hasFocus;
      });
    });
    _registerLastNameNode.addListener(() {
      setState(() {
        _lastNameHasFocus = _registerLastNameNode.hasFocus;
      });
    });
    _appLogic.registrationEmailController.addListener(() {
      setState(() {
        EmailValidator.validate(_appLogic.registrationEmailController.text)
            ? _emailErrorMsg = null
            : _emailErrorMsg = 'Please enter valid email';
      });
    });
    _appLogic.registrationConfirmEmailController.addListener(() {
      setState(() {
        EmailValidator.validate(
                _appLogic.registrationConfirmEmailController.text)
            ? _confirmEmailErrorMsg = null
            : _confirmEmailErrorMsg = 'Please check your email';
      });
    });
    _appLogic.registrationPasswordController.addListener(() {
      setState(() {
        _appLogic.registrationPasswordController.text.length < 6
            ? _passwordErrorMsg = 'Please enter al least 6 digit'
            : _passwordErrorMsg = null;
      });
    });
    _appLogic.registrationConfirmPasswordController.addListener(() {
      setState(() {
        _appLogic.registrationConfirmPasswordController.text.length < 6
            ? _confirmPasswordErrorMsg = 'Please enter al least 6 digit'
            : _confirmPasswordErrorMsg = null;
      });
    });
    _appLogic.registrationFirstNameController.addListener(() {
      setState(() {
        _appLogic.registrationFirstNameController.text.length < 4
            ? _firstNameErrorMsg = 'Please enter al least 4 digit'
            : _firstNameErrorMsg = null;
      });
    });
    _appLogic.registrationLastNameController.addListener(() {
      setState(() {
        _appLogic.registrationLastNameController.text.length < 4
            ? _lastNameErrorMsg = 'Please enter al least 4 digit'
            : _lastNameErrorMsg = null;
      });
    });
    _appLogic.registrationEmailController.text = _appLogic.getUserEmail();
    _appLogic.registrationConfirmEmailController.text =
        _appLogic.getUserEmail();
    if (_appLogic.getUserType() == SignMethod.GOOGLE.toString() ||
        _appLogic.getUserType() == SignMethod.FACEBOOK.toString()) {
      _appLogic.registrationFirstNameController.text =
          _appLogic.getUserName().split(' ')[0];
      _appLogic.registrationLastNameController.text =
          _appLogic.getUserName().split(' ')[1];
      _imagePath = _appLogic.getUserImage();
    }
  }

  @override
  void dispose() {
    _registerEmailNode.dispose();
    _registerConfirmEmailNode.dispose();
    _registerConfirmPasswordNode.dispose();
    _registerPasswordNode.dispose();
    _registerFirstNameNode.dispose();
    _registerLastNameNode.dispose();
    _appLogic.registrationControllersDispose();
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
          vertical: size.height * 0.04,
        ),
        child: Consumer<AppLogic>(
          builder: (context, data, child) => SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Header(
                  text: 'REGISTRATION',
                  color: Colors.white,
                  size: 40.0,
                ),
                SizedBox(
                  height: size.height * 0.015,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 50.0,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          _imagePath != null
                              ? CircleAvatar(
                                  backgroundImage: _imagePath.contains('http')
                                      ? NetworkImage(_imagePath)
                                      : FileImage(
                                          File(_imagePath),
                                        ),
                                  radius: 48.0,
                                )
                              : Icon(
                                  Icons.account_circle,
                                  color: Colors.grey,
                                  size: 100.0,
                                ),
                          GestureDetector(
                            onTap: () async {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) => Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      GestureDetector(
                                        onTap: () async {
                                          await getImage(ImageSource.camera);
                                          Navigator.pop(context);
                                        },
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.camera_alt,
                                              color: Colors.black,
                                              size: 30.0,
                                            ),
                                            SizedBox(
                                              width: 8.0,
                                            ),
                                            const Text(
                                              'Camera',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.w800,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8.0,
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          await getImage(ImageSource.gallery);
                                          Navigator.pop(context);
                                        },
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.image,
                                              color: Colors.black,
                                              size: 30.0,
                                            ),
                                            SizedBox(
                                              width: 8.0,
                                            ),
                                            const Text(
                                              'Gallery',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.w800,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                            child: CircleAvatar(
                              radius: 50.0,
                              backgroundColor: Colors.black.withOpacity(0.2),
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: CircleAvatar(
                                  radius: 20.0,
                                  child: Icon(
                                    Icons.camera_alt,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.015,
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
                        Row(
                          children: [
                            Expanded(
                              child: InputField(
                                focusNode: _registerFirstNameNode,
                                controller:
                                    data.registrationFirstNameController,
                                labelText: 'First Name',
                                errorMsg: _firstNameErrorMsg,
                                isFocused: _firstNameHasFocus,
                                isPassword: false,
                                preIcon: Icons.person,
                              ),
                            ),
                            SizedBox(
                              width: size.height * 0.020,
                            ),
                            Expanded(
                              child: InputField(
                                focusNode: _registerLastNameNode,
                                controller: data.registrationLastNameController,
                                labelText: 'Last Name',
                                errorMsg: _lastNameErrorMsg,
                                isFocused: _lastNameHasFocus,
                                isPassword: false,
                                preIcon: Icons.person,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.025,
                        ),
                        InputField(
                          focusNode: _registerEmailNode,
                          controller: data.registrationEmailController,
                          labelText: 'Email',
                          errorMsg: _emailErrorMsg,
                          isFocused: _emailHasFocus,
                          isPassword: false,
                          preIcon: Icons.mail_outline,
                        ),
                        SizedBox(
                          height: size.height * 0.025,
                        ),
                        InputField(
                          focusNode: _registerConfirmEmailNode,
                          controller: data.registrationConfirmEmailController,
                          errorMsg: _confirmEmailErrorMsg,
                          labelText: 'Confirm Email',
                          isFocused: _confirmEmailHasFocus,
                          isPassword: false,
                          preIcon: Icons.mail_outline,
                        ),
                        SizedBox(
                          height: size.height * 0.020,
                        ),
                        InputField(
                          focusNode: _registerPasswordNode,
                          controller: data.registrationPasswordController,
                          errorMsg: _passwordErrorMsg,
                          labelText: 'Enter Password',
                          isFocused: _passwordHasFocus,
                          isPassword: true,
                          preIcon: Icons.lock,
                        ),
                        SizedBox(
                          height: size.height * 0.020,
                        ),
                        InputField(
                          focusNode: _registerConfirmPasswordNode,
                          controller:
                              data.registrationConfirmPasswordController,
                          errorMsg: _confirmPasswordErrorMsg,
                          labelText: 'Confirm Password',
                          isFocused: _confirmPasswordHasFocus,
                          isPassword: true,
                          preIcon: Icons.lock,
                        ),
                        SizedBox(
                          height: size.height * 0.020,
                        ),
                        data.checking
                            ? CircularProgressIndicator()
                            : InfoButton(
                                onPress: () async {
                                  if (!EmailValidator.validate(
                                      data.registrationEmailController.text)) {
                                    setState(() {
                                      _emailErrorMsg =
                                          'Please enter valid email';
                                    });
                                  } else if (!EmailValidator.validate(data
                                          .registrationConfirmEmailController
                                          .text) ||
                                      data.registrationConfirmEmailController
                                              .text !=
                                          data.registrationEmailController
                                              .text) {
                                    setState(() {
                                      _confirmEmailErrorMsg =
                                          'Please check your email';
                                    });
                                  } else if (data.registrationPasswordController
                                          .text.length <
                                      6) {
                                    setState(() {
                                      _passwordErrorMsg =
                                          'Please enter at least 6 digits';
                                    });
                                  } else if (data
                                              .registrationConfirmPasswordController
                                              .text
                                              .length <
                                          6 ||
                                      data.registrationConfirmPasswordController
                                              .text !=
                                          data.registrationPasswordController
                                              .text) {
                                    setState(() {
                                      _confirmPasswordErrorMsg =
                                          'Please check your password';
                                    });
                                  } else if (data
                                          .registrationFirstNameController
                                          .text
                                          .length <
                                      4) {
                                    setState(() {
                                      _firstNameErrorMsg =
                                          'Please enter at least 4 digits';
                                    });
                                  } else if (data.registrationLastNameController
                                          .text.length <
                                      4) {
                                    setState(() {
                                      _lastNameErrorMsg =
                                          'Please enter at least 4 digits';
                                    });
                                  } else {
                                    setState(() {
                                      _emailErrorMsg = null;
                                      _confirmEmailErrorMsg = null;
                                      _passwordErrorMsg = null;
                                      _confirmPasswordErrorMsg = null;
                                      _firstNameErrorMsg = null;
                                      _lastNameErrorMsg = null;
                                    });
                                    data.setChecking(true);
                                    String msg = await data.createNewUser(
                                      data.registrationConfirmEmailController
                                          .text,
                                      data.registrationConfirmPasswordController
                                          .text,
                                      username:
                                          '${data.registrationFirstNameController.text} ${data.registrationLastNameController.text}',
                                      photoUrl: _imagePath,
                                    );
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
                                name: 'SIGN UP',
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

  Future<String> getImage(ImageSource source) async {
    try {
      final pickedFile =
          await _picker.getImage(source: source, imageQuality: 50);
      setState(() {
        _imagePath = File(pickedFile.path).path;
      });
      return Auth.SUCCESS_MSG;
    } catch (e) {
      return e;
    }
  }
}
