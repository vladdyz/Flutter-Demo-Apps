import 'package:flutter/material.dart';
import 'package:shopping_app/models/grocery_item.dart';

class ShoppingList extends StatelessWidget {
  const ShoppingList({
    super.key,
    required this.groceries,
    required this.onRemoveItem,
  });

  final List<GroceryItem> groceries;
  final void Function(GroceryItem item) onRemoveItem;

  @override
  Widget build(BuildContext context) {
    if (groceries.isNotEmpty) {
      // using listview instead of a row for better performance optimization and cleaner build
      return ListView.builder(
        itemCount: groceries.length,
        // Dismissible allows the user to swipe these out of the list
        itemBuilder: (ctx, index) => Dismissible(
          onDismissed: (direction) {
            onRemoveItem(groceries[index]);
          },
          key: ValueKey(groceries[index].id),
          child: ListTile(
            leading: Container(
              width: 24,
              height: 24,
              color: groceries[index].category.color,
            ),
            title: Text(groceries[index].name),
            trailing: Text(groceries[index].quantity.toString()),
          ),
        ),
      );
    } else {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text("Your shopping list is currently empty."),
            ),
            SizedBox(height: 6),
            Icon(Icons.sentiment_dissatisfied),
            SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text('Would you like to add some items?'),
            ),
          ],
        ),
      );
    }
  }
}
