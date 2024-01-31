import 'package:expenses_tracker/models/expense.dart';
import 'package:expenses_tracker/widget/expenses_list/expenses_item.dart';
import 'package:flutter/material.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({super.key, required this.expenses, required this.onItemDismissed});

  final Function(Expense) onItemDismissed;
  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (context, index) => Dismissible(
            onDismissed: (direction) {
              onItemDismissed(expenses[index]);
            },
            background: Container(
              color: Theme.of(context).colorScheme.error.withOpacity(0.75),
              margin: EdgeInsets.symmetric(horizontal: Theme.of(context).cardTheme.margin!.horizontal),
            ),
            key: ValueKey(expenses[index]),
            child: ExpensesItem(expenses[index])
        )
    );
  }}