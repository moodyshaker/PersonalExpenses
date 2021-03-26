import 'package:flutter/material.dart';
import 'package:personal_expenses/app_logic/app_logic.dart';
import 'empty_content.dart';
import 'list_item.dart';

class ContentList extends StatelessWidget {
  final AppLogic data;

  ContentList({
    this.data,
  });

  @override
  Widget build(BuildContext context) {
    return data.isPopulating
        ? Center(
            child: CircularProgressIndicator(),
          )
        : !data.isListEmpty
            ? ListView.builder(
                itemCount: data.transactionList.length,
                itemBuilder: (context, i) => ListItem(
                  data: data,
                  index: i,
                ),
              )
            : EmptyContent();
  }
}
