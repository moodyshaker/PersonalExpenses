import 'package:flutter/material.dart';

import 'bottom_sheet_dialog.dart';

class FAB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.yellow[700],
      child: Icon(
        Icons.add,
        color: Colors.black,
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
            ));
      },
    );
  }
}
