import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart'; // for iOS styles

import 'package:expense_tracker/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense)
  onAddExpense; // state managed by expenses.dart

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure; // for the dropdown, sets a default and updates when state is changed

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      // flutter has a built-in date picker
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    ); // note that this returns a Future object (e.g. a Promise) which can chain .then or be awaited
    // setState will only be executed once the awaited Future resolves (user picks a date)
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  // Refactored code into its own method, show the appropriate alert dialog depending on platform
  void _showDialog() {
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (ctx) => CupertinoAlertDialog(
          title: const Text('Invalid input'),
          content: const Text(
            'Please make sure a valid title, amount, date and category was entered.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx); // pop the error dialog when user confirms
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        // built-in Flutter function requiring context and a builder (see other show... functions)
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid input'),
          content: const Text(
            'Please make sure a valid title, amount, date and category was entered.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx); // pop the error dialog when user confirms
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );
    }
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(
      _amountController.text,
    ); // tryParse('Hello') => null, tryParse('1.12') => 1.12
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0; // if no amount is entered or is set to a negative value, show error
    if (_titleController.text
            .trim()
            .isEmpty || // all input fields must be valid to submit an expense
        amountIsInvalid ||
        _selectedDate == null) {
      // Depending on Android or iOS, show the appropriate dialogue
      _showDialog();

      return;
    }
    // if all good add the expense via onAddExpense -> _addExpense (expenses.dart)
    widget.onAddExpense(
      Expense(
        title: _titleController.text,
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory,
      ),
    );
    Navigator.pop(context);
  }

  // Destructor cleanup - make sure to dispose controllers at end of life cycle
  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  // Note: in landscape mode the modal for adding new expenses had to be visually redesigned because the keyboard popup for
  // field inputs made it impossible to visually access certain fields due to occupying too much of the available height
  @override
  Widget build(BuildContext context) {
    // to support responsive design
    // check if any elements are overlapping the UI from the bottom (e.g. a popup keyboard for input)
    final keyboardSpaceOccupation = MediaQuery.of(context).viewInsets.bottom;

    // instead of a media query, can rearrange the form input fields depending on device orientation via layoutbuilder
    // can access the constraints object now, which tells us which constraints are applied by the parent widget (min/max width/height)
    // can conditionally render layouts when you know exactly how much space you have to work with
    // LayoutBuilder is useful for creating layouts with widgets that only care about their parent and not necessarily the available
    // screen size, so in this instance a MediaQuery would have also been suitable
    return LayoutBuilder(
      builder: (ctx, constraints) {
        // render a different combo of widgets based on available width constraints defined by parent widget
        final width = constraints.maxWidth;
        // the contents of this form must also be scrollable because there isn't enough available vertical space
        // in landscape mode when the keyboard slides in from the bottom and the user can't reach the other input fields
        // wrapped the padding return root widget in a scrollable widget
        // this is still not visually ideal since the limited height restriction in landscape really restricts the UI
        // but at least the form is now functional and the user is able to reach all of the fields via scrolling

        // edit: the scrollview is now wrapped in a sizedbox so the modal window can be full screen when the
        // keyboard is not present
        return SizedBox(
          height: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              // EdgeInsets can no longer be const since its calculated dynamically
              padding: EdgeInsets.fromLTRB(
                16,
                16,
                16,
                keyboardSpaceOccupation + 16,
              ),
              child: Column(
                children: [
                  // special dart syntax available to use in lists (NO curly braces)
                  // note: since this now involves some code duplication (we display the same form input fields
                  // differently depending on portrait/landscape orientation) it would be best practice to make these
                  // widgets reusable in their own classes, because this bloated the code quite significantly
                  if (width >= 600)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Note: Expanded wrapper constrains the text fields which would otherwise use as much width as possible
                        Expanded(
                          child: TextField(
                            controller: _titleController,
                            maxLength: 50,
                            decoration: const InputDecoration(
                              // allows adding a label to the input
                              label: Text('Title'),
                            ),
                          ),
                        ),
                        const SizedBox(width: 24),
                        Expanded(
                          child: TextField(
                            controller: _amountController,
                            keyboardType:
                                TextInputType.number, // number only validation
                            decoration: const InputDecoration(
                              prefixText: '\$ ',
                              label: Text('Amount'),
                            ),
                          ),
                        ),
                      ],
                    )
                  else
                    TextField(
                      // flutter lets you configure this for specific expected inputs (emails, passwords, etc), really convenient
                      // can use onChanged here to register a function that triggers when user presses a key and enters an input
                      // or use a controller and create a controller instance in this class (see lines 17-18)
                      controller: _titleController,
                      maxLength: 50,
                      decoration: const InputDecoration(
                        // allows adding a label to the input
                        label: Text('Title'),
                      ),
                    ),
                  if (width >= 600)
                    Row(
                      children: [
                        DropdownButton(
                          // requires items (a list, hence the map to list) and an OnChanged function
                          value: _selectedCategory, // displays the currently selected dropdown value (or the default)
                          items: Category.values
                              .map(
                                (category) => DropdownMenuItem(
                                  value: category,
                                  child: Text(
                                    category.name.toUpperCase(), // using .name on an enum yields a string
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            // safety check if the user didn't select any of the dropdown options
                            // otherwise display the value they selected
                            if (value == null) {
                              return;
                            }
                            setState(() {
                              _selectedCategory = value;
                            });
                          },
                        ),
                        const SizedBox(height: 24),
                        Expanded(
                          child: Row(
                            // align to the right side and align the content vertically
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                _selectedDate == null
                                    ? 'No date selected'
                                    : formatter.format(_selectedDate!), // selectedDate could possibly be null, but not in this instance (hence '!') because of the ternary
                              ),
                              IconButton(
                                onPressed: _presentDatePicker,
                                icon: const Icon(Icons.calendar_month),
                              ),
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
                            keyboardType:
                                TextInputType.number, // number only validation
                            decoration: const InputDecoration(
                              prefixText: '\$ ',
                              label: Text('Amount'),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Row(
                            // align to the right side and align the content vertically
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                _selectedDate == null
                                    ? 'No date selected'
                                    : formatter.format(_selectedDate!), // selectedDate could possibly be null, but not in this instance (hence '!') because of the ternary
                              ),
                              IconButton(
                                onPressed: _presentDatePicker,
                                icon: const Icon(Icons.calendar_month),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 16),
                  if (width >= 600)
                    Row(
                      children: [
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(
                              context,
                            ); // remove the overlay from the screen
                          },
                          child: const Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: _submitExpenseData,
                          child: const Text('Save Expense'),
                        ),
                      ],
                    )
                  else
                    Row(
                      children: [
                        DropdownButton(
                          // requires items (a list, hence the map to list) and an OnChanged function
                          value: _selectedCategory, // displays the currently selected dropdown value (or the default)
                          items: Category.values
                              .map(
                                (category) => DropdownMenuItem(
                                  value: category,
                                  child: Text(
                                    category.name.toUpperCase(), // using .name on an enum yields a string
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            // safety check if the user didn't select any of the dropdown options
                            // otherwise display the value they selected
                            if (value == null) {
                              return;
                            }
                            setState(() {
                              _selectedCategory = value;
                            });
                          },
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(
                              context,
                            ); // remove the overlay from the screen
                          },
                          child: const Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: _submitExpenseData,
                          child: const Text('Save Expense'),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
