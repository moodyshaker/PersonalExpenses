import 'package:flutter/material.dart';

import 'alert_dialog.dart';

class PopScopeWidget extends StatelessWidget {
  final Widget child;

  PopScopeWidget({
    @required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => MyDialog(),
        );
        return false;
      },
      child: child,
    );
  }
}
