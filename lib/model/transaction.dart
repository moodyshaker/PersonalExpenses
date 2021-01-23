import 'package:flutter/foundation.dart';

class TransactionModel {
  int id;
  String title;
  double amount;
  DateTime date;
  String userId;

  TransactionModel({
    @required this.title,
    @required this.amount,
    @required this.date,
    @required this.userId,
  });

  TransactionModel.withId({
    @required this.id,
    @required this.title,
    @required this.amount,
    @required this.date,
    @required this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      if (id != null) '_id': id,
      'title': title,
      'amount': amount,
      'date': date.toIso8601String(),
      'user_id': userId,
    };
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel.withId(
        id: map['_id'],
        title: map['title'],
        amount: map['amount'],
        date: DateTime.parse(map['date']),
        userId: map['user_id']);
  }

  @override
  String toString() {
    return 'id -> $id '
        'title -> $title '
        'amount -> $amount '
        'date -> $date '
        'userId -> $userId';
  }
}
