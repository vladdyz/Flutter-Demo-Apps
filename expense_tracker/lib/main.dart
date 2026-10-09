import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';

import 'package:expense_tracker/widgets/expenses.dart';

// Conventionally, global variables (especially theme-related) are prefixed by 'k'
var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 96, 59, 181),
);

var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 5, 99, 125),
);

void main() {
  // Ensure the app runs only in portrait mode (landscape orientation makes the UI looks terrible)
  // SystemChrome returns a Future so the runApp needs to be chained to it via .then

  // Update: Created a responsive layout for the landscape orientation instead of locking out the user
  // WidgetsFlutterBinding.ensureInitialized(); // making sure that locking the orientation and running the app works as intended
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
  //     .then((fn) {
        runApp(
          MaterialApp(
            // Don't pass anything into ThemeData(), simply call copyWith on it
            // this way can preserve the default styles and override selected styles with custom implementations
            // and not have to build entire themes from scratch
            darkTheme: ThemeData.dark().copyWith(
              // easiest way to apply colors to many widgets w/o setting a bunch of colors individually
              // is to set up a color scheme and use it as a basis for other widget colors
              colorScheme: kDarkColorScheme,
              // Flutter 3.27 & up changed ThemeData.cardTheme to expect a CardThemeData, not a CardTheme
              cardTheme: const CardThemeData().copyWith(
                color: kDarkColorScheme.secondaryContainer,
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  backgroundColor: kDarkColorScheme.primaryContainer,
                  foregroundColor: kDarkColorScheme.onPrimaryContainer,
                ),
              ),
            ),
            theme: ThemeData().copyWith(
              colorScheme: kColorScheme,
              appBarTheme: const AppBarTheme().copyWith(
                backgroundColor: kColorScheme.onPrimaryContainer,
                foregroundColor: kColorScheme.primaryContainer,
              ),
              cardTheme: const CardThemeData().copyWith(
                color: kColorScheme.secondaryContainer,
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  backgroundColor: kColorScheme.primaryContainer,
                ),
              ),
              textTheme: ThemeData().textTheme.copyWith(
                titleLarge: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: kColorScheme.onSecondaryContainer,
                  fontSize: 16,
                ),
              ),
            ),
            // themeMode: ThemeMode.system, // default
            home: const Expenses(),
          ),
        );
      // });
}
