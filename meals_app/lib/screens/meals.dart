import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/meal_details.dart';
import 'package:meals_app/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({super.key, this.title, required this.meals});

  final String?
  title; // see return at bottom, conditional based on how this class is used
  final List<Meal> meals;

  // get the selected meal as an output to pass this into meal item
  void selectMeal(BuildContext context, Meal meal) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (ctx) => MealDetailsScreen(meal: meal)));
  }

  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
      itemCount: meals.length,
      itemBuilder: (ctx, index) =>
          MealItem(meal: meals[index], onSelectMeal: selectMeal),
    );
    // If no meals for the specific category / filter are found, the content should reflect this to the user
    if (meals.isEmpty) {
      content = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Uh oh... nothing here!',
              style: Theme.of(context).textTheme.headlineLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onSurface),
            ),
            const SizedBox(height: 16),
            Text(
              'Try selecting a different category!',
              style: Theme.of(context).textTheme.bodyLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onSurface),
            ),
          ],
        ),
      );
    }
    // Because this can be accessed through the tab navigation (which provides its own Title, Scaffold, and AppBar)
    if (title == null) {
      return content;
    } else {
      return Scaffold(
        appBar: AppBar(title: Text(title!)),
        body: content,
      );
    }
  }
}
