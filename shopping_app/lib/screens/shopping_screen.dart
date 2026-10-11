import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_app/data/categories.dart';
//import 'package:shopping_app/models/category.dart';

import 'package:shopping_app/models/grocery_item.dart';
import 'package:shopping_app/screens/new_item.dart';
import 'package:shopping_app/widgets/shopping_list.dart';

class ShoppingScreen extends StatefulWidget {
  const ShoppingScreen({super.key});

  @override
  State<ShoppingScreen> createState() => _ShoppingScreenState();
}

class _ShoppingScreenState extends State<ShoppingScreen> {
  List<GroceryItem> _groceryItems = [];
  var _isLoading = true;
  String _error = '';

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  void _loadItems() async {
    final http.Response response;
    try {
      response = await http.get(
        Uri.https(
          'flutter-shoppinglist-e58e1-default-rtdb.firebaseio.com',
          'shopping-list.json',
        ),
      );
    } catch (_) {
      setState(() {
        _isLoading = false;
        _error = 'Failed to fetch data! Please check your internet connection';
      });
      return;
    }
    // safety in case a non-200 response is returned otherwise the code below can throw
    // note: firebase returns null as a string value
    if (response.statusCode >= 400) {
      setState(() {
        _isLoading = false;
        _error = 'Failed to fetch data! Please try again later';
      });
      return;
    }
    // the reason this was separated into its own check is because deleting all items from the shopping list
    // is another viable way to get the null response, which is not a result of a fetch error
    if (response.body == 'null') {
      setState(() {
        _groceryItems = [];
        _isLoading = false;
      });
      return;
    }
    // need to parse the response json data
    final Map<String, dynamic> shoppingData = json.decode(response.body);
    final List<GroceryItem> loadedItems = []; // temporary list
    for (final item in shoppingData.entries) {
      final category = categories.entries
          .firstWhere((cat) => cat.value.name == item.value['category'])
          .value;
      loadedItems.add(
        GroceryItem(
          id: item.key,
          name: item.value['name'],
          quantity: item.value['quantity'],
          category: category,
        ),
      );
    }
    //if (loadedItems.isNotEmpty) {
    setState(() {
      _groceryItems = loadedItems;
      _isLoading = false;
      _error = '';
    });
    //}
  }

  // to navigate via appbar
  void _addItem() async {
    // always forget that you cant push directly to the screen class and need to use material page route...
    // push yields a future that holds the data that may be returned by the screen which you pushed onto the stack of screens
    // eventually expects a GroceryItem (or null, if nothing was added)
    await Navigator.of(context)
        .push<GroceryItem>(MaterialPageRoute(builder: (ctx) => NewItem()));

    _loadItems();

    // no longer using in-memory db and assigning the await... to a final newItem

    // if (newItem == null) {
    //   return;
    // }

    // setState(() {
    //    _groceryItems.add(newItem);
    // });
  }

  // this is actually called via dismissible in the shopping list widget
  // lifted up to here as shopping list does not manage state and to keep the organization clean
  void _removeItem(GroceryItem item) async {
    // https://flutter-shoppinglist-e58e1-default-rtdb.firebaseio.com/shopping-list/<ITEM_ID>.json
    final deleteItemUrl = Uri.https(
      'flutter-shoppinglist-e58e1-default-rtdb.firebaseio.com',
      'shopping-list/${item.id}.json',
    );
    // in case an undo is needed in the UI due to backend deletion failure
    final index = _groceryItems.indexOf(item);

    setState(() {
      _groceryItems.remove(item);
    });
    try {
      // no need to async/await this since we can just remove it from the local list before the response
      // and the data gets fetched during initstate anyway
      // however, need to catch errors to prevent data inconsistency in the UI (if delete fails for any reason)
      // this does require async/await as the request response is needed
      final response = await http.delete(
        deleteItemUrl,
      ); // this could potentially throw but it won't be app breaking
      if (response.statusCode >= 400) {
        setState(() {
          _groceryItems.insert(index, item);
        });
        // display a brief snackbar error message to inform the user why the UI change has been reverted
        // the mounted check is due to using context after an await to avoid lint issues
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not delete ${item.name}. Please try again.'),
          ),
        );
      }
    } catch (_) {
      setState(() {
        _groceryItems.insert(index, item);
      });
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Something went wrong. Please check your internet connection.',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [IconButton(onPressed: _addItem, icon: const Icon(Icons.add))],
      ),
      body: _error.isNotEmpty
          ? Center(child: Text(_error))
          : _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ShoppingList(groceries: _groceryItems, onRemoveItem: _removeItem),
    );
  }
}
