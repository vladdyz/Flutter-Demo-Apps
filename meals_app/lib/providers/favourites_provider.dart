//import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:meals_app/models/meal.dart';

// the data here is dynamic, so using StateNotifierProvider instead of Provider as it is
// optimized for changing data
class FavouriteMealsNotifier extends StateNotifier<List<Meal>> {
  FavouriteMealsNotifier() : super([]); // initial data (empty list)

  // methods to edit the

  bool toggleMealFavouriteStatus(Meal meal) {
    // add or remove meals in favourites

    // cant directly call .add or .remove on the list or change it, have to replace it
    // state contains the list of meals
    final mealIsFavourited = state.contains(meal);
    if (mealIsFavourited) {
      // where gives a new list, doesn't edit the existing list (which is immutable)
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      // create a new list using the elements from the existing list + the new favourite meal
      state = [...state, meal];
      return true;
    }
  }
}

final favouriteMealsProvider =
    StateNotifierProvider<FavouriteMealsNotifier, List<Meal>>((ref) {
      return FavouriteMealsNotifier();
    });
