import 'dart:io';

import 'package:flutter/material.dart';
import 'package:personal_expenses/app_logic/app_logic.dart';
import 'package:personal_expenses/screen/profile.dart';

class ProfileIcon extends StatelessWidget {
  final AppLogic logic;

  ProfileIcon({
    this.logic,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Profile.id);
      },
      child: CircleAvatar(
        backgroundColor: Colors.white,
        radius: 18.0,
        child: logic.getUserImage() != null
            ? CircleAvatar(
                backgroundImage: logic.getUserImage().contains('http')
                    ? NetworkImage(logic.getUserImage())
                    : FileImage(
                        File(logic.getUserImage()),
                      ),
                radius: 17.0,
              )
            : Icon(
                Icons.account_circle,
                color: Colors.grey,
                size: 34.0,
              ),
      ),
    );
  }
}
