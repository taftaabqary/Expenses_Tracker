import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

final formatter = DateFormat.yMd();

const uuid = Uuid();

enum Category { food, leisure, work, travel }

final categoryIcon = {
  Category.work: Icons.work,
  Category.food: Icons.fastfood_rounded,
  Category.travel: Icons.travel_explore,
  Category.leisure: Icons.shopping_cart
};

class Expense {
  Expense(
      {required this.title,
      required this.amount,
      required this.date,
      required this.category})
      : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formattedDateTime {
    return formatter.format(date);
  }
}

class ExpensesChart {
  ExpensesChart({required this.expenses, required this.category});

  ExpensesChart.forCategory(List<Expense> expense, this.category)
      : expenses = expense.where((value) => value.category == category).toList();

  Category category;
  final List<Expense> expenses;

  double get expensesTotal {
    var num = 0.0;

    for (final expense in expenses) {
      num += expense.amount;
    }

    return num;
  }
}
