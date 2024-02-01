import 'package:expenses_tracker/widget/chart/chart.dart';
import 'package:expenses_tracker/widget/expenses_list/expenses_list.dart';
import 'package:expenses_tracker/widget/new_expenses.dart';
import 'package:flutter/material.dart';

import '../models/expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {

  final List<Expense> _registeredExpenses = [
    Expense(
        title: 'Flutter Course',
        amount: 20.43,
        date: DateTime.now(),
        category: Category.work
    ),

    Expense(
        title: 'Buy Skin Epic',
        amount: 210.23,
        date: DateTime.now(),
        category: Category.leisure
    )
  ];

  void _saveNewExpenses(Expense expenses) {
    setState(() {
      _registeredExpenses.add(expenses);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 3),
          content: const Text('Deleted Expense'),
          action: SnackBarAction(
              label: 'Undo',
              onPressed: () {
                setState(() {
                  _registeredExpenses.insert(expenseIndex, expense);
                });
              }
          ),
        )
    );
  }

  void _addNewExpense() {
    showModalBottomSheet(
        useSafeArea: true,
        isScrollControlled: true,
        context: context,
        builder: (ctx) => NewExpenses(saveExpense: _saveNewExpenses)
    );
  }

  @override
  Widget build(BuildContext context) {
    final widthScreen = MediaQuery.of(context).size.width;

    Widget contentExpenses = const Center(child: Text('No Expenses found, try to adding some!'));
  
    if(_registeredExpenses.isNotEmpty) {
      contentExpenses = ExpenseList(expenses: _registeredExpenses, onItemDismissed: _removeExpense);
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Expenses Tracker App'),
          actions: [
            IconButton(
                onPressed: _addNewExpense,
                icon: const Icon(Icons.add)
            )],
        ),
        body: (widthScreen < 600)
            ?
        Column(
          children: [
            Chart(expenses: _registeredExpenses),
            Expanded(
                child: contentExpenses
            )
          ],
        )
            :
        Row(
          children: [
            Expanded(
                child: Chart(expenses: _registeredExpenses)
            ),
            Expanded(
                child: contentExpenses
            )
          ],
        )
      );
  }
}
