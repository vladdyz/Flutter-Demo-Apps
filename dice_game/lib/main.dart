import 'package:flutter/material.dart';

import 'package:dice_game/ui/widgets/gradient_container.dart';

void main() {
  runApp(
    // Root app required by most other widgets, Google's Material Design 3. Does a lot of UI setup, takes a long list of named parameters
    const MaterialApp(
      // the scaffold widget implements basic material design visual layout structure, helps set up a good screen for the app. Needs a body arg.
      home: Scaffold(
        body: GradientContainer(
          Color.fromARGB(255, 33, 5, 109),
          Color.fromARGB(255, 68, 21, 149),
        ),
      ),
    ),
  );
}