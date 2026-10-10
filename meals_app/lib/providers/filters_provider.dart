import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:meals_app/providers/meals_provider.dart';

// need to map these to the filters on the screen to be used in a callback
enum Filter { glutenFree, lactoseFree, vegetarian, vegan }

class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  FiltersNotifier()
    : super({
        Filter.glutenFree: false,
        Filter.lactoseFree: false,
        Filter.vegetarian: false,
        Filter.vegan: false,
      });

  // get the filter to toggle and check if its currently active
  void setFilter(Filter filter, bool isActive) {
    // once again, state is immutable and must be COPIED - not edited!
    state = {...state, filter: isActive};
  }

  void setFilters(Map<Filter, bool> chosenFilters) {
    state = chosenFilters;
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filter, bool>>(
      (ref) => FiltersNotifier(),
    );

// Second related provider that filters available meals based on the set filter options
// Originally this was implemented as a conditional/switch in tabs.dart and passed the filtered list to categories
// for further category filtering, which worked fine but was less ideal as the list went through two separate layers of filtering

// This provider also depends on the filtersProvider (dynamic) and meals provider (static)
// Does this via ref argument, which automatically by riverpod is the same ref object from other widgets
final filteredMealsProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final activeFilters = ref.watch(filtersProvider);
  return meals.where((meal) {
    if (activeFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
      return false;
    } else if (activeFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
      return false;
    } else if (activeFilters[Filter.vegetarian]! && !meal.isVegetarian) {
      return false;
    } else if (activeFilters[Filter.vegan]! && !meal.isVegan) {
      return false;
    } else {
      return true;
    }
  }).toList(); // return a list, not an iterable
});
