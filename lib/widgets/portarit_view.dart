import 'package:flutter/material.dart';
import 'package:personal_expenses/app_logic/app_logic.dart';

import 'chart_card.dart';
import 'empty_content.dart';
import 'list_item.dart';

class PortraitView extends StatelessWidget {
  final AppLogic data;

  PortraitView({
    this.data,
  });

  @override
  Widget build(BuildContext context) {
    return data.isPopulating
        ? Center(
            child: CircularProgressIndicator(),
          )
        : !data.isListEmpty
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    ChartCard(
                      data: data,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: data.transactionList.length,
                      itemBuilder: (context, i) => ListItem(
                        data: data,
                        index: i,
                      ),
                    ),
                  ],
                ),
              )
            : EmptyContent();
  }
}
