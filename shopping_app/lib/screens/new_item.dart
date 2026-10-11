import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:shopping_app/data/categories.dart';
import 'package:shopping_app/models/category.dart';

// import 'package:shopping_app/models/grocery_item.dart';

class NewItem extends StatefulWidget {
  const NewItem({super.key});

  @override
  State<NewItem> createState() => _NewItemState();
}

class _NewItemState extends State<NewItem> {
  final _formKey = GlobalKey<FormState>(); // GlobalKey is a generic

  // form fields
  var _enteredName = '';
  var _enteredQuantity = 1;
  var _selectedCategory = categories[Categories.vegetables]!;

  // loading (e.g gives the POST request time to send)
  var _isSending = false;

  // triggered when the add item button in the form is pressed
  // now async because the item gets POSTed to firebase and can't immediately generate a response
  void _saveItem() async {
    if (_formKey.currentState!.validate()) {
      // returns a bool (true only if all validators pass) - save only if this is the case
      _formKey.currentState!.save();
      setState(() {
        _isSending = true;
      });
      try {
        // posting to firebase to manage backend data
        final response = await http.post(
          // easier to build with https constructor, as the Uri constructor expects separate host, path, and scheme fields
          //Uri(path: 'https://flutter-shoppinglist-e58e1-default-rtdb.firebaseio.com/shopping-list.json'), // doesn't work like this
          Uri.https(
            'flutter-shoppinglist-e58e1-default-rtdb.firebaseio.com',
            'shopping-list.json',
          ),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(
            // easier to encode a map to json (GroceryItem does not have a .toJson() method)
            {
              // Firebase generates its own ID key
              //'id': DateTime.now().toString(),
              'name': _enteredName,
              'quantity': _enteredQuantity,
              // color is a repeating group for category since it depends on the category name
              // this can easily be retrieved here without having to store it
              'category': _selectedCategory.name,
            },
          ),
        );

        if (response.statusCode == 200) {
          //print(response.body);
          if (!context.mounted) {
            return;
          }
          Navigator.of(context).pop();
        }
      } catch (_) {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Could not add item. Please check your internet connection.',
            ),
          ),
        );
        Navigator.of(context).pop();
      }

      // data no longer stored locally in-memory
      // pops this screen and navigates back to the shopping screen, passing along the grocery item
      // Navigator.of(context).pop(
      //   GroceryItem(
      //     id: DateTime.now().toString(),
      //     name: _enteredName,
      //     quantity: _enteredQuantity,
      //     category: _selectedCategory,
      //   ),
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add a new item")),
      body: Padding(
        padding: const EdgeInsets.all(12),
        // using a Form widget, which is built into Flutter
        // has readily available features for validating user input, showing validation errors, etc
        // requires a child param to define what elements are inside the form
        child: Form(
          // tell Flutter to validate the form via global key
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                // instead of TextField as its integrated into the form and contains special params (eg validator)
                maxLength: 50,
                decoration: const InputDecoration(label: Text('Name')),
                // flutter needs to be told to trigger this validator
                validator: (value) {
                  // can return an error message if validation fails, or null if valid
                  if (value == null || value.isEmpty) {
                    return 'Please provide a name';
                  } else if (value.trim().length > 50 ||
                      value.trim().length <= 1) {
                    return 'Please keep the name between 1 and 50 characters';
                  }
                  return null;
                },
                // see the _formKey.currentState.save
                onSaved: (value) {
                  // redunant safety check - validator already takes care of this
                  // if (value == null) {
                  //   return;
                  // }
                  _enteredName = value!;
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Text fields should never be children of rows as they will expand horizontally to take all of the space
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(label: Text("Quantity")),
                      keyboardType: TextInputType.number,
                      // normal text fields dont support this param but form does!
                      initialValue: _enteredQuantity.toString(),
                      validator: (value) {
                        // can return an error message if validation fails, or null if valid
                        if (value == null || value.isEmpty) {
                          return 'Please provide a quantity';
                          // if the first case is false, the second case MUST be an integer (hence '!' so Flutter knows)
                        } else if (int.tryParse(value) == null ||
                            int.tryParse(value)! <= 0) {
                          return 'Please provide a valid quantity of at least 1';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        // can safely use parse (which throws if doesnt succeed) and '!'
                        // because at this point in the code the validator already succeeded
                        _enteredQuantity = int.parse(value!);
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: DropdownButtonFormField(
                      initialValue:
                          _selectedCategory, // this dropdown can never be null
                      items: [
                        for (final category in categories.entries)
                          DropdownMenuItem(
                            value: category.value,
                            child: Row(
                              children: [
                                Container(
                                  width: 16,
                                  height: 1,
                                  color: category.value.color,
                                ),
                                const SizedBox(width: 6),
                                Text(category.value.name),
                              ],
                            ),
                          ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          // required because the visible dropdown value should stay in sync with the selection
                          _selectedCategory = value!;
                        });
                      }, // called by Flutter every time user picks a different item, passes this value as input
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: _isSending
                        ? null
                        : () {
                            _formKey.currentState!
                                .reset(); // reset all input values
                          },
                    child: const Text('Reset'),
                  ),
                  ElevatedButton(
                    // disable the post while the current request is still sending to prevent double taps
                    // thank you logitech for the mouse double click issue...
                    onPressed: _isSending ? null : _saveItem,
                    child: _isSending
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(),
                          )
                        : const Text('Add Item'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
