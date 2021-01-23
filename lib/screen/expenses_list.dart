import 'package:flutter/material.dart';
import 'package:personal_expenses/app_logic/app_logic.dart';
import 'package:personal_expenses/widgets/content_list.dart';

class ExpensesList extends StatelessWidget {
  static const String id = 'EXPENSES_LIST';
  final AppLogic data;

  ExpensesList({
    this.data,
  });

  @override
  Widget build(BuildContext context) {
    return ContentList(
      data: data,
    );
  }
}
