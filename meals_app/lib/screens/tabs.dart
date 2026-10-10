import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals_app/providers/filters_provider.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/main_drawer.dart';
import 'package:meals_app/providers/favourites_provider.dart';

// Global used to initially set all filters to false, and use as a fallback
const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

// Tab based navigation which requires its own screen and loads other screens as embedded screens (Categories, Favourites, etc...)
// ConsumerStatefulWidget is a stateful widget provided by Riverpod with added functionality to listen to providers and
// changes in the provider values (also works for ConsumerStatelessWidget)
class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  // everything state-related uses consumers now to access the Provider
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  // categories = 0, favourites = 1
  int _selectedPageIndex = 0;

  // updated app to use Riverpod so these are deprecated
  // final List<Meal> _favouriteMeals = [];
  // Map<Filter, bool> _selectedFilters = kInitialFilters;

  // moved to meal details screen where it is used via notifier
  // void _showInfoMessage(String message) {
  //   // to clearly communicate to the user when an item has been favourited/unfavourited
  //   ScaffoldMessenger.of(context).clearSnackBars(); // context is globally available because we're in a State object
  //   ScaffoldMessenger.of(context)
  //       .showSnackBar(SnackBar(content: Text(message)));
  // }

  // add (or remove!) a meal from the favourites list
  // the easiest function to create, but getting this to meal_details is a bit trickier!
  // the tabs screen doesn't have direct access to the meal_details screen...
  // and both categories and meals can be used to reach the end destination and would require this func
  // as a result, this would travel as an argument: tabs -> categories & meals -> meal details

  // Better way: make it accessible app-wide via Riverpod, deprecating this method
  // void _toggleMealFavouriteStatus(Meal meal) {
  //   final isExisting = _favouriteMeals.contains(meal);

  //   // in order for the screen to immediately update, toggling a favorite meal needs to set State
  //   if (isExisting) {
  //     setState(() {
  //       _favouriteMeals.remove(meal);
  //       _showInfoMessage("Meal is no longer a favourite");
  //     });
  //   } else {
  //     setState(() {
  //       _favouriteMeals.add(meal);
  //       _showInfoMessage("Meal has been added to favourites");
  //     });
  //   }
  // }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop(); // close the Drawer first
    if (identifier == 'filters') {
      // push returns a Future, which contains the map from filters (the enums mapped to the toggle bools)
      // at whatever point in the future when the user navigates back, hence the async/await and <> around push
      // since the push return is a map of enum (filter) and bool
      await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(builder: (ctx) => const FiltersScreen()),
      );
    }
    // we are already are on the meals screen/area of the app, just close the drawer
    // context once again available due to being in a State class
  }

  @override
  Widget build(BuildContext context) {
    // passes a list of filtered meals to categories (which filters further by category)
    // uses the filters (vegan, vegetarian, gluten/lactose-free) if set, otherwise unfiltered
    // obtains the meals from a provider now via riverpod as this extends ConsumerState now

    final availableMeals = ref.watch(filteredMealsProvider);

    Widget activePage = CategoriesScreen(availableMeals: availableMeals);
    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      // riverpod automatically extracts state propetty value from the notifier class that belongs to the provider
      // hence ref.watch() yields List<Meal> here
      final favouriteMeals = ref.watch(favouriteMealsProvider);
      activePageTitle = 'Your Favourites';
      activePage = MealsScreen(meals: favouriteMeals);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle), // depends on which tab is selected
      ),
      // Side drawers are quite common and also fortunately fully supported by Flutter!
      // Flutter also contains a Drawer widget if you don't want to create a custom widget
      drawer: MainDrawer(onSelectScreen: _setScreen),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        // have to tell this widget what tab is currently selected
        currentIndex: _selectedPageIndex, // controls which tab will be highlighted (current)
        onTap: (index) {
          _selectPage(index);
        },
        items: const [
          // every item in the bottom navigation bar requires an icon and can have a label
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favourites'),
        ],
      ), // bottom navbar officially supported by Flutter making this easier
    );
  }
}
