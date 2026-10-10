import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/category.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/category_grid_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key, required this.availableMeals});

  final List<Meal> availableMeals;

  // dont want to update state here, but instead load the category screen
  void _selectCategory(BuildContext context, Category category) {
    // identify which category was selected and filter only the items belonging to it
    final filteredMeals = availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    // push wants a context and route, pushes the route (a widget) on top of the current
    // stack of screens
    // context is not globally available because this is a stateless widget
    // this function is passed into CategoryGridItem and connected to the onTap property of each grid item in the Inkwell
    // alternate way of wring this: Navigator.of(context).push(route);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) =>
            MealsScreen(title: category.title, meals: filteredMeals),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(title: const Text('Pick your category')),
    //   // Flutter easily lets you layout UI in a grid of items
    //   body: GridView(

    // This is now nested and managed in the Tabs.dart screen tab bar which has its own Scaffold and AppBar
    // Therefore the title (and AppBar) should not be duplicated
    return GridView(
      padding: EdgeInsets.all(24),
      // 2 Items per row in the grid / 2 Columns of Items
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.5, // 3 / 2 aspect ratio
        crossAxisSpacing: 20, // spacing between columns
        mainAxisSpacing: 20, // spacing between rows
      ),
      children: [
        for (final category in availableCategories)
          CategoryGridItem(
            category: category,
            onSelectCategory: () {
              _selectCategory(context, category);
            },
          ),
      ],
    );
    //);
  }
}
