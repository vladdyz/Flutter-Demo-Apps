import 'package:flutter/material.dart';

import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expense_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/chart/chart.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

// dummy data examples
class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Flutter Course',
      amount: 19.99,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: 'Cinema',
      amount: 15.69,
      date: DateTime.now(),
      category: Category.leisure,
    ),
  ];

  void _openAddExpenseOverlay() {
    // Built-in show feature to show UI elements, such as a modal window overlay with a transparent backdrop (clicking on this closes the modal)
    // context and builder are required, context wants a build context (from the build method)
    // this object is globally available by Flutter since we're in a class that extends State
    // context is widget metadata/info on the widget's relation to other widgets in UI and overall widget tree
    // builder args always mean that you must provide a function as a value, in this case
    // this function should return a widget and has an input value passed into it that calls this builder function
    // when it tries to call this modal sheet (can hover over these props for more info)
    showModalBottomSheet(
      isScrollControlled: true,
      useSafeArea: true, // simple feature built into Flutter that makes sure the UI stays away from areas the device uses
                        // for things like the camera etc. Normally Flutter takes care of this by default for most things
                        // Flutter takes a look at the device running the app and evaluates how much space is "safe"
      context: context,
      builder: (ctx) => NewExpense(onAddExpense: _addExpense),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    // Scaffold messenger is a utility object offered by flutter to show snackbar messages
    // in either the top or bottom in the UI (and other things)
    // in this instance it displays a confirmation info message after an item has been removed
    ScaffoldMessenger.of(context).clearSnackBars(); // only display one info message at a time, clear the previous first
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(
          seconds: 3,
        ), // dont want the confirmation to persist, just show it temporarily
        content: const Text('Expense deleted.'),
        // the snackbar action allows the user to undo the deletion and re-insert the expense into the list in its prior position
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(
                expenseIndex,
                expense,
              ); // insert the expense back to its original index
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    Widget mainContent = const Center(
      child: Text('No expenses found. Start adding some!'),
    );

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Expense Tracker'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay, // opens the modal window
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      // If in landscape mode, use a Row instead of a column to take up the width
      body: width > 600
          ? Row(
              children: [
                // The chart tries to use width = infinity, which will affect this parent UI as the Row also attempts this
                // Expanded constrains the chart child to only take as much width as available in the row
                // after sizing the other row children, so it can be used to constrain the chart
                // Also important for vertically unconstrained elements like Column and ListView which will attempt to take up
                // infinite height if not constrained by their parent widget
                Expanded(child: Chart(expenses: _registeredExpenses),),
                Expanded(child: mainContent),
              ],
            )
          : Column(
              children: [
                Chart(expenses: _registeredExpenses),
                Expanded(child: mainContent),
              ],
            ),
    );
  }
}
