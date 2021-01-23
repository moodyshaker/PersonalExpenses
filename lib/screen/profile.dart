import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:personal_expenses/app_logic/app_logic.dart';
import 'package:personal_expenses/widgets/header.dart';
import 'package:personal_expenses/widgets/logout_button.dart';
import 'package:personal_expenses/widgets/profile_image.dart';
import 'package:personal_expenses/widgets/username_container.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  static const String id = 'PROFILE';

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Consumer<AppLogic>(
        builder: (context, data, child) => ModalProgressHUD(
          inAsyncCall: data.checking,
          child: Card(
            elevation: 6.0,
            margin: const EdgeInsets.all(
              12.0,
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ProfileImage(
                    data: data,
                  ),
                  SizedBox(
                    height: size.height * 0.025,
                  ),
                  UsernameContainer(
                    data: data,
                  ),
                  SizedBox(
                    height: size.height * 0.025,
                  ),
                  data.getUserEmail() != null
                      ? Header(
                          text: data.getUserEmail(),
                          size: 24.0,
                          color: Colors.grey[600],
                        )
                      : Container(),
                  SizedBox(
                    height: size.height * 0.025,
                  ),
                  LogoutButton(
                    data: data,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
