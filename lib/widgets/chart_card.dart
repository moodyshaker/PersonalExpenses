import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/app_logic/app_logic.dart';
import 'package:personal_expenses/widgets/chart_item.dart';
import 'package:personal_expenses/widgets/header.dart';

class ChartCard extends StatelessWidget {
  final AppLogic data;
  final now = DateTime.now();

  ChartCard({
    this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10.0),
      elevation: 10.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Header(
              text: 'Recent',
              color: Colors.black,
              size: 25.0,
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: getMap()
                  .map(
                    (e) => ChartItem(
                      date: e['date'],
                      amount: e['amount'],
                      totalWeekAmount: e['total_week_amount'],
                      isToday: (e['real_date'] as DateTime).day == now.day &&
                          (e['real_date'] as DateTime).month == now.month &&
                          (e['real_date'] as DateTime).year == now.year,
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  List<Map<String, dynamic>> getMap() {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      var totalAmount = 0.0;
      var totalWeekAmount = 0.0;
      data.transactionList.forEach((element) {
        totalWeekAmount += element.amount;
        if (element.date.year == weekDay.year &&
            element.date.month == weekDay.month &&
            element.date.day == weekDay.day) {
          totalAmount += element.amount;
        }
      });
      return {
        'date': DateFormat('E').format(weekDay).substring(0, 1),
        'amount': totalAmount.toStringAsFixed(1),
        'total_week_amount': totalWeekAmount,
        'real_date': weekDay,
      };
    });
  }
}
