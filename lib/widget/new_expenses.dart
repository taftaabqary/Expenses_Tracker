import 'dart:io';

import 'package:expenses_tracker/models/expense.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewExpenses extends StatefulWidget {
  const NewExpenses({super.key, required this.saveExpense});

  final Function(Expense) saveExpense;

  @override
  State<StatefulWidget> createState() {
    return _NewExpensesState();
  }
}

class _NewExpensesState extends State<NewExpenses> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? datePickerValue;
  Category? _selectedCategory = Category.leisure;

  void presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);

    setState(() {
      datePickerValue = pickedDate;
    });
  }

  void _showDialog() {
    if(Platform.isIOS) {
      showCupertinoDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Invalid Value Form'),
            content: const Text(
                'Please check again the value of title expenses, amount expenses, date expenses, and category expenses'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Okay'))
            ],
          )
      );
    } else {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Invalid Value Form'),
            content: const Text(
                'Please check again the value of title expenses, amount expenses, date expenses, and category expenses'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Okay'))
            ],
          )
      );
    }
  }

  void showFormAlert() {
    final amountValue = _amountController.text;
    final amountParsed = double.tryParse(amountValue);
    final invalidAmount = amountParsed == null || amountParsed < 0;
    if (_titleController.text.trim().isEmpty ||
        invalidAmount ||
        datePickerValue == null) {
      _showDialog();
      return;
    }

    final newExpenses = Expense(
        title: _titleController.text,
        amount: amountParsed,
        date: datePickerValue!,
        category: _selectedCategory!
    );

    widget.saveExpense(newExpenses);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return LayoutBuilder(builder: (ctx, constraints) {
      final maxWidth = constraints.maxWidth;

      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(18, 18, 18, keyboardSpace + 16),
            child: Column(
              children: [
                if (maxWidth > 600)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _titleController,
                          maxLength: 50,
                          keyboardType: TextInputType.name,
                          decoration:
                              const InputDecoration(label: Text('Title')),
                        ),
                      ),
                      const SizedBox(width: 18),
                      Expanded(
                        child: TextField(
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              label: Text('Amount'), prefixText: '\$ '),
                        ),
                      ),
                    ],
                  )
                else
                  TextField(
                    controller: _titleController,
                    maxLength: 50,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(label: Text('Title')),
                  ),
                if (maxWidth > 600)
                  Row(
                    children: [
                      DropdownButton(
                          value: _selectedCategory,
                          items: Category.values.map((category) {
                            return DropdownMenuItem(
                                value: category,
                                child: Text(category.name.toUpperCase()));
                          }).toList(),
                          onChanged: (value) {
                            if (value == null) {
                              return;
                            }
                            setState(() {
                              _selectedCategory = value;
                            });
                          }),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text((datePickerValue == null)
                                ? 'Set a date'
                                : formatter.format(datePickerValue!)),
                            IconButton(
                                onPressed: presentDatePicker,
                                icon: const Icon(Icons.date_range))
                          ],
                        ),
                      ),
                    ],
                  )
                else
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              label: Text('Amount'), prefixText: '\$ '),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text((datePickerValue == null)
                              ? 'Set a date'
                              : formatter.format(datePickerValue!)),
                              IconButton(
                                  onPressed: presentDatePicker,
                                  icon: const Icon(Icons.date_range))
                        ],
                      ))
                    ],
                  ),
                const SizedBox(height: 24),
                if (maxWidth > 600)
                  Row(
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel')),
                      ElevatedButton(
                          onPressed: () {
                            showFormAlert();
                            Navigator.pop(context);
                          },
                          child: const Text('Save Expense')),
                    ],
                  )
                else
                  Row(
                    children: [
                      DropdownButton(
                          value: _selectedCategory,
                          items: Category.values.map((category) {
                            return DropdownMenuItem(
                                value: category,
                                child: Text(category.name.toUpperCase()));
                          }).toList(),
                          onChanged: (value) {
                            if (value == null) {
                              return;
                            }
                            setState(() {
                              _selectedCategory = value;
                            });
                          }),
                      const Spacer(),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel')),
                      ElevatedButton(
                          onPressed: () {
                            showFormAlert();
                            Navigator.pop(context);
                          },
                          child: const Text('Save Expense')),
                    ],
                  )
              ],
            ),
          ),
        ),
      );
    });
  }
}
