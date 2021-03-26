import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class InputField extends StatefulWidget {
  final String labelText;
  final TextEditingController controller;
  final Function onTap;
  final TextInputType type;
  final TextCapitalization capitalization;
  final FocusNode focusNode;
  final bool isFocused;
  final String errorMsg;
  final bool isPassword;
  final IconData preIcon;

  InputField(
      {this.labelText,
      this.controller,
      this.onTap,
      this.type,
      this.capitalization,
      this.focusNode,
      this.isFocused,
      this.isPassword,
      this.errorMsg,
      this.preIcon});

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: widget.focusNode,
      textCapitalization: widget.capitalization ?? TextCapitalization.none,
      controller: widget.controller,
      onTap: widget.onTap,
      keyboardType: widget.type,
      obscureText: widget.isPassword ? _isObscure : false,
      decoration: InputDecoration(
        focusColor: Colors.purple,
        prefixIcon: widget.preIcon != null
            ? Icon(
                widget.preIcon,
                color: Colors.grey,
              )
            : null,
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _isObscure ? Icons.remove_red_eye : MaterialCommunityIcons.eye_off,
                  color: Colors.grey,
                ),
                onPressed: widget.isPassword
                    ? () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      }
                    : null,
              )
            : null,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: Colors.purple,
          ),
        ),
        labelStyle:
            TextStyle(color: widget.isFocused ? Colors.purple : Colors.grey),
        labelText: widget.labelText,
        errorText: widget.errorMsg,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }
}
