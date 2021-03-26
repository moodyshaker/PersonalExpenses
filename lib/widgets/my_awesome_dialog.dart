import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:personal_expenses/app_logic/app_logic.dart';

import 'header.dart';

class DeleteAllAction extends StatelessWidget {
  final AppLogic data;
  final bool isPortrait;

  DeleteAllAction({
    this.data,
    this.isPortrait,
  });

  @override
  Widget build(BuildContext context) {
    return isPortrait
        ? IconButton(
            icon: Icon(
              Icons.delete,
            ),
            onPressed: () {
              data.transactionList.length > 0
                  ? AwesomeDialog(
                      context: context,
                      dialogType: DialogType.NO_HEADER,
                      title: 'Delete All',
                      desc: 'Do you want to delete all expenses ?',
                      btnCancelOnPress: () {},
                      btnOkText: 'Yes',
                      btnOkColor: Colors.purple,
                      btnOkOnPress: () {
                        data.deleteAll();
                        data.getTransactionList(data.getUserId());
                      }).show()
                  : Fluttertoast.showToast(msg: 'There is nothing to delete');
            },
          )
        : FlatButton.icon(
            textColor: Colors.white,
            onPressed: () {
              data.transactionList.length > 0
                  ? AwesomeDialog(
                      context: context,
                      dialogType: DialogType.NO_HEADER,
                      title: 'Delete All',
                      desc: 'Do you want to delete all expenses ?',
                      btnCancelOnPress: () {},
                      btnOkText: 'Yes',
                      btnOkColor: Colors.purple,
                      btnOkOnPress: () {
                        data.deleteAll();
                        data.getTransactionList(data.getUserId());
                      }).show()
                  : Fluttertoast.showToast(msg: 'There is nothing to delete');
            },
            icon: Icon(
              Icons.delete,
            ),
            label: Header(
              text: 'Delete All',
              color: Colors.white,
              size: 16.0,
            ),
          );
  }
}
