import 'package:expenses_tracker/models/expense.dart';
import 'package:flutter/material.dart';

import 'chart_bar.dart';

class Chart extends StatelessWidget {
  const Chart({super.key, required this.expenses});

  final List<Expense> expenses;

  List<ExpensesChart> get charts {
    return [
      ExpensesChart.forCategory(expenses, Category.food),
      ExpensesChart.forCategory(expenses, Category.leisure),
      ExpensesChart.forCategory(expenses, Category.travel),
      ExpensesChart.forCategory(expenses, Category.work),
    ];
  }

  double get maxTotalExpense {
    double maxTotalExpense = 0;

    for (final chart in charts) {
      if (chart.expensesTotal > maxTotalExpense) {
        maxTotalExpense = chart.expensesTotal;
      }
    }

    return maxTotalExpense;
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 8,
      ),
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.3),
            Theme.of(context).colorScheme.primary.withOpacity(0.0)
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (final chart in charts) // alternative to map()
                  ChartBar(
                    fill: (chart.expensesTotal == 0) ? 0 : chart.expensesTotal / maxTotalExpense,
                  )
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: charts.map((chart) => Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Icon(
                    categoryIcon[chart.category],
                    color: isDarkMode ? Theme.of(context).colorScheme.secondary : Theme.of(context)
                        .colorScheme
                        .primary
                        .withOpacity(0.7),
                  ),
                ),
              ),
            ).toList(),
          )
        ],
      ),
    );
  }
}