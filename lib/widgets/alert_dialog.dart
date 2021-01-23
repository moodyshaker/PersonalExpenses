import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Exit',
        style: TextStyle(fontSize: 20.0),
      ),
      content: const Text('Do you want to exit the app ?'),
      actions: [
        FlatButton(
          onPressed: () {
            SystemNavigator.pop();
          },
          child: const Text('Yes i do'),
        ),
        FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('No i do not'),
        ),
      ],
    );
  }
}
