import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:personal_expenses/app_logic/app_logic.dart';
import 'package:personal_expenses/widgets/header.dart';
import 'package:provider/provider.dart';

import 'info_button.dart';
import 'input_field.dart';

class EditUsernameBSD extends StatefulWidget {
  final AppLogic data;

  EditUsernameBSD({
    this.data,
  });

  @override
  _EditUsernameBSDState createState() => _EditUsernameBSDState();
}

class _EditUsernameBSDState extends State<EditUsernameBSD> {
  FocusNode _focusNode;
  bool _isFocused = false;
  String _errorMsg;
  AppLogic _logic;

  @override
  void initState() {
    super.initState();
    _logic = Provider.of<AppLogic>(context, listen: false);
    _logic.initProfileChangeNameController();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
    _logic.profileChangeNameController.addListener(() {
      setState(() {
        _logic.profileChangeNameController.text.length < 4
            ? _errorMsg = 'Please enter proper name'
            : _errorMsg = null;
      });
    });
  }

  @override
  void dispose() {
    _logic.profileCHangeNameControllerDispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Header(
                text: 'Your new username',
                size: 24.0,
              )
            ],
          ),
          SizedBox(
            height: 8.0,
          ),
          InputField(
            isPassword: false,
            isFocused: _isFocused,
            errorMsg: _errorMsg,
            preIcon: Icons.person,
            focusNode: _focusNode,
            controller: widget.data.profileChangeNameController,
            labelText: 'Enter your new name',
          ),
          SizedBox(
            height: 8.0,
          ),
           InfoButton(
            textColor: Colors.white,
            buttonColor: Colors.purple,
            onPress: () async {
              if (widget.data.profileChangeNameController.text.length >= 4) {
                Navigator.pop(context);
                widget.data.setChecking(true);
                await widget.data.updateProfile(
                    username: widget.data.profileChangeNameController.text);
                await widget.data.saveUser(widget.data.getCurrentUser);
                Fluttertoast.showToast(
                    msg: 'your username changed successfully');
                widget.data.setChecking(false);
              }
            },
            name: 'Update',
          ),
        ],
      ),
    );
  }
}
