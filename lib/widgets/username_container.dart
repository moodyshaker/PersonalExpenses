import 'package:flutter/material.dart';
import 'package:personal_expenses/app_logic/app_logic.dart';

import 'edit_name_bsd.dart';
import 'header.dart';

class UsernameContainer extends StatelessWidget {
  final AppLogic data;

  UsernameContainer({
    this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        data.getUserName() != null
            ? Header(
                text: data.getUserName(),
                size: 30.0,
                color: Colors.black,
              )
            : Container(),
        SizedBox(
          width: 6.0,
        ),
        IconButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.0),
                  topRight: Radius.circular(12.0),
                ),
              ),
              builder: (context) => EditUsernameBSD(data: data),
            );
          },
          icon: Icon(
            Icons.edit,
            size: 26.0,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}
