import 'package:flutter/material.dart';

import 'package:expense_tracker/widgets/expenses_list/expense_item.dart';
import 'package:expense_tracker/models/expense.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.expenses,
    required this.onRemoveExpense,
  });

  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense;

  // The expenses list can potentially be quite large, so using Column is not ideal
  // We don't want to create the entire list all at once in the build, because only 
  // a small amount of expenses are being shown simultaneously on screen
  // For a scrollable list like this, something like the Kotlin Adapter pattern 
  // & RecyclerView is needed - a scrollable list which lazy loads the items as needed
  // essentially, pagination.
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => Dismissible(
        // Dismissible exists to keep widgets uniquely identifiable
        // Like in a list of the same widgets with different data
        key: ValueKey(expenses[index]), // identify the specific widget expense by its index in the list
        background: Container(
          color: Theme.of(context).colorScheme.error.withOpacity(0.75),
          margin: EdgeInsets.symmetric(
            horizontal: Theme.of(context).cardTheme.margin!.horizontal,
          ),
        ),
        onDismissed: (direction) { // trigger the function which removes the data from the expense list
        // again referring to its index as the identifier
        // this way removing it both visually (in the UI by swiping it) and internally (in the data structure)
          onRemoveExpense(expenses[index]);
        },
        child: ExpenseItem(
          expenses[index],
        ),
      ),
    );
  }
}