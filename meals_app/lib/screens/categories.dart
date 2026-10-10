import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/category.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/category_grid_item.dart';

// Converted to a stateful widget when adding explicit animations to the category grid items
// Animations set state and update ui for as long as they're playing
// Really easy to do by simply right clicking and refactoring, thanks Flutter!
class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key, required this.availableMeals});

  final List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

// with allows mixins (merging another class to access certain features)
// the ticker provides features needed for Flutter's animation system
// (also supports multiple animation controllers with TicketProviderStateMixin)
class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  // must be set before the build method execute, but doesn't have an initial value (will have one when needed!)
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this, // required, responsible for making sure the anim executes for every frame (uses the ticker)
      duration: Duration(milliseconds: 400),
      // these are defaults, only explictly set for learning purposes (Flutter assumes them if not included)
      lowerBound: 0,
      upperBound: 1,
    );

    // need to explictly start the animation
    _animationController.forward(); // starts the anim from beginning to end unless stopped (does not repeat)
  }

  // controllers require cleanup
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // dont want to update state here, but instead load the category screen
  void _selectCategory(BuildContext context, Category category) {
    // identify which category was selected and filter only the items belonging to it
    final filteredMeals = widget.availableMeals
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

    // listen to animations and update parts (or all) of the UI as needed
    return AnimatedBuilder(
      animation: _animationController,
      child: GridView(
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
      ),
      // the animated value to be re-rendered every tick (the child), uses the upper and lower bound

      // old manual example of sliding the category grid up

      // builder: (context, child) => Padding(
      //   // need to slide up not down (from 100 to 0)
      //   padding: EdgeInsets.only(top: 100 - _animationController.value * 100),
      //   child: child,
      // ),

      // better
      builder: (context, child) => SlideTransition(
        position: Tween(
          // position wants offset values
          // offset is between 0 (0%) and 1 (100%)
          begin: const Offset(0, 0.4),
          end: const Offset(0, 0), // end at actual position the GridView would normally have
        ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut)),
        child: child,
      ),
    );
    //);
  }
}
