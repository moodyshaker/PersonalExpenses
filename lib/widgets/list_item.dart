import 'package:flutter/material.dart';
import 'package:personal_expenses/app_logic/app_logic.dart';

import 'item_action_icons.dart';

class ListItem extends StatelessWidget {
  final AppLogic data;
  final int index;

  ListItem({
    this.data,
    this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      elevation: 4.0,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.purple,
          radius: 30.0,
          child: FittedBox(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '\$${data.transactionList[index].amount.toStringAsFixed(2)}',
                style: TextStyle(color: Colors.white, fontSize: 16.0),
              ),
            ),
          ),
        ),
        title: Text(
          '${data.transactionList[index].title}',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w800,
            fontSize: 18.0,
          ),
        ),
        subtitle: Text(
          data.formatDate(data.transactionList[index].date),
          style: TextStyle(
            color: Colors.grey[600],
            fontWeight: FontWeight.w600,
            fontSize: 15.0,
          ),
        ),
        trailing: ItemActionIcons(
          data: data,
          index: index,
        ),
      ),
    );
  }
}
