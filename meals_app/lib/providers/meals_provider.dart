import 'package:flutter_riverpod/flutter_riverpod.dart';
//import 'package:flutter_riverpod/legacy.dart';
import 'package:meals_app/data/dummy_data.dart';

// using Riverpod for cross-widget state management (tracking favorite meals)
// any widget can access this Provider via a Consumer

// this is quite a straightforward provider as the data here is static and never changes
final mealsProvider = Provider(
  // needs a provider ref method, return the value we want to provide
  (ref) {
    return dummyMeals;
  },
);
