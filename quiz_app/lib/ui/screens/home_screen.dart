import 'package:flutter/material.dart';
import 'package:quiz_app/ui/widgets/styled_text.dart';
import 'package:quiz_app/ui/widgets/quiz_button.dart';

// Accepts the switchScreen function as an argument from quiz.dart where it is defined
// This way the "Start Quiz" button can indirectly call it via this argument and change to
// the quiz screen, updating state and re-rendering the UI
class HomeScreen extends StatelessWidget {
  const HomeScreen(this.buttonColor, this.startQuiz, {super.key});

  final Color? buttonColor;
  final void Function() startQuiz;


  @override
  Widget build(context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/quiz-logo.png',
                  width: screenWidth * 0.7,
                  // can wrap this image element in an Opacity widget but its very performance intensive
                  color: const Color.fromARGB(150, 255, 255, 255)
                ),
                // Refactored padding into the widget itself
                // Padding (
                //   padding: const EdgeInsets.only(top: 20),
                //   child: const StyledText("Quiz app", 28),
                // )
                // Padding(
                //   padding: const EdgeInsets.only(top: 20),
                // ), // Extra room between the image and text
                SizedBox(height: 20,), // Best practice to use a SizedBox instead of Padding for space
                const StyledText("Learn Flutter the fun way!", 24),
                //const StyledText("Quiz App", 16), // Should be a button!
                QuizButton(buttonText: "Start Quiz", onPressed: startQuiz, backgroundColor: buttonColor),
              ],
            ),
          ),
        );
  }
}
