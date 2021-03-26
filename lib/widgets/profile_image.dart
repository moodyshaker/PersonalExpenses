import 'dart:io';

import 'package:flutter/material.dart';
import 'package:personal_expenses/app_logic/app_logic.dart';

import 'get_image_bsd.dart';

class ProfileImage extends StatelessWidget {
  final AppLogic data;

  ProfileImage({
    this.data,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.purple,
      radius: 50.0,
      child: Stack(
        alignment: Alignment.center,
        children: [
          data.getUserImage() != null
              ? CircleAvatar(
                  backgroundImage: data.getUserImage().contains('http')
                      ? NetworkImage(data.getUserImage())
                      : FileImage(
                          File(data.getUserImage()),
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
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.0),
                    topRight: Radius.circular(12.0),
                  ),
                ),
                context: context,
                builder: (context) => GetImageDialog(
                  data: data,
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
    );
  }
}
