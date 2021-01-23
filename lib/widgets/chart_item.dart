import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:personal_expenses/widgets/chart_progress.dart';

class ChartItem extends StatelessWidget {
  final String amount;
  final String date;
  final double totalWeekAmount;
  final bool isToday;

  ChartItem({
    this.amount,
    this.date,
    this.totalWeekAmount,
    this.isToday,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: isToday
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.purple[100],
              )
            : null,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ChartProgress(
              itemAmount: amount,
              fractionHeight: (double.parse(amount) / totalWeekAmount),
            ),
            SizedBox(
              height: 10,
            ),
            Text(date),
          ],
        ),
      ),
    );
  }
}
