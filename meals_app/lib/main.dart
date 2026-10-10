import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:google_fonts/google_fonts.dart';
//import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/tabs.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 131, 57, 0),
  ),
  textTheme: GoogleFonts.latoTextTheme(),
);

void main() {
  // need to wrap app in riverpod provider scope as it uses it for cross-widget state management now
  // all parts of the app can use riverpod features now as the entire App is wrapped
  runApp(const ProviderScope(child: App()));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      // Added tab-based navigation to the app
      //home: const CategoriesScreen(),
      home: const TabsScreen(),
    );
  }
}
