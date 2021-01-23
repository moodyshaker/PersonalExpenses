import 'package:flutter/material.dart';
import 'package:personal_expenses/app_logic/app_logic.dart';

import 'bottom_sheet_dialog.dart';
import 'header.dart';

class IosAdd extends StatelessWidget {
  final AppLogic data;
  final bool isPortrait;

  IosAdd({
    this.data,
    this.isPortrait,
  });

  @override
  Widget build(BuildContext context) {
    return isPortrait
        ? IconButton(
            icon: Icon(
              Icons.add,
            ),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => SingleChildScrollView(
                  child: BottomSheetDialog(
                    isUpdated: false,
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20.0),
                    topLeft: Radius.circular(20.0),
                  ),
                ),
              );
            },
          )
        : FlatButton.icon(
            textColor: Colors.white,
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => SingleChildScrollView(
                  child: BottomSheetDialog(
                    isUpdated: false,
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20.0),
                    topLeft: Radius.circular(20.0),
                  ),
                ),
              );
            },
            icon: Icon(
              Icons.add,
            ),
            label: Header(
              text: 'Add',
              color: Colors.white,
              size: 16.0,
            ),
          );
  }
}
