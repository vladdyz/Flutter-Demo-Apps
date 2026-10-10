import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals_app/models/meal.dart';
import 'package:meals_app/providers/favourites_provider.dart';

class MealDetailsScreen extends ConsumerWidget {
  const MealDetailsScreen({super.key, required this.meal});

  final Meal meal;

  // riverpod requires a widgetref param in the build
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // watch the favourite meals provider to change the favorite icon based on state
    final favouriteMeals = ref.watch(favouriteMealsProvider);
    final isAlreadyFavourited = favouriteMeals.contains(meal);

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        // this now manages State because the user can toggle the meal item as a favourite
        // the state has to be lifted up to the tabs screen
        actions: [
          IconButton(
            onPressed: () {
              final wasAdded = ref
                  .read(favouriteMealsProvider.notifier)
                  .toggleMealFavouriteStatus(meal); // gives access to the notifier class within this provider and its method
              // to clearly communicate to the user when an item has been favourited/unfavourited
              ScaffoldMessenger.of(context).clearSnackBars(); // context is globally available because we're in a State object
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    wasAdded
                        ? 'Meal has been added to favourites'
                        : 'Meal is no longer a favourite',
                  ),
                ),
              );
            },
            // animate the changing favourites icon (implicit)
            // automatically detects when the child updates and plays the animation (much less code)
            // because the widget is always an icon, give it a key to indicate to flutter that the type of icon changes
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              // rotates the star icon
              transitionBuilder: (child, animation) {
                return RotationTransition(
                  // less rotation than the default (0-1) 
                  turns: Tween(begin: 0.8, end: 1.0).animate(animation),
                  child: child,
                );
              },
              child: isAlreadyFavourited
                  ? Icon(Icons.star)
                  : Icon(Icons.star_border, key: ValueKey(isAlreadyFavourited)),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        // for a scrollable column, no need to paginate it since won't have that much info
        child: Column(
          children: [
            // wrapped in a Hero element to establish connectivity with the hero wrapper in meal_item
            // this image will now animate between the screens!
            Hero(
              tag: meal.id,
              child: Image.network(
                meal.imageUrl,
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 15),
            Text(
              'Ingredients',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 14),
            // ingredients and steps are both lists of strings in the object
            // separate widgets can be used to avoid duplication for the title and loop, but its only two properties
            for (final ingredient in meal.ingredients)
              Text(
                ingredient,
                style: Theme.of(context).textTheme.bodyMedium!
                    .copyWith(color: Theme.of(context).colorScheme.onSurface),
              ),
            SizedBox(height: 24),
            Text(
              'Steps',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 14),
            for (final step in meal.steps)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 8.0,
                ),
                child: Text(
                  step,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium!
                      .copyWith(color: Theme.of(context).colorScheme.onSurface),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
