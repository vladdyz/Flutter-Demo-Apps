import 'package:flutter/material.dart';
import 'dart:math';

// randomizer object for the dice roll
final randomizer = Random();


// The stateful parts of gradient_container moved into a separate class
// Manages the dice roller when clicking a button in the UI
class DiceRoller extends StatefulWidget {
  const DiceRoller({super.key}); // forward to StatefulWidget
  // note this can be const even though the StatefulWidget internally changes by definition
  // this is due to the separation between this and the below private class
  // Flutter makes sure that the state (below) can change, but the widget remains constant

  @override // similar to build, overrides the default widget class implementation
  State<DiceRoller> createState() {
    // returns a State object for the DiceRoller class
    return _DiceRollerState();

  }

}

// when using stateful widget, will always work with two classes
// convention is to lead with underscore, use original classname, and append State at the end
// the _ has a special meaning: PRIVATE CLASS
// only meant to be internally by the DiceRoller widget class
class _DiceRollerState extends State<DiceRoller> {

  // moved from gradient_container, which can now be const
  var diceRoll = 2; // can change to any of the other dice images when user interacts with app
                                                    // because this is mutable, the GradientContainer class constructor can no longer be const
                                                    // update: disconnected from GradientController

  void rollDice() {
    // switch dice images when button is clicked
    // flutter needs to re-execute the build method when any changes to the dice image are detected
    // if the build method below is not executed, the UI doesn't update
    // to re-render the widget below, need to call a special function
    setState(() {
      // this is a bit inefficient since a new random object is being created in the line below each time it is executed
      //diceRoll = Random().nextInt(6) + 1; // max value is excluded

      // create the random object once (outside of the class, making it globally available) and reference it instead of creating a new one
      diceRoll = randomizer.nextInt(6) + 1;

      // setState is available in any class which extends state
      // informs Flutter that the app UI needs to be updated where needed
    });
    
  }

  // Stateful widgets split into two classes, Flutter requires them to be detached from each other
  // build method works just like the StatelessWidget 
  // note this class uses a default constructor
  @override
  build(context) {
    // returns widget tree
    // moved from GradientController
    return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/dice-$diceRoll.png',
              width: 200,
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: rollDice,
              style: TextButton.styleFrom(
                // padding: const EdgeInsets.only(
                //   top: 20,
                // ),
                foregroundColor: Colors.white,
                textStyle: const TextStyle(
                  fontSize: 28,
                ),
              ),
              child: const Text('Roll Dice'),
            )
          ],
        );

  }
}