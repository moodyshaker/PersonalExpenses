import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:personal_expenses/app_logic/app_logic.dart';

import 'bottom_sheet_dialog.dart';

class ItemActionIcons extends StatelessWidget {
  final AppLogic data;
  final int index;

  ItemActionIcons({
    this.data,
    this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 35.0,
          height: 35.0,
          decoration: BoxDecoration(
              color: Colors.grey[600],
              borderRadius: BorderRadius.circular(17.5)),
          child: IconButton(
            icon: Icon(
              Icons.edit,
              color: Colors.white,
              size: 20.0,
            ),
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) => SingleChildScrollView(
                        child: BottomSheetDialog(
                          isUpdated: true,
                          model: data.transactionList[index],
                        ),
                      ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20.0),
                      topLeft: Radius.circular(20.0),
                    ),
                  ));
            },
          ),
        ),
        SizedBox(
          width: 4.0,
        ),
        Container(
          width: 35.0,
          height: 35.0,
          decoration: BoxDecoration(
              color: Colors.red, borderRadius: BorderRadius.circular(17.5)),
          child: IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.white,
              size: 20.0,
            ),
            onPressed: () async{
              data.delete(data.transactionList[index]);
              data.getTransactionList(data.getUserId());
              bool isDeleted = await Fluttertoast.showToast(
                msg: 'Item deleted successfully',
              );
              print('Is deleted -> $isDeleted');
            },
          ),
        ),
      ],
    );
  }
}
