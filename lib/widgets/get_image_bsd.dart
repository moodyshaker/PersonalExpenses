import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:personal_expenses/app_logic/app_logic.dart';
import 'package:personal_expenses/app_logic/auth.dart';

class GetImageDialog extends StatelessWidget {
  final AppLogic data;
  String _msg;

  GetImageDialog({
    this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () async {
              _msg = await getImage(ImageSource.camera);
              Navigator.pop(context);
              uploadImage(_msg, data);
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
              _msg = await getImage(ImageSource.gallery);
              Navigator.pop(context);
              uploadImage(_msg, data);
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
    );
  }
  final _picker = ImagePicker();
  File _imagePath;

  Future<String> getImage(ImageSource source) async {
    try {
      final pickedFile =
          await _picker.getImage(source: source, imageQuality: 50);
      _imagePath = File(pickedFile.path);
      return Auth.SUCCESS_MSG;
    } catch (e) {
      return e;
    }
  }

  void uploadImage(String msg, AppLogic data) async {
    if (msg == Auth.SUCCESS_MSG) {
      try {
        data.setChecking(true);
        await data.updateProfile(photoUrl: _imagePath.path);
        await data.saveUser(data.getCurrentUser);
        Fluttertoast.showToast(msg: 'Photo changed successfully');
        data.setChecking(false);
      } catch (e) {
      }
    } else {
    }
  }
}
