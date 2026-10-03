import 'package:flutter/material.dart';
import 'package:dice_game/ui/widgets/dice_roller.dart';


// alignment vars defined at top level for easy access (if need to change later)
const startAlignment = Alignment.topLeft;
const endAlignment = Alignment.bottomRight;

// Moved to its own separate module and made into a class for better 
// readability & maintainability as the widget tree was growing large

// This widget must be stateful because it has internally changing data (the dice)
// this data will change over time and impact the rendered UI
// when the dice changes, the UI changes, and state must be tracked
// however the majority of this widget does not change, just the image and button
// Solution: Break up the code into modular chunks, with the majority being stateless 
// and the dice/button part being stateful and moved into its own dart implementation
// With this we can also improve performance by maintaining the const for this class
class GradientContainer extends StatelessWidget {
  // constructor 
  const GradientContainer(this.color1, this.color2, {super.key});

  // accepts two colors (color1&color2 params) to create a gradient else defaults to deep purple and indigo
  const GradientContainer.purple({super.key})
      : color1 = Colors.deepPurple,
        color2 = Colors.indigo;
  // Lists by default can be edited even if they're final, instead using an alternative approach to accept 2 individual colors
  final Color color1;
  final Color color2;

  // important to override the default widget class 
  @override
  Widget build(context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color1, color2],
          begin: startAlignment,
          end: endAlignment,
        ),
      ),
      child: Center(
        child: DiceRoller(),
        // child: Column(
        //   mainAxisSize: MainAxisSize.min,
        //   children: [
        //     Image.asset(
        //       activeDiceImage,
        //       width: 200,
        //     ),
        //     const SizedBox(height: 20),
        //     TextButton(
        //       onPressed: rollDice,
        //       style: TextButton.styleFrom(
        //         // padding: const EdgeInsets.only(
        //         //   top: 20,
        //         // ),
        //         foregroundColor: Colors.white,
        //         textStyle: const TextStyle(
        //           fontSize: 28,
        //         ),
        //       ),
        //       child: const Text('Roll Dice'),
        //     )
        //   ],
        // ),
      ),
    );
  }
}
