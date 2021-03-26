import 'package:flutter/material.dart';

class ChartProgress extends StatelessWidget {
  final double fractionHeight;
  final String itemAmount;

  ChartProgress({
    this.fractionHeight,
    this.itemAmount,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FittedBox(child: Text('$itemAmount')),
        SizedBox(
          height: 10.0,
        ),
        Container(
          height: 60,
          width: 10,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.grey,
                ),
              ),
              FractionallySizedBox(
                heightFactor: fractionHeight,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
