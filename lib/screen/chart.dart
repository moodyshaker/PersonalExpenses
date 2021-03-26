import 'package:flutter/material.dart';
import 'package:personal_expenses/app_logic/app_logic.dart';
import 'package:personal_expenses/widgets/chart_card.dart';

class Chart extends StatelessWidget {
  static const String id = 'CHART';

  final AppLogic data;

  Chart({
    this.data,
  });

  @override
  Widget build(BuildContext context) {
    return ChartCard(
      data: data,
    );
  }
}
